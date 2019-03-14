package sbeam.service.administrator;

import java.util.List;
import java.util.Map;

import org.hibernate.Transaction;

import com.opensymphony.xwork2.ActionContext;

import sbeam.dao.administrator.IAdministratorDAO;
import sbeam.po.administrator.Administrator;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;

public interface IAdministratorService {
	public void findByHql();
	public boolean adminLogin(Administrator admin);
	public boolean addAdmin(Administrator admin);
	public void findGames();
	public void searchGames(Game game);
	public void searchGame(Game game);
	public void onTheShelf(Game game);
	public void offTheShelf(Game game);
	public void placePrice(Game game);
	public void showGameType();
	public void addGameType(GameType gametype);
}
