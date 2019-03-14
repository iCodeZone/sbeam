package sbeam.dao.message;

import sbeam.po.message.Message;

import java.util.List;

public interface IMessageDAO {
    //存储新的message
    public void save(Message message);
    //根据hql获取对象
    public List findByHql(String hql);
    //根据ID获取对象
    public Message get(Integer id);
    //更新message对象
    public void update(Message message);
}
