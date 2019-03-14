package sbeam.service.developer;

import com.opensymphony.xwork2.ActionContext;
import org.hibernate.Transaction;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import sbeam.dao.developer.IIndividualDeveloperDAO;
import sbeam.dao.developer.ITeamDeveloperDAO;
import sbeam.dao.message.IMessageDAO;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.message.Message;

import java.util.Date;
import java.util.List;
import java.util.Map;


public class IndividualDeveloperService  implements IIndividualDeveloperService{
    //依赖于DAO
    private IIndividualDeveloperDAO indiDeveDAO;
    private ITeamDeveloperDAO teamDeveDAO;
    private IMessageDAO messageDAO;
    //DAO的setter方法
    public void setIndiDeveDAO(IIndividualDeveloperDAO indiDeveDAO) {
        this.indiDeveDAO = indiDeveDAO;
    }
    public void setTeamDeveDAO(ITeamDeveloperDAO teamDeveDAO) {
        this.teamDeveDAO = teamDeveDAO;
    }
    public void setMessageDAO(IMessageDAO messageDAO) {
        this.messageDAO = messageDAO;
    }

    //session作用域
    ActionContext ctx;
    Map<String, Object> session;

    //注册
    public boolean register(IndividualDeveloper indiDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try {
            //判空
            if(indiDeve.getAccount().isEmpty() || indiDeve.getPassword().isEmpty() || indiDeve.getName().isEmpty() ||
            indiDeve.getIdnumber().isEmpty() || indiDeve.getBankcard().isEmpty()){
                session.put("tip","所有字段不能为空，请重试！");
                return false;
            }
            //判不合规则的数据
            if(indiDeve.getBankcard().length()<16 || indiDeve.getBankcard().length()>19){
                session.put("tip","银行卡号位数不对，请查证后重试！");
                return false;
            }
            if(indiDeve.getIdnumber().length()!=18){
                session.put("tip","身份证号位数不对，请查证后重试！");
                return false;
            }
            //判重
            String hql = "from IndividualDeveloper as indiDeve where account='"+indiDeve.getAccount()+"'";
            IndividualDeveloper indi = findByHql(hql);
            if(indi!=null){
                session.put("tip","账号已被占用请修改后重试！");
                return false;
            }
            indiDeveDAO.save(indiDeve);
            indi = findByHql(hql);
            indiDeve = indi;
            session.put("indiDeve",indi);
            session.put("tip","恭喜您，注册成功！");
            return true;
        }
        catch (Exception e) {
            session.put("tip","系统错误请重试！");
            return false;
        }
    }

    //登录
    public boolean login(IndividualDeveloper indiDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        System.out.println("id:"+indiDeve.getId());
        System.out.println("password:"+indiDeve.getPassword());
        try {
            //判空
            if(indiDeve.getId()==null  || indiDeve.getPassword().isEmpty()){
                session.put("tip","ID或密码不能为空！");
                return false;
            }
            //根据ID获取对象
            IndividualDeveloper indi = indiDeveDAO.get(indiDeve.getId());
            //比对密码
            if(indi!=null && indi.getPassword().equals(indiDeve.getPassword())){
                indiDeve = indi;
                //System.out.println("所在团队名:"+indi.getTeam().getName());
                session.put("indiDeve",indi);
                session.put("tip","恭喜您，登录成功！");
                session.put("type",1);
                return true;
            }
            session.put("tip","ID或密码错误，登录失败！");
            return false;
        }
        catch (Exception e) {
            session.put("tip","发生异常，请重试");
            System.out.println(e);
            return false;
        }
    }

    //根据hql查找对象
    public IndividualDeveloper findByHql(String hql){
        try{
            List list = indiDeveDAO.findByHql(hql);
            if(list!=null)
                return (IndividualDeveloper)list.get(0);
            else
                return null;
        }
        catch(Exception e){
            e.getStackTrace();
            return null;
        }
    }

    //根据团队ID找团队
    public void findteam(TeamDeveloper teamDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            TeamDeveloper team = teamDeveDAO.get(teamDeve.getId());
            teamDeve = team;
            session.put("teamDeve",team);
        }
        catch(Exception e){
            session.put("teamDeve",null);
        }
    }

    //个人退出团队
    public void quitteam(IndividualDeveloper indiDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try {
            IndividualDeveloper indi = indiDeveDAO.get(indiDeve.getId());
            TeamDeveloper team = indi.getTeam();
            indi.setTeam(null);
            indiDeveDAO.update(indi);
            session.put("indiDeve",indi);
            String content = "您好，于"+new Date()+"，编号为"+indi.getId()+",昵称为"+indi.getAccount()+"的成员退出您的团队。";
            Message message = new Message(new Date(),content,false,team.getId(),3);
            messageDAO.save(message);
            session.put("tip","退出团队成功！");
        }
        catch (Exception e){
            e.getStackTrace();
            session.put("tip","退出团队失败！");
        }
    }

    //根据请求发出消息
    public void jointeam(IndividualDeveloper indiDeve,TeamDeveloper teamDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        String content = "您好，用户编号为"+indiDeve.getId()+"，名称为"+indiDeve.getAccount()+"的用户申请加入您的团队，是否接受？" +
                "<a href=\"acceptStaff?iid="+indiDeve.getId()+ "&tid="+teamDeve.getId()+ "&accept=true\">接受</a>" +
                "  <a href=\"acceptStaff?iid="+indiDeve.getId()+"&tid="+teamDeve.getId()+"&accept=false\">拒绝</a>";
        Message message = new Message(new Date(), content, false,teamDeve.getId(),3);
        messageDAO.save(message);
        session.put("tip","请求发送成功，请耐心等待回复！");
    }

    //是否接受团队邀请
    public void acceptteam(int iid,int tid,boolean accept){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            Message message;
            IndividualDeveloper indi = indiDeveDAO.get(iid);
            TeamDeveloper team = teamDeveDAO.get(tid);
            if(accept) {
                indi.setTeam(team);
                indiDeveDAO.update(indi);
                team.getStaffs().add(indi);
                session.put("indiDeve",indi);
                message = new Message(new Date(), "恭喜你，邀请"+indi.getAccount()+"成功！", false, team.getId(), 3);
            }
            else{
                message = new Message(new Date(),"抱歉，个人开发者"+indi.getAccount()+"拒绝了您的加入申请",false,team.getId(),3);
            }
            messageDAO.save(message);
        }
        catch (Exception e){
            e.getStackTrace();
        }
    }

    //修改个人数据
    public boolean alterIndiData(IndividualDeveloper indiDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            //判重，昵称不可和其他客户重复
            String hql = "from IndividualDeveloper as indiDeve where account='"+indiDeve.getAccount()+"' and id!='"+indiDeve.getId()+"'";
            IndividualDeveloper indi = findByHql(hql);
            if(indi!=null){
                session.put("tip","修改失败，账号已被占用请修改后重试！");
                return false;
            }
            //判不合规则的数据
            if(indiDeve.getBankcard().length()<16 || indiDeve.getBankcard().length()>19){
                session.put("tip","银行卡号位数不对，请查证后重试！");
                return false;
            }
            //先获取完整对象
            IndividualDeveloper temindi = indiDeveDAO.get(indiDeve.getId());
            //用修改过的值来修改对象
            temindi.setAccount(indiDeve.getAccount());
            temindi.setPassword(indiDeve.getPassword());
            temindi.setBankcard(indiDeve.getBankcard());
            //更新对象
            indiDeveDAO.update(temindi);
            //新的对象存入session
            session.put("indiDeve",temindi);
            session.put("tip","恭喜你，修改个人信息成功！");
            return true;
        }
        catch (Exception e){
            System.out.println(e);
            session.put("tip","系统出错，修改失败，请重试！");
            return false;
        }
    }



}
