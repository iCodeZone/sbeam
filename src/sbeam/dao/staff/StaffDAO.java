package sbeam.dao.staff;

import java.util.List;

import org.hibernate.Query;

import sbeam.dao.BaseHibernateDAO;
import sbeam.po.user.Customer;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;
import sbeam.po.message.Message;
import sbeam.po.order.Order;
import sbeam.po.staff.Staff;
import sbeam.po.ticket.Ticket;

public class StaffDAO extends BaseHibernateDAO implements IStaffDAO{
	//查找
	public List findByHql(String hql) {
		try {
			String queryString = hql;
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//修改订单状态
	public void modifyOrder(Order order){
		try {
			getSession().update(order);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//更新客户信息
	public void updateCustomer(Customer customer){
		try {
			getSession().update(customer);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//更新个体开发者信息
	public void updateIDeveloper(IndividualDeveloper individualDeveloper){
		try {
			getSession().update(individualDeveloper);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//客服更新团队开发者的信息
	public void updateTDeveloper(TeamDeveloper teamDeveloper){
		try {
			getSession().update(teamDeveloper);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//用作人员的辞退
	public void dismissStaff(Staff staff) {
		try {
			getSession().update(staff);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//用作人员的上任
	public void dispatchStaff(Staff staff) {
		try {
			getSession().save(staff);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//个体开发者信息审核--状态更新
	public void checkIDeve(IndividualDeveloper individualDeveloper){
		try {
			getSession().update(individualDeveloper);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//团队开发者信息审核--状态更新
	public void checkTDeve(TeamDeveloper teamDeveloper){
		try {
			getSession().update(teamDeveloper);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//审核游戏--状态更新
	public void checkGame(Game game){
		try {
			getSession().update(game);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//客服回复工单
	public void replyTicket(Ticket ticket){
		try {
			getSession().update(ticket);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//客服转交工单
	public void deliverTicket(Ticket ticket){
		try {
			getSession().update(ticket);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//发送消息
	public void sendMessage(Message message){
		try {
			getSession().save(message);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//已阅消息
	public void confirmMessage(Message message){
		try {
			getSession().update(message);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
