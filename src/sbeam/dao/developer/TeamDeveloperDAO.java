package sbeam.dao.developer;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.developer.team.TeamDeveloper;

import java.util.List;

//团队开发者DAO
public class TeamDeveloperDAO extends BaseHibernateDAO implements ITeamDeveloperDAO {

    //存入新的数据
    public void save(TeamDeveloper teamDeve){
        try{
            getSession().save(teamDeve);
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

    //根据ID获取对象
    public TeamDeveloper get(Integer id){
        try {
            return (TeamDeveloper) getSession().get(TeamDeveloper.class ,id);
        }
        catch (RuntimeException re) {
            throw re;
        }
    }

    //更新对象
    public void update(TeamDeveloper teamDeve){
        try{
            getSession().update(teamDeve);
        }
        catch (Exception e){
            throw e;
        }
    }
}
