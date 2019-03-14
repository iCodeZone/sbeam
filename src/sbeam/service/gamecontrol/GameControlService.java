package sbeam.service.gamecontrol;

import com.opensymphony.xwork2.ActionContext;
import com.sun.deploy.security.ValidationState;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import sbeam.dao.developer.IIndividualDeveloperDAO;
import sbeam.dao.developer.ITeamDeveloperDAO;
import sbeam.dao.developer.IndividualDeveloperDAO;
import sbeam.dao.developer.TeamDeveloperDAO;
import sbeam.dao.gamecontrol.GameControlDAO;
import sbeam.dao.gamecontrol.IGameControlDAO;
import sbeam.po.collection.GameCollection;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.evaluate.Evaluate;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;
import sbeam.po.order.Order;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

public class GameControlService implements IGameControlService {
    //私有依赖项DAO
    private IGameControlDAO gameControlDAO;
    //私有DAO的注入
    public void setGameControlDAO(IGameControlDAO gameControlDAO) {
        this.gameControlDAO = gameControlDAO;
    }


    //session作用域
    ActionContext ctx;
    Map<String, Object> session;

    //上传游戏
    public void gameupload(File[] upload, String [] uploadContentType, String [] uploadFileName, Game game,Integer type,Integer [] slecttypes){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");

        //判空
        if(game.getName()==null || game.getName().isEmpty()){
            session.put("tip","游戏名不能为空，请重试！");
            return;
        }
        if(upload==null){
            session.put("tip","文件不能为空，请重试！");
            return;
        }
        //判断是否有多个安装文件
        int flag = 0;
        for(int i=0;i<uploadContentType.length;i++){
            if(uploadContentType[i].contains("application")){
                flag+=1;
            }
        }
        if(flag==0){
            session.put("tip","您未上传游戏安装包！");
            return;
        }
        if(flag>1){
            session.put("tip","您上传了多个游戏安装包！");
            return;
        }
        //默认填值
        if(game.getDeveloperPrice()==null){
            game.setDeveloperPrice(0.0);
        }

        List types = (List)session.get("types");  //获取类型列
        Boolean utype;                            //用于标记开发者类型
        Integer uid;                              //用于获取ID
        Boolean check;                            //身份验证是否已通过
        if(type==1){  //个人开发者
            utype=false;
            uid=((IndividualDeveloper)session.get("indiDeve")).getId();
            check=((IndividualDeveloper)session.get("indiDeve")).getCheck();
        }
        else{
            utype=true;
            uid=((TeamDeveloper)session.get("teamDeve")).getId();
            check=((TeamDeveloper)session.get("teamDeve")).getCheck();
        }

        //核验是否通过审核
        if(!check){
            session.put("tip","抱歉，您的身份未通过核验，不能上传游戏！");
        }
        else if(check==null){
            session.put("tip","抱歉，您的身份还未核验，不能上传游戏！");
        }

        //用于给pic重命名
        int picnum = 1;

        for(int i=0;i<upload.length;i++) {
            System.out.println(uploadContentType[i]);
            String path="/upload/game/" + game.getName();   //存储基础路径

            //判重复
            String hql = "from Game as game where name='"+game.getName()+"'";
            List temg = gameControlDAO.findByHql(hql);
            if(temg.size()!=0){
                session.put("tip","游戏名已存在，请重新输入！");
                return;
            }

            //根据不同文件类型存储不同位置
            if(uploadContentType[i].contains("application")){
                path+="/package";
            }
            else if(uploadContentType[i].contains("text")){
                uploadFileName[i] = "describe.txt";
                path+="/describe";
            }
            else if(uploadContentType[i].contains("video")){
                uploadFileName[i] = "1.mp4";
                path+="/video";
            }
            else if(uploadContentType[i].contains("image")){
                uploadFileName[i] = picnum+".png";
                picnum++;
                path+="/pictures";
            }
            else break;
            //System.out.println("path:"+path);
            //获取要保存文件夹的物理路径(绝对路径)
            String realPath = ServletActionContext.getServletContext().getRealPath(path);
            File file = new File(realPath);

            //测试此抽象路径名表示的文件或目录是否存在。若不存在，创建此抽象路径名指定的目录，包括所有必需但不存在的父目录。
            if (!file.exists())
                file.mkdirs();

            try {
                //保存文件
                FileUtils.copyFile(upload[i], new File(file, uploadFileName[i]));
            } catch (IOException e) {
                session.put("tip","异常，上传失败，请重试！");
                e.printStackTrace();
            }
        }

        Game ga = new Game();
        ga.setType(utype);
        ga.setDeveloperId(uid);
        ga.setUpdatedate(new Date());
        ga.setName(game.getName());
        ga.setDir("/upload/game/"+game.getName());
        ga.setDeveloperPrice(game.getDeveloperPrice());
        //ga.setCheck(false);
        //ga.setGround(false);
        ga.setGpv(0);
        Set<GameType> typess = new HashSet<GameType>(0);
        for(int i=0;i<slecttypes.length;i++){
            typess.add((GameType) types.get(slecttypes[i]-1));
        }
        ga.setTypes(typess);
        gameControlDAO.save(ga);
        session.put("tip","上传成功");
    }

    //获取所有游戏类型
    public void getalltype(Integer type){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        session.put("type",type);
        try{
            String hql = "from GameType as gameType";
            List types = gameControlDAO.findByHql(hql);
            session.put("types",types);

        }
        catch(Exception e){
            e.getStackTrace();
        }
    }

    //删除游戏
    public void delgame(Game game){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        Game temg = gameControlDAO.get(game.getId());
        //从数据库删除相关记录
        try{
            ///获取对应的订单
            String hql = "from Order as order where gid ='"+temg.getId()+"'";
            List<Order> orders = gameControlDAO.findByHql(hql);
            //获取对应的收藏
            hql = "from GameCollection as collection where gid = '"+temg.getId()+"'";
            List<GameCollection> collections = gameControlDAO.findByHql(hql);
            //删除外键约束的订单
            for(int i=0;i<orders.size();i++){
                gameControlDAO.delOrder(orders.get(i));
            }
            //删除外键约束的收藏
            for(int i=0;i<collections.size();i++){
                gameControlDAO.delCollect(collections.get(i));
            }
            gameControlDAO.del(temg);
        }
        catch (Exception e){
            session.put("tip","抱歉，删除失败!");
            e.getStackTrace();
        }

        //删除服务器端的文件
        File gamefile = new File(ServletActionContext.getServletContext().getRealPath(temg.getDir()));
        //游戏总目录
        if(!gamefile.isFile() && gamefile.exists()){
            //总目录下各个文件夹
            File [] childfiles = gamefile.listFiles();
            for(int j=0;j<childfiles.length;j++){
                //是文件夹的话
                if(!childfiles[j].isFile()){
                    //每一个文件
                    File [] files = childfiles[j].listFiles();
                    for(int i=0;i<files.length;i++){
                        files[i].delete();
                    }
                }
                //删除子文件夹
                childfiles[j].delete();
            }
            //删除总的游戏文件夹
            gamefile.delete();
        }

        //存储提示信息
        session.put("tip","恭喜你，删除成功！");
        //更新session中的games
        List games = (List)session.get("games");
        for(int i=0;i<games.size();i++){
            if(((Game)games.get(i)).getId()==temg.getId()){
                games.remove(i);
                break;
            }
        }
    }

    //上传游戏的新版本
    public void uploadnewversion(File upload,String uploadContentType,String uploadFileName,Game game){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");

        if(!uploadContentType.contains("application")){
            session.put("tip","上传类型错误！");
            return;
        }

        try{
            Game temgame = gameControlDAO.get(game.getId());
            String realpath = ServletActionContext.getServletContext().getRealPath(temgame.getDir());
            File old = new File(realpath+"/package");
            //删除旧文件
            if(!old.isFile() && old.exists()){
                File []files = old.listFiles();
                for(int i=0; i<files.length;i++){
                    System.out.println(files[i]);
                    files[i].delete();
                }
            }

            //不存在则创建新文件夹
            if (!old.exists())
                old.mkdirs();

            //放入新文件
            FileUtils.copyFile(upload, new File(old, uploadFileName));
            //若核验状态为已核验时需要设为未核验重新核验及下架
            if(temgame.getCheck()!=null && temgame.getCheck()==true){
                temgame.setGround(false);
                temgame.setCheck(false);
                temgame.setCtime(null);
                gameControlDAO.update(temgame);
            }
            session.put("tip","上传新版本成功！");
        }
        catch (Exception e){
            session.put("tip","出现异常，请重试！");
        }
    }

    //获取游戏相关文件
    public void gamefiles(Game game){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        Game temgame = gameControlDAO.get(game.getId());
        List files = new ArrayList();
        String realpath = ServletActionContext.getServletContext().getRealPath(temgame.getDir());
        File file = new File(realpath);
        //游戏下四大文件夹
        File [] filess = file.listFiles();
        for(int i=0;i<filess.length;i++){
            if(!filess[i].isFile() && !filess[i].toString().contains("package")){   //并不展示游戏包
                //每个文件夹下的每个文件
                File []temfiles = filess[i].listFiles();
                for(int j=0;j<temfiles.length;j++){
                    //1.png不可删除
                    if(temfiles[j].toString().contains("1.png")){
                        continue;
                    }
                    files.add(temfiles[j]);
                }
            }
        }
        session.put("files",files);
        session.put("game",temgame);
    }

    //按照索引删除一个游戏文件
    public void delgamefile(int index){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try {
            List files = (List) session.get("files");
            if (files == null) {
                session.put("tip", "该文件不存在，请重试");
            }
            File file = (File) files.get(index);
            file.delete();
            files.remove(index);
            session.put("files",files);
            session.put("tip","删除文件成功");
        }
        catch (Exception e){
            session.put("tip","发生错误，请重试");
        }
    }

    //上传一个游戏的文件
    public void uploadNewGameFile(File upload,String uploadFilename,String uploadContentType,Game game){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");


        //System.out.println("gameid:"+game.getId());
        Game temgame = gameControlDAO.get(game.getId());
        String path="/upload/game/" + temgame.getName();   //存储基础路径
        int fileMaxNum;   //每个文件夹文件有上限

        //根据不同文件类型存储不同位置
        if(uploadContentType.contains("text")){
            fileMaxNum=1;
            uploadFilename = "describe.txt";
            path+="/describe";
        }
        else if(uploadContentType.contains("video")){
            fileMaxNum=1;
            uploadFilename = "1.mp4";
            path+="/video";
        }
        else if(uploadContentType.contains("image")){
            fileMaxNum=4;
            path+="/pictures";
        }
        else {
            session.put("tip","对不起，上传类型不正确，上传失败");
            return;
        }

        //获取要保存文件夹的物理路径(绝对路径)
        String realPath = ServletActionContext.getServletContext().getRealPath(path);
        File file = new File(realPath);

        //文件有数量上限
        if(file.listFiles().length==fileMaxNum){
            session.put("tip","对不起，该类型文件已经达到上限，请删除后再重新上传！");
            return;
        }

        //为上传的图片重命名
        boolean flag = false;
        File [] temfile = file.listFiles();
        if(fileMaxNum==4){
            for(int i=0;i<temfile.length;i++){
                if(!temfile[i].toString().contains((i+1)+".png")){
                    uploadFilename = (i+1)+".png";
                    flag = true;
                    break;
                }
            }
        }
        if(!flag){
            if(temfile.length==1){
                uploadFilename ="2.png";
            }
            else if(temfile.length==2){
                uploadFilename ="3.png";
            }
            else if(temfile.length==3){
                uploadFilename ="4.png";
            }
        }

        //不存在则创建一个
        if (!file.exists())
            file.mkdirs();

        try {
            //保存文件
            FileUtils.copyFile(upload, new File(file, uploadFilename));
            //重新获取文件列表
            gamefiles(temgame);
            //若核验状态为已核验时需要设为未核验重新核验且下架
            if(temgame.getCheck()!=null && temgame.getCheck()==true){
                temgame.setCheck(false);
                temgame.setCtime(null);
                temgame.setGround(false);
                gameControlDAO.update(temgame);
            }
            session.put("tip","恭喜，上传成功！");
        } catch (IOException e) {
            session.put("tip","异常，上传失败，请重试！");
            e.printStackTrace();
        }
    }

    //获取一个游戏
    public void getGame(Game game){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");

        try{
            System.out.println("begin");
            Game temgame = gameControlDAO.get(game.getId());
            //激活，懒加载下主动进行一次加载
            for(GameType type : temgame.getTypes()){
                //System.out.println(type.getName());
            }
            for(Evaluate eva : temgame.getEvaluates()){
                //System.out.println(eva.getWord());
            }
            session.put("game",temgame);
            System.out.println("ok");
        }
        catch (Exception e){
            session.put("game",null);
        }
    }

    //根据天数获取一个游戏的销售情况
    public void getGameSaleStatus(Game game,int days){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try {
            //判空
            if(days==0){
                session.put("tip","您未正常输入天数！");
                return;
            }
            //转化时间格式
            long time = new Date().getTime();//当前时间转为时间戳
            long lasttime = time - (long)(days*24*60*60*1000L);//推算回到需要的天数之前
            Date last = new Date(lasttime);  //时间戳转为时间
            String stringdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(last);//时间转化格式
            String hql = "from Order as order where date >= '"+stringdate+"' and game = '" +game.getId()+"'";
            List orders = gameControlDAO.findByHql(hql);
            if(orders.size()==0){
                session.put("tip","在过去的"+days+"天内并无交易产生!");
            }
            session.put("orders",orders);
        }
        catch(Exception e){
            session.put("orders",null);
            session.put("tip","出错，请重试！");
            e.getStackTrace();
        }
    }

    //获取一个开发者一定天数内所有游戏的状态
    public void getAllGamesSaleStatus(int days,Integer type){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            //判空
            if(days==0){
                session.put("tip","您未正常选择天数！");
                return;
            }
            //开发者id
            int id;
            if(type==1){
                id = ((IndividualDeveloper)session.get("indiDeve")).getId();
            }
            else{
                id = ((TeamDeveloper)session.get("teamDeve")).getId();
            }
            //获取开发者开发过的所有游戏
            String hql = "from Game as game where developerId='"+id+"' and type='"+(type-1)+"'";
            List games = gameControlDAO.findByHql(hql);
            if(games.size()==0 || games==null){
                session.put("tip","您还未上传过任意一款游戏！");
                return;
            }
            //每个游戏按照时间来查询
            long time = new Date().getTime();//当前时间转为时间戳
            long lasttime = time - (long)(days*24*60*60*1000L);//推算回到需要的天数之前
            Date last = new Date(lasttime);  //时间戳转为时间
            String stringdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(last);//时间转化格式
            List orders = new ArrayList();
            double sumprise = 0;  //记录总的收入
            for(int i=0;i<games.size();i++){
                hql = "from Order as order where date >= '"+stringdate+"' and game = '" +((Game)games.get(i)).getId()+"'";
                List oneorder = gameControlDAO.findByHql(hql);
                for(int j=0;j<oneorder.size();j++){
                    if(((Order)oneorder.get(j)).getState()==2){
                        sumprise = sumprise + ((Game)games.get(i)).getDeveloperPrice();
                    }
                }
                orders.addAll(oneorder);
            }
            if(orders.size()==0){
                session.put("tip","您的所有游戏还没有任意一个订单产生哦！");
                return;
            }
            session.put("sumprise",sumprise);
            session.put("allorders",orders);
        }
        catch (Exception e){
            e.getStackTrace();
        }
    }



}
