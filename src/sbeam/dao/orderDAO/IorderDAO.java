package sbeam.dao.orderDAO;

import java.util.List;

import sbeam.po.order.Order;

public interface IorderDAO {
	public void buy(Order od);
	public List findByHql(String hql);
	public void delet(Order od);
	public void update(Order od);

}
