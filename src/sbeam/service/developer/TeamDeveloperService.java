package sbeam.service.developer;

import com.opensymphony.xwork2.ActionContext;
import sbeam.dao.developer.IIndividualDeveloperDAO;
import sbeam.dao.developer.ITeamDeveloperDAO;
import sbeam.dao.message.IMessageDAO;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.message.Message;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class TeamDeveloperService implements  ITeamDeveloperService{

    //私有依赖成员DAO
    private ITeamDeveloperDAO teamDeveDAO;
    private IIndividualDeveloperDAO indiDeveDAO;
    private IMessageDAO messageDAO;
    //注入私有依赖成员DAO
    public void setTeamDeveDAO(ITeamDeveloperDAO teamDeveDAO) {
        this.teamDeveDAO = teamDeveDAO;
    }
    public void setIndiDeveDAO(IIndividualDeveloperDAO indiDeveDAO) {
        this.indiDeveDAO = indiDeveDAO;
    }
    public void setMessageDAO(IMessageDAO messageDAO) {
        this.messageDAO = messageDAO;
    }

    //session作用域
    ActionContext ctx;
    Map<String, Object> session;

    //处理注册逻辑
    public boolean register(TeamDeveloper teamDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try {
            //判空
            if(teamDeve.getName().isEmpty() || teamDeve.getPassword().isEmpty() || teamDeve.getAddress().isEmpty()
            || teamDeve.getBankcard().isEmpty()){
                session.put("tip","带*的项目不能为空！");
                return false;
            }
            //判不合规则的数据
            if(teamDeve.getBankcard().length()<16 || teamDeve.getBankcard().length()>19){
                session.put("tip","银行卡号位数不对，请查证后重试！");
                return false;
            }
            ///判重
            String hql = "from TeamDeveloper as teamDeve where name='"+teamDeve.getName()+"'";
            TeamDeveloper team = findByHql(hql);
            if(team!=null){
                session.put("tip","团队名已被占用请修改后重试！");
                return false;
            }
            teamDeveDAO.save(teamDeve);
            team = findByHql(hql);
            teamDeve = team;
            session.put("teamDeve",team);
            session.put("tip","恭喜您，注册成功！");
            return true;
        }
        catch (Exception e) {
            session.put("tip","系统错误请稍后重试！");
            return false;
        }
    }

    //根据hql语句查询对象
    public TeamDeveloper findByHql(String hql){
        try{
            List list = teamDeveDAO.findByHql(hql);
            if(list!=null)
                return (TeamDeveloper) list.get(0);
            else
                return null;
        }
        catch(Exception e){
            return null;
        }
    }

    //登录
    public boolean login(TeamDeveloper teamDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try {
            //判空
            if(teamDeve.getId()==null || teamDeve.getPassword().isEmpty()){
                session.put("tip","用户名或密码不能为空！");
                return false;
            }
            TeamDeveloper team = teamDeveDAO.get(teamDeve.getId());
            if(team!=null && team.getPassword().equals(teamDeve.getPassword())){
                teamDeve = team;
                session.put("teamDeve",team);
                session.put("tip","恭喜您，登录成功！");
                session.put("type",2);
                return true;
            }
            session.put("tip","账户名或密码错误，登录失败！");
            return false;
        }
        catch (Exception e) {
            session.put("tip","发生异常，请重试");
            return false;
        }
    }

    //从团队中删除队员
    public void deletestaff(TeamDeveloper teamDeve, IndividualDeveloper indiDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            IndividualDeveloper indi = indiDeveDAO.get(indiDeve.getId());
            TeamDeveloper team = teamDeveDAO.get(teamDeve.getId());
            team.getStaffs().remove(indi);
            teamDeveDAO.update(team);
            indi.setTeam(null);
            indiDeveDAO.update(indi);
            session.put("teamDeve",team);
            Message message = new Message(new Date(),"抱歉，您被请出了团队！",false,indi.getId(),2);
            messageDAO.save(message);
            session.put("tip","删除成员成功！");
        }
        catch (Exception e){
            e.getStackTrace();
            session.put("tip","抱歉，发生异常，删除成员失败，请重试！");
        }

    }

    //确认成员加入申请
    public void acceptstaff(int iid,int tid,boolean accept){
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
                session.put("teamDeve", team);
                message = new Message(new Date(), "恭喜你，加入团队成功", false, indi.getId(), 2);
            }
            else{
                message = new Message(new Date(),"抱歉，团队"+team.getName()+"拒绝了您的加入申请",false,indi.getId(),2);
            }
            messageDAO.save(message);
        }
        catch (Exception e){
            e.getStackTrace();
        }
    }

    //根据ID查找个人开发者
    public void findindi(IndividualDeveloper indiDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            IndividualDeveloper indi = indiDeveDAO.get(indiDeve.getId());
            indiDeve = indi;
            session.put("indiDeve",indi);
        }
        catch(Exception e){
            session.put("indiDeve",null);
        }
    }

    //根据信息给个人发送邀请加入的消息
    public  void inviteindi(IndividualDeveloper indiDeve,TeamDeveloper teamDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        String content = "您好，小组编号为"+teamDeve.getId()+"，名称为"+teamDeve.getName()+"的小组邀请你加入团队，是否接受？" +
                "<a href=\"acceptTeam?iid="+indiDeve.getId()+ "&tid="+teamDeve.getId()+ "&accept=true\">接受</a>" +
                "  <a href=\"acceptTeam?iid="+indiDeve.getId()+"&tid="+teamDeve.getId()+"&accept=false\">拒绝</a>";
        Message message = new Message(new Date(), content, false,indiDeve.getId(),2);
        messageDAO.save(message);
        session.put("tip","邀请发送成功，请耐心等待回复！");
    }

    //修改团队信息
    public boolean alterTeamData(TeamDeveloper teamDeve){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            //获取完整数据
            TeamDeveloper temteam = teamDeveDAO.get(teamDeve.getId());
            //判不合规则的数据
            if(teamDeve.getBankcard().length()<16 || teamDeve.getBankcard().length()>19){
                session.put("tip","银行卡号位数不对，请查证后重试！");
                return false;
            }
            //对可能进行修改的值进行赋值
            temteam.setPassword(teamDeve.getPassword());
            temteam.setAddress(teamDeve.getAddress());
            temteam.setWebsite(teamDeve.getWebsite());
            temteam.setBankcard(teamDeve.getBankcard());
            //进行更新
            teamDeveDAO.update(temteam);
            //更新session
            session.put("teamDeve",temteam);
            session.put("tip","恭喜你，修改个人资料成功");
            return true;
        }
        catch (Exception e){
            System.out.println(e);
            session.put("tip","系统错误，修改失败，请重试！");
            return false;
        }
    }



}
