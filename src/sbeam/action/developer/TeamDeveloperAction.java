package sbeam.action.developer;

import com.opensymphony.xwork2.ActionContext;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.message.Message;
import sbeam.service.developer.ITeamDeveloperService;
import sbeam.service.developer.TeamDeveloperService;

import java.util.List;
import java.util.Map;

public class TeamDeveloperAction {
    //私有成员依赖项service
    private ITeamDeveloperService teamDeveService;

    //依赖项的注入方法
    public void setTeamDeveService(ITeamDeveloperService teamDeveService) {
        this.teamDeveService = teamDeveService;
    }

    //获取前端数据
    //团队开发者对象
    private TeamDeveloper teamDeve;
    //个人开发者对象
    private IndividualDeveloper indiDeve;
    //针对是否允许加入的值
    private  boolean accept;
    private int iid;
    private  int tid;

    //私有对象的getter和setter方法
    public TeamDeveloper getTeamDeve() {
        return teamDeve;
    }
    public void setTeamDeve(TeamDeveloper teamDeve) {
        this.teamDeve = teamDeve;
    }
    public IndividualDeveloper getIndiDeve() {
        return indiDeve;
    }
    public void setIndiDeve(IndividualDeveloper indiDeve) {
        this.indiDeve = indiDeve;
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
        if(teamDeveService.register(teamDeve)){
            return "registersuccess";
        }
        else return "registerfail";
    }

    //登录
    public String login(){
        if(teamDeveService.login(teamDeve)){
            Map<String, Object> request = (Map) ActionContext.getContext().get("request");
            request.put("id",teamDeve.getId());
            request.put("type",3);
            request.put("location","/developer/TeamDeveLoginSuccess.jsp");
            return "loginsuccess";
        }
        else{
            return "loginfail";
        }
    }

    //删除队员
    public String deletestaff(){
        teamDeveService.deletestaff(teamDeve,indiDeve);
        return "deletestaff";
    }

    //是否允许申请的队员加入
    public String acceptstaff(){
        teamDeveService.acceptstaff(iid,tid,accept);
        Map<String, Object> session = ActionContext.getContext().getSession();
        Map<String, Object> request = (Map) ActionContext.getContext().get("request");
        List messages = (List)session.get("messages");
        String target = "?iid="+iid;
        for(int i=0;i<messages.size();i++){
            if(((Message)messages.get(i)).getContent().contains(target)){
                request.put("message",(Message)messages.get(i));
                request.put("location","/developer/MessagesPage.jsp");
                break;
            }
        }
        return "acceptstaff";
    }

    //根据ID查找个人
    public String findindi(){
        teamDeveService.findindi(indiDeve);
        return "findindipage";
    }

    //邀请个人
    public String inviteindi(){
        teamDeveService.inviteindi(indiDeve,teamDeve);
        return "inviteindi";
    }

    //修改团队资料
    public String alterTeamData(){
        if(teamDeveService.alterTeamData(teamDeve)){
            return "successalter";
        }
        else{
            return "failalter";
        }
    }


}
