package sbeam.dao.developer;


import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.developer.individual.IndividualDeveloper;

import java.util.List;


public class IndividualDeveloperDAO extends BaseHibernateDAO implements IIndividualDeveloperDAO {
    //根据ID获取对象
    public IndividualDeveloper get(Integer id){
        try {
            return (IndividualDeveloper) getSession().get(IndividualDeveloper.class ,id);
        }
        catch (RuntimeException re) {
            throw re;
        }
    }

    //添加新的对象
    public void save(IndividualDeveloper indiDeve){
        try{
            getSession().save(indiDeve);
        }
        catch(Exception e){
            throw e;
        }
    }

    //根据hql语句进行查询
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

    //更新对象
    public void update(IndividualDeveloper indiDeve){
        try{
            getSession().update(indiDeve);
        }
        catch (Exception e){
            throw e;
        }
    }
}
