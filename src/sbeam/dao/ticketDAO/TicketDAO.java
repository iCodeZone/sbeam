package sbeam.dao.ticketDAO;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.ticket.Ticket;

import java.util.List;

public class TicketDAO extends BaseHibernateDAO implements ITicketDAO {

    public List findByHql(String hql) {
        try {
            String queryString = hql;
            System.out.println(hql);
            Query queryObject=getSession().createQuery(queryString);
            return queryObject.list();
        }
        catch (RuntimeException re) {
            throw re;
        }
    }
    public void send(Ticket ticket){
        try{
            getSession().save(ticket);
        }
        catch (RuntimeException re) {
            throw re;
        }

    }

    public void update(Ticket ticket){
        try{
            getSession().update(ticket);
        }
        catch (RuntimeException re) {
            throw re;
        }
    }

}
