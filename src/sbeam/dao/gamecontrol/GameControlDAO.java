package sbeam.dao.gamecontrol;

import org.hibernate.query.Query;
import sbeam.dao.BaseHibernateDAO;
import sbeam.po.collection.GameCollection;
import sbeam.po.game.Game;
import sbeam.po.order.Order;

import java.util.Date;
import java.util.List;

public class GameControlDAO extends BaseHibernateDAO implements IGameControlDAO{
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

    //添加新的游戏对象
    public void save(Game game){
        try{
            getSession().save(game);
        }
        catch(Exception e){
            throw e;
        }
    }

    //删除对象
    public void del(Game game){
        try{
            getSession().delete(game);
        }
        catch (Exception e){
            throw e;
        }
    }

    //删除对象的订单
    public void delOrder(Order order){
        try{
            getSession().delete(order);
        }
        catch (Exception e){
            throw e;
        }
    }

    //删除游戏对应的收藏
    public void delCollect(GameCollection collection){
        try{
            getSession().delete(collection);
        }
        catch (Exception e){
            throw e;
        }
    }

    //根据ID获取对象
    public Game get(Integer id){
        try{
            return getSession().get(Game.class,id);
        }
        catch(Exception e){
            throw e;
        }
    }

    //更新对象
    public void update(Game game){
        try{
            getSession().update(game);
        }
        catch (Exception e){
            throw e;
        }
    }

}
