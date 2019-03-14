package sbeam.dao.message;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.message.Message;

import java.util.List;

public class MessageDAO extends BaseHibernateDAO implements IMessageDAO {
    //存储新的message
    public void save(Message message){
        try {
            getSession().save(message);
        }
        catch (Exception e){
            throw e;
        }
    }

    //根据hql语句获取对象
    public List findByHql(String hql){
        try {
            String queryString = hql;
            Query queryObject = getSession().createQuery(queryString);
            return queryObject.list();
        }
        catch (RuntimeException re) {
            throw re;
        }
    }

    //根据ID获取对象
    public Message get(Integer id){
        try {
            return (Message) getSession().get(Message.class ,id);
        }
        catch (RuntimeException re) {
            throw re;
        }
    }

    //更新message对象
    public void update(Message message){
        try{
            getSession().update(message);
        }
        catch(Exception e){
            throw  e;
        }
    }

}
