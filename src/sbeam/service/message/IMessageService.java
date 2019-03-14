package sbeam.service.message;

import sbeam.po.message.Message;

public interface IMessageService {
    //根据目标ID获取消息
    public void getmessages(int id,int type);
    //把某个消息的状态置为已读
    public void confirmmessage(Message message);
}
