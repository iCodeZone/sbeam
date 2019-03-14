package sbeam.action.message;

import com.opensymphony.xwork2.ActionContext;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.message.Message;
import sbeam.service.message.IMessageService;
import sbeam.service.message.MessageService;

import java.util.Map;

public class MessageAction {
    //依赖于service
    private IMessageService messageService;
    //注入依赖对象
    public void setMessageService(IMessageService messageService) {
        this.messageService = messageService;
    }

    //从request中取出
    //私有属性，获取成员id
    private int id;
    //私有属性
    private int type;
    //私有属性，设置返回页面地址
    private String location;
    //私有消息对象
    private Message message;

    //私有属性的getter与setter方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    //根据id获取所有的未读信息存入session
    public String getmessages(){
        Map<String, Object> request = (Map) ActionContext.getContext().get("request");
        id = (int)request.get("id");
        type = (int)request.get("type");
        location = (String) request.get("location");
        messageService.getmessages(id,type);
        return "returnpage";
    }

    //确认已读消息
    public String confirmmessages(){
        Map<String, Object> request = (Map) ActionContext.getContext().get("request");
        location = (String) request.get("location");
        if(message==null){
            messageService.confirmmessage((Message)request.get("message"));
        }
        else{
            messageService.confirmmessage(message);
        }
        return "confirm";
    }

    //每次点击查看消息就获取一次消息
    public String getMessagesAgain(){
        Map<String, Object> session = (Map) ActionContext.getContext().get("session");
        int type = (int)session.get("type");
        int id;
        if(type==1){
            id = ((IndividualDeveloper)session.get("indiDeve")).getId();
        }
        else{
            id = ((TeamDeveloper)session.get("teamDeve")).getId();
        }
        messageService.getmessages(id,type+1);
        return "getMessagesAgain";
    }


}
