package sbeam.dao.gameDAO;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;


import java.util.List;

public class DownloadDAO extends BaseHibernateDAO implements IDownloadDAO {

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
}
