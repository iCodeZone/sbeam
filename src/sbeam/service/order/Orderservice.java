package sbeam.service.order;

import com.opensymphony.xwork2.ActionContext;
import sbeam.dao.orderDAO.IorderDAO;
import sbeam.po.game.Game;
import sbeam.po.order.Order;
import sbeam.po.user.Customer;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class Orderservice implements IorderService {
    private IorderDAO iorderDAO;

    public Orderservice() {
        System.out.println("create orderService.");
    }

    public void setIorderDAO(IorderDAO iorderDAO) {
        System.out.println("--setIorderDAO--");
        this.iorderDAO = iorderDAO;
    }

    public void buy(Order od) {//下单
        od.setShow(true);
        System.out.println("execute --buy()-- method.");
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        System.out.println("Orderaction buy");
        Customer customer = (Customer) session.get("user");
        od.setCustomer(customer);
        od.setState(0);
        Date date = new Date();
        od.setDate(date);//获取系统时间
        iorderDAO.buy(od);
        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("order", od);

    }

    public void update() {
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        System.out.println("Orderaction delete");
        Order od = (Order) session.get("order");
        od.setState(2);
        iorderDAO.update(od);
        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("order", od);
    }

    public Game getGame(int gid) {
        String hql = "from Game as game where id=" + gid + "";
        List list = iorderDAO.findByHql(hql);
        return (Game) list.get(0);
    }

    public Order getOrder(int oid) {
        String hql = "from Order as order where id=" + oid + "";
        List list = iorderDAO.findByHql(hql);
        return (Order) list.get(0);
    }

    public void pay(int gid) {//所需金额
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        Order od = (Order) session.get("order");
        Game game = getGame(gid);
        od.setPay(game.getMallPrice());
        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("order", od);
    }

    public boolean delet(Order od) {//取消订单
        String hql = "from Order as order where id='" + od.getId() + "'";
        List list = iorderDAO.findByHql(hql);
        if (list.isEmpty()) {
            return false;
        } else {
            od = (Order) list.get(0);
            iorderDAO.delet(od);
            return true;
        }
    }

    public boolean refund(Order od) {//退款
        String hql = "from Order as order where id='" + od.getId() + "'";
        List list = iorderDAO.findByHql(hql);
        if (list.isEmpty()) {
            return false;
        } else {
            od = (Order) list.get(0);
            Calendar cal = Calendar.getInstance();
            cal.setTime(od.getDate());
            Date date = new Date();//系统时间
            Date d1 = cal.getTime();
            cal.setTime(date);
            Date d2 = cal.getTime();
            long daterange = d2.getTime() - d1.getTime();
            long time = 1000 * 3600 * 24;
            long day = daterange / time;
            if (day <= 1) {//超过一天不得退款
                od.setState(1);
                iorderDAO.update(od);
                return true;
            }
            return false;
        }
    }
}

