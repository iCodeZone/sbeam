package sbeam.dao.gamecontrol;

import sbeam.po.collection.GameCollection;
import sbeam.po.game.Game;
import sbeam.po.order.Order;

import java.util.Date;
import java.util.List;

public interface IGameControlDAO {
    //根据hql语句查询
    public List findByHql(String hql);
    //添加新的对象
    public void save(Game game);
    //删除对象
    public void del(Game game);
    //根据ID获取对象
    public Game get(Integer id);
    //更新对象
    public void update(Game game);
    //删除对象的订单
    public void delOrder(Order order);
    //删除游戏对应的收藏
    public void delCollect(GameCollection collection);
}
