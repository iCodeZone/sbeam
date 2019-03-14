package sbeam.dao.administrator;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.query.Query;

import sbeam.dao.BaseHibernateDAO;
import sbeam.dao.staff.StaffDAO;
import sbeam.po.administrator.Administrator;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;

public class AdministratorDAO  extends BaseHibernateDAO implements IAdministratorDAO {
	//用来查找游戏列表、工作人员列表和管理员列表
	public List findByHql(String hql) {
		try {
			String queryString = hql;
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//用来新建一个管理员账号
	public void addAdmin(Administrator admin) {
		try {
			getSession().save(admin);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//上架或下架游戏
	public void GameShelf(Game game){
		try {
			getSession().update(game);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	//添加游戏种类
	public void addGameType(GameType gametype){
		try {
			getSession().save(gametype);
		} catch (RuntimeException re) {
			throw re;
		}
	}
}
