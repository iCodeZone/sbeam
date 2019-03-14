package sbeam.action.developer;

import com.opensymphony.xwork2.ActionContext;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.message.Message;
import sbeam.service.developer.IIndividualDeveloperService;

import java.util.List;
import java.util.Map;

//个人开发者的action
public class IndividualDeveloperAction {
    //依赖于service
    private IIndividualDeveloperService indiDeveService;

    //设置依赖项
    public void setIndiDeveService(IIndividualDeveloperService indiDeveService) {
        this.indiDeveService = indiDeveService;
    }


    //存储开发者信息
    private IndividualDeveloper indiDeve;
    //存储团队开发者信息
    private TeamDeveloper teamDeve;
    //针对是否接受邀请的值
    private  boolean accept;//接受与否
    private int iid;        //个人id
    private  int tid;       //团队id

    //私有成员的getter与setter方法
    public IndividualDeveloper getIndiDeve() {
        return indiDeve;
    }
    public void setIndiDeve(IndividualDeveloper indiDeve) {
        this.indiDeve = indiDeve;
    }
    public TeamDeveloper getTeamDeve() {
        return teamDeve;
    }
    public void setTeamDeve(TeamDeveloper teamDeve) {
        this.teamDeve = teamDeve;
    }
    public boolean isAccept() {
        return accept;
    }
    public void setAccept(boolean accept) {
        this.accept = accept;
    }
    public int getIid() {
        return iid;
    }
    public void setIid(int iid) {
        this.iid = iid;
    }
    public int getTid() {
        return tid;
    }
    public void setTid(int tid) {
        this.tid = tid;
    }

    //注册
    public String register(){
        if(indiDeveService.register(indiDeve)){
            return "registersuccess";
        }
        else return "registerfail";
    }

    //登录
    public String login(){
        if(indiDeveService.login(indiDeve)){
            Map<String, Object> request = (Map) ActionContext.getContext().get("request");
            request.put("id",indiDeve.getId());
            request.put("type",2);
            request.put("location","/developer/IndiDeveLoginSuccess.jsp");
            return "loginsuccess";
        }
        else return "loginfail";
    }

    //根据ID查找团队
    public String findteam(){
        indiDeveService.findteam(teamDeve);
        return "findteampage";
    }

    //加入团队
    public String jointeam(){
        indiDeveService.jointeam(indiDeve,teamDeve);
        return "jointeam";
    }

    //退出团队
    public String quitteam(){
        indiDeveService.quitteam(indiDeve);
        return "quitteam";
    }

    //是否接受邀请加入团队
    public String acceptteam(){
        indiDeveService.acceptteam(iid,tid,accept);
        Map<String, Object> session = ActionContext.getContext().getSession();
        Map<String, Object> request = (Map) ActionContext.getContext().get("request");
        List messages = (List)session.get("messages");
        String target = "&tid="+tid;
        for(int i=0;i<messages.size();i++){
            if(((Message)messages.get(i)).getContent().contains(target)){
                request.put("message",(Message)messages.get(i));
                request.put("location","/developer/MessagesPage.jsp");
                break;
            }
        }
        return "acceptteam";
    }

    //修改个人数据
    public String alterIndiData(){
        if(indiDeveService.alterIndiData(indiDeve)){
            return "successalter";
        }
        else{
            return "failalter";
        }
    }



}
