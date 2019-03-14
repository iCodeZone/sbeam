package sbeam.service.order;

import sbeam.po.game.Game;
import sbeam.po.order.Order;

public interface IorderService {
	public void buy(Order od);
	public void pay(int gid);
	public boolean delet(Order od);
	public Game getGame(int gid);
	public Order getOrder(int oid);
	public boolean refund(Order od);
	public void update();
}
