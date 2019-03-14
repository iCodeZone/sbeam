package sbeam.dao.administrator;

import java.util.List;

import sbeam.po.administrator.Administrator;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;

public interface IAdministratorDAO {
	public List findByHql(String hql);
	public void addAdmin(Administrator admin);
	public void GameShelf(Game game);
	public void addGameType(GameType gametype);
}
