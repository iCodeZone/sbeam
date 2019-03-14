package sbeam.service.message;

import com.opensymphony.xwork2.ActionContext;
import sbeam.dao.message.IMessageDAO;
import sbeam.dao.message.MessageDAO;
import sbeam.po.message.Message;

import java.util.List;
import java.util.Map;

public class MessageService implements IMessageService {
    //依赖于DAO
    private IMessageDAO messageDAO;
    //依赖项注入方法
    public void setMessageDAO(IMessageDAO messageDAO) {
        this.messageDAO = messageDAO;
    }

    //session作用域
    ActionContext ctx;
    Map<String, Object> session;

    //根据目标ID获取所有未读消息
    public void getmessages(int id,int type){
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        try{
            String hql = "from Message as message where tid='"+id+"'  and type='"+type+"' and check= 'false'";
            List messages = messageDAO.findByHql(hql);
            session.put("messages",messages);
        }
        catch (Exception e){
            session.put("messages",null);
        }
    }

    //把某个消息的状态置为已读
    public void confirmmessage(Message message){
        try{
            //获取完整对象
            Message temmessage = messageDAO.get(message.getId());

            temmessage.setCheck(true);
            messageDAO.update(temmessage);
            getmessages(temmessage.getTid(),temmessage.getType());
        }
        catch (Exception e){
            e.getStackTrace();
        }
    }


}
