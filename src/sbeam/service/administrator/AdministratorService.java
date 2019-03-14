package sbeam.service.administrator;

import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import sbeam.dao.administrator.IAdministratorDAO;
import sbeam.po.administrator.Administrator;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;
import sbeam.po.message.Message;

public class AdministratorService implements IAdministratorService {
	private Map<String, Object> session;
	private IAdministratorDAO administratorDAO = null;
	//setter
	public void setAdministratorDAO(IAdministratorDAO administratorDAO){
		this.administratorDAO = administratorDAO;
	}
	//查找管理员列表
	public void findByHql() {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from Administrator";
		List<Administrator> Admins = administratorDAO.findByHql(hql);
		session.put("Admins",Admins);
	}
	//管理员登录模块
	public boolean adminLogin(Administrator admin) {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int aid = admin.getAid();
		String apassword = admin.getApassword();
		String hql = "from Administrator as user where aid='" + aid
				+ "' and apassword='" + apassword + "'";
		List<Administrator> list = administratorDAO.findByHql(hql);
		String hql2 = "from Message where mtype = 4 and mcheck = 0"; //获取管理员的消息
		List<Message> Messages = administratorDAO.findByHql(hql2);
		if (list.size()==0) {
			session.put("loginfail","管理员登录ID出错或密码出错");
			return false; 
		}
		else{
			admin=(Administrator)list.get(0);
			session.put("admin", admin);//存入登录者信息
			session.put("type", 3);     //存入登录者类型
			session.put("MessageNum",Messages.size());  //存入管理员收到的消息数量
			session.put("Messages", Messages);  //存入消息
			return true;
		}
	}
	//新建一个管理员账号
	public boolean addAdmin(Administrator admin){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		try {	
			int id = admin.getAid();
			List<Administrator> Admins = (List<Administrator>) session.get("Admins");
			Administrator administrator= new Administrator();
			for(int i=0;i<Admins.size();i++){
				if(id==((Administrator)Admins.get(i)).getAid()){
					session.put("addAdminError","此编号已经存在，不可重复添加！！");
					return false;
				}
			}
			administrator.setAid(admin.getAid());
			administrator.setApassword(admin.getApassword());
			Admins.add(administrator);
			session.put("Admins",Admins);
			administratorDAO.addAdmin(administrator); 
			return true;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		} 
	}
	//查找游戏  --通过审核
	public void findGames(){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from Game where gcheck = true";
		List Games = administratorDAO.findByHql(hql);
		session.put("Games",Games);
	}
	//HandleGame界面根据游戏ID查找相应游戏
	public void searchGames(Game game){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = game.getId();
		String hql = "from Game where gcheck = true";
		List<Game> Games = administratorDAO.findByHql(hql);
		Game Game = new Game();
		for(int i=0;i<Games.size();i++){
			if(Games.get(i).getId()==id){
				Game=Games.get(i);
				break;
			}
		}
		session.put("Tips", true);
		if (Game.getId()==null) {
			session.put("Tips", false);
			session.put("tips","输入游戏ID错误或该游戏未通过审核");
		}
		else{
			session.put("Game",Game);
		}
	}
	//GamePrice界面根据游戏ID查找相应游戏
	public void searchGame(Game game){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = game.getId();
		String hql = "from Game where gcheck = true";
		List<Game> Games = administratorDAO.findByHql(hql);
		Game Game = new Game();
		for(int i=0;i<Games.size();i++){
			if(Games.get(i).getId()==id){
				Game=Games.get(i);
				break;
			}
		}
		session.put("Tip", true);
		if (Game.getId()==null) {
			session.put("Tip", false);
			session.put("tip","输入游戏ID错误");
		}
		else{
			session.put("Game",Game);
		}
	}
	//上架游戏
	public void onTheShelf(Game game){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		try {
			int id = game.getId();
			String hql = "from Game where gcheck = true";
			List<Game> Games = administratorDAO.findByHql(hql);
			Game Game = new Game();
			for(int i=0;i<Games.size();i++){
				if(Games.get(i).getId()==id){
					Games.get(i).setGround(true);
					Game=Games.get(i);
					break;
				}
			}
			administratorDAO.GameShelf(Game); 
			session.put("Games",Games);		
		} catch (Exception e) {
			throw e;
		}
	}
	//下架游戏
	public void offTheShelf(Game game){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		try {
			int id = game.getId();	
			String hql = "from Game where gcheck = true";
			List<Game> Games = administratorDAO.findByHql(hql);
			Game Game = new Game();
			for(int i=0;i<Games.size();i++){
				if(Games.get(i).getId()==id){
					Games.get(i).setGround(false);
					Game=Games.get(i);
					break;
				}
			}
			administratorDAO.GameShelf(Game); 
			session.put("Games",Games);		
		} catch (Exception e) {
			throw e;
		}
	}
	//定价价格
	public void placePrice(Game game){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		try {
			int id = game.getId();
			String hql = "from Game where gcheck = true";
			List<Game> Games = administratorDAO.findByHql(hql);
			Game Game = new Game();
			for(int i=0;i<Games.size();i++){
				if(Games.get(i).getId()==id){
					//定价商城价格
					Games.get(i).setMallPrice(game.getMallPrice());
					//定价折扣价格
					if(game.getDiscountPrice()==null){
						Games.get(i).setDiscountPrice(game.getMallPrice());
					}
					else{
						Games.get(i).setDiscountPrice(game.getDiscountPrice());
					}
					Game=Games.get(i);
					break;
				}
			}
			administratorDAO.GameShelf(Game);  //此处是更新了game的价格
			session.put("Games",Games);		
		} catch (Exception e) {
			throw e;
		}	
	}
	//展示游戏种类
	public void showGameType(){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from GameType";
		List GameTypes = administratorDAO.findByHql(hql);
		session.put("GameTypes",GameTypes);
	}
	//添加游戏种类
	public void addGameType(GameType gametype){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		try {
			administratorDAO.addGameType(gametype); 
			List<GameType> GameTypes = (List<GameType>)session.get("GameTypes");
			GameType type= new GameType();
			type.setId(gametype.getId());
			type.setName(gametype.getName());
			GameTypes.add(type);
			session.put("GameTypes",GameTypes);		
		} catch (Exception e) {
			throw e;
		}
	}
}
