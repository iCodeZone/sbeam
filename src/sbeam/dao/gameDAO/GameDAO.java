package sbeam.dao.gameDAO;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.game.Game;

import java.util.List;

public class GameDAO extends BaseHibernateDAO implements IGameDAO {
    //根据ID获取游戏
    public Game get(Integer id) {
        try {
            System.out.println("开始DAO");
            return getSession().get(Game.class, id);
        } catch (Exception e) {
            throw e;
        }
    }

    //根据hql语句进行查询
    public List findByHql(String hql) {
        try {
            String queryString = hql;
            Query queryObject = getSession().createQuery(queryString);
            return queryObject.list();
        } catch (RuntimeException re) {
            throw re;
        }
    }

    @Override
    public void update(Game game) {
        getSession().update(game);
    }

    @Override
    public void save(Game game) {
        getSession().save(game);
    }

    @Override
    public void delete(Game game) {
        getSession().delete(game);
    }

    @Override
    public List query(String hql) {
        return getSession().createQuery(hql).list();
    }
}
