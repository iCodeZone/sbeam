package sbeam.service.user;

import com.opensymphony.xwork2.ActionContext;
import sbeam.dao.userDAO.ICustomerDAO;
import sbeam.po.collection.GameCollection;
import sbeam.po.evaluate.Evaluate;
import sbeam.po.game.Game;
import sbeam.po.order.Order;
import sbeam.po.user.Customer;

import java.util.*;

public class UserService implements IUserService {
    private ICustomerDAO customerDAO;
    private Map<String, Object> session = new HashMap<>();

    /* 登录 */
    @Override
    public boolean login(Customer customer) {

        String hql = "from Customer where id=" + customer.getId() + " and password='" + customer.getPassword() + "'";
        List list = customerDAO.query(hql);
        if (list.isEmpty()) {
            return false;
        } else {
            customer = (Customer) list.get(0);
            ActionContext context = ActionContext.getContext();
            session = context.getSession();
            session.put("user", customer);
            session.put("userId", customer.getId());
            session.put("type", 0);

            return true;
        }
    }

    /* 注册 */
    @Override
    public boolean register(Customer customer) {

        String hql = "from Customer where id=" + customer.getId();
        if (!customerDAO.query(hql).isEmpty()) {
            return false;
        }
        customerDAO.save(customer);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("user", customer);
        session.put("userId", customer.getId());
        session.put("type", 0);


        return true;
    }

    /* 仅仅修改个人信息 */
    @Override
    public void update(Customer customer) {
        customerDAO.update(customer);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("user", customer);
        session.put("userId", customer.getId());
        session.put("type", 0);

    }

    /* 注销 */
    @Override
    public void delete(Customer customer) {

        customer = getCustomerById(customer.getId());
        customerDAO.delete(customer);


    }

    /* 设置展示游戏 */
    @Override
public void setShowGame(Customer customer, Integer orderId) {

    customer = getCustomerById(customer.getId());
    Set<Order> orders = customer.getOrders();
    Set<Order> myGame = new HashSet<>(0);
    for (Order order : orders) {
        if (order.getId().equals(orderId)) {
            order.setShow(!order.getShow());
        }
        if (order.getState() == 2) {
            myGame.add(order);
        }
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("myGame", myGame);

}

    /* 获得展示游戏 */
    @Override
    public void getShowGame(Integer customerId) {

        Customer friend = getCustomerById(customerId);
        Set<Order> orders = friend.getOrders();
        Set<Game> friendGame = new HashSet<>(0);

        for (Order order : orders) {
            if (order.getShow() && order.getState() == 2) {
                friendGame.add(order.getGame());
            }
        }

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("friend", friend);
        session.put("friendGame", friendGame);

    }

    /* 设置收藏 */
    @Override
public void setCollection(Customer customer, Integer gameId) {

    System.out.println("gameId=" + gameId);
    /* 获得customer的pojo和收藏的游戏 */
    customer = getCustomerById(customer.getId());

    /* 修改收藏集合 */
    Set<GameCollection> collections = customer.getCollections();
    System.out.println(collections);
    /* 取消收藏 */
    boolean flag = false;
    for (GameCollection gameCollection : collections) {
        if (gameCollection.getGame().getId().equals(gameId)) {
            collections.remove(gameCollection);
            flag = true;
            break;
        }
    }
    /* 反之，收藏这个游戏 */
    if (!flag) {

        Game game = getGameById(gameId);
        GameCollection collection = new GameCollection();
        collection.setGame(game);
        collection.setCustomer(customer);

        collections.add(collection);
    }

    for (GameCollection collection : collections) {
        System.out.println(collection);
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("myCollections", collections);
}

    @Override
public void getCollection(Customer customer) {
    customer = getCustomerById(customer.getId());
    Set<GameCollection> collections = customer.getCollections();
    System.out.println("collection");
    for (GameCollection collection : collections) {
        System.out.println(collection);
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("myCollections", collections);
}

    @Override
public void addEvaluate(Customer customer, Integer gameId, String word, Integer star) {
    customer = getCustomerById(customer.getId());
    Game game = getGameById(gameId);

    Evaluate evaluate = new Evaluate();
    evaluate.setCustomer(customer);
    evaluate.setGame(game);
    evaluate.setWord(word);
    evaluate.setStar(star);
    Set<Evaluate> evaluates = customer.getEvaluates();
    evaluates.add(evaluate);
    for (Evaluate evaluate1 : evaluates) {
        System.out.println(evaluate1);
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("evaluate", evaluates);
}

    @Override
public void delEvaluate(Customer customer, Integer evaluateId) {
    customer = getCustomerById(customer.getId());
    Set<Evaluate> evaluates = customer.getEvaluates();

    for (Evaluate evaluate : evaluates) {
        System.out.println(evaluateId);
        if (evaluate.getId().equals(evaluateId)) {
            evaluates.remove(evaluate);
            break;
        }
    }

    for (Evaluate evaluate : evaluates) {
        System.out.println(evaluate);
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("evaluate", evaluates);
}

    @Override
public void getEvaluate(Customer customer) {
    customer = getCustomerById(customer.getId());
    Set<Evaluate> evaluates = customer.getEvaluates();
    for (Evaluate evaluate : evaluates) {
        System.out.println(evaluate);
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("evaluate", evaluates);
}


    @Override
public void getMyGame(Customer customer) {
    customer = getCustomerById(customer.getId());
    Set<Order> orders = customer.getOrders();
    Set<Order> myGame = new HashSet<>();
    for (Order order : orders) {
        if (order.getState() == 2) {
            order.getGame();
            myGame.add(order);
        }
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("myGame", myGame);

}

    @Override
public void getOrder(Customer customer) {
    customer = getCustomerById(customer.getId());
    Set<Order> orders = customer.getOrders();
    for (Order order : orders) {
        System.out.println(order);
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("order", orders);
}

    @Override
public void getFriendGame(Integer friendId) {
    Customer customer = getCustomerById(friendId);
    Set<Order> orders = customer.getOrders();
    Set<Order> friendGame = new HashSet<>(0);
    for (Order order : orders) {
        if (order.getShow() == true && order.getState().equals(2)) {
            friendGame.add(order);
        }
    }

    ActionContext context = ActionContext.getContext();
    session = context.getSession();
    session.put("friendGame", friendGame);
    session.put("friend", customer);
}

    private Customer getCustomerById(Integer id) {
        String hql = "from Customer where id=" + id;
        return (Customer) customerDAO.query(hql).get(0);
    }

    private Game getGameById(Integer id) {
        String hql = "from Game where id=" + id;
        return (Game) customerDAO.query(hql).get(0);
    }

    public void setCustomerDAO(ICustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }


}
