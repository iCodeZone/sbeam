package sbeam.dao.orderDAO;

import java.util.List;

import org.hibernate.query.Query;

import sbeam.dao.BaseHibernateDAO;
import sbeam.po.order.Order;

public class OrderDAO extends BaseHibernateDAO implements IorderDAO {

	public void buy(Order od){//购买游戏
		try{
			getSession().save(od);
		}
		catch (RuntimeException re) {
			throw re;
			}
		}

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
	
	public void delet(Order od) { //用户取消订单
		try {
	        getSession().delete(od);
		}
		catch (RuntimeException re) {
			throw re;
			}
		}

	public void update(Order od){//更新订单
		try{
			getSession().update(od);
		}
		catch (RuntimeException re) {
			throw re;
		}
	}
}
