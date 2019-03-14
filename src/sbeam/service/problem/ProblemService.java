package sbeam.service.problem;

import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import sbeam.dao.problem.IProblemDAO;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.ticket.Ticket;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class ProblemService implements IProblemService {
    //私有依赖项DAO
    private IProblemDAO problemDAO;
    //依赖项的注入方法
    public void setProblemDAO(IProblemDAO problemDAO) {
        this.problemDAO = problemDAO;
    }

    //session作用域
    ActionContext ctx;
    Map<String, Object> session;

    //添加一个新工单
    public void setNewProblem(Ticket ticket, File upload, String uploadFileName, String uploadContentType){
        //获取session作用域
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            //判空
            if(ticket.getPcontent()==null || ticket.getPcontent().isEmpty()){
                session.put("tip","工单内容不能为空，提交失败！");
                return;
            }
            //自动补全类型
            if(ticket.getType()==null){
                ticket.setType(1);
            }
            //获取上传的开发者类型及相应的ID
            int type = (int)session.get("type");
            int id;
            if(type==1){
                id = ((IndividualDeveloper)session.get("indiDeve")).getId();
            }
            else{
                id = ((TeamDeveloper)session.get("teamDeve")).getId();
            }
            System.out.println("33333");
            //为传过来的ticket对象补全它的值
            ticket.setPtype(type);
            ticket.setPfid(id);
            ticket.setPstate(0);
            ticket.setSid(null);
            Date time = new Date();
            long miaos = time.getTime();
            miaos = miaos/1000*1000l;
            time.setTime(miaos);
            ticket.setPutime(time);
            //把对象先存入数据库获取id
            problemDAO.save(ticket);
            //文件操作，存储图片
            if(upload!=null){
                //判断文件类型是否是图片
                if(!uploadContentType.contains("image")){
                    session.put("tip","截图类型不正确，工单已创建成功！");
                    return;
                }
                //把数据再取出来要获取它的id
                String putime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time);//时间转化格式
                System.out.println(putime);
                String hql = "from Ticket as ticket where pfid ='"+ticket.getPfid()
                        +"' and ptype='"+ticket.getPtype()+"' and putime = '"+putime+"'";
                List list = problemDAO.findByHql(hql);
                ticket = (Ticket) list.get(0);

                //获取要保存文件夹的物理路径(绝对路径)
                String realPath = ServletActionContext.getServletContext().getRealPath(
                        "/upload/ticket/"+ticket.getPid());    //一个以ID命名的文件夹
                File file = new File(realPath);

                System.out.println("66666");
                //测试此抽象路径名表示的文件或目录是否存在，不存在则创建
                if (!file.exists()) {
                    file.mkdirs();
                }

                try {
                    System.out.println("777777");
                    //保存文件
                    FileUtils.copyFile(upload, new File(file, uploadFileName));
                    System.out.println("8888");
                } catch (IOException e) {
                    session.put("tip","图片上传失败，工单创建成功，可进入管理页面进行操作");
                    e.printStackTrace();
                }

                System.out.println("999999");
                //更新
                ticket.setPphotoaddr("/upload/ticket/"+ticket.getPid()+"/"+uploadFileName);
                problemDAO.update(ticket);

                //session提示
                session.put("tip","工单提交成功");

            }
            session.put("tip","工单提交成功！");
        }
        catch (Exception e){
            System.out.println("异常了呀");
            session.put("tip","异常！");
            System.out.println(e);
            e.getStackTrace();
        }
    }

    //获取某个人用户的所有工单
    public void getAllProblem(int type){
        //获取session作用域
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{

            //获取上传的开发者类型及相应的ID
            int id;
            if(type==1){
                id = ((IndividualDeveloper)session.get("indiDeve")).getId();
            }
            else{
                id = ((TeamDeveloper)session.get("teamDeve")).getId();
            }
            //生成hql语句
            String hql = "from Ticket as ticket where ptype ='"+type+"' and pfid='"+id+"'";
            List list = problemDAO.findByHql(hql);
            session.put("tickets",list);
        }
        catch (Exception e){
            System.out.println(e);
        }
    }


}
