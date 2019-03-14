package sbeam.dao.problem;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.ticket.Ticket;

import java.util.List;

public class ProblemDAO extends BaseHibernateDAO implements IProblemDAO {
    //保存一个工单
    public void save(Ticket ticket){
        try{
            getSession().save(ticket);
        }
        catch (Exception e){
            System.out.println(e);
            throw e;
        }
    }

    //根据hql查询对象
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

    //更新一个数据
    public void update(Ticket ticket){
        try{
            getSession().update(ticket);
        }
        catch (Exception e){
            throw e;
        }
    }
}
