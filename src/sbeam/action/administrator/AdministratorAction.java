package sbeam.action.administrator;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.ServletActionContext;

import sbeam.po.administrator.Administrator;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;
import sbeam.po.staff.Staff;
import sbeam.service.administrator.IAdministratorService;
import sbeam.service.staff.IStaffService;

public class AdministratorAction {
	private Administrator administrator;//保存管理员数据
	private Staff staff;                //保存工作人员数据
	private Game game;                  //保存游戏数据
	private GameType gameType;          //保存游戏种类
	private IAdministratorService administratorService;
	private IStaffService staffService;
	//getter
	public Administrator getAdministrator(){
		return administrator;
	}
	public Staff getStaff(){
		return staff;
	}
	public Game getGame(){
		return game;
	}
	public GameType getGameType(){
		return gameType;
	}
	//setter
	public void setAdministrator(Administrator administrator){
		this.administrator = administrator;
	}
	public void setStaff(Staff staff){
		this.staff = staff;
	}
	public void setGame(Game game){
		this.game = game;
	}
	public void setGameType(GameType gameType){
		this.gameType = gameType;
	}
	public void setAdministratorService(IAdministratorService administratorService){
		this.administratorService = administratorService;
	}
	public void setStaffService(IStaffService staffService){
		this.staffService = staffService;
	}
	//查找管理员列表
	public String findAdministrator() {
		administratorService.findByHql();
		return "findsuccess";
	}
	//查找工作人员列表
	public String findStaff() {
		staffService.findByHql();
		return "findsuccess";
	}
	//查找游戏列表
	public String findGame() {
		administratorService.findGames();
		return "findsuccess";
	}
	//管理员登录
	public String adminLogin(){
		if (administratorService.adminLogin(administrator))
			return "loginsuccess";
		else
			return "loginfail";
	}
	//新建一个管理员账号
	public String addAdmin(){
		if (administratorService.addAdmin(administrator))
			return "addsuccess";
		else
			return "addfail";
	}
	//工作人员辞退
	public String dismissStaff(){
		if (staffService.dismissStaff(staff))
			return "dismisssuccess";
		else
			return "dismissfail";
	}
	//工作人员调度
	public String dispatchStaff(){
		if (staffService.dispatchStaff(staff)){
			return "dispatchsuccess";
		}
		else
			return "dispatchfail";
	}
	//定价价格
	public String placeMallPrice(){
		administratorService.placePrice(game);
		return "placesuccess";
	}
	//展示已有游戏种类
	public String showGameType(){
		administratorService.showGameType();
		return "showsuccess";
	}
	//添加游戏种类
	public String addGameType(){
		administratorService.addGameType(gameType);
		return "addsuccess";
	}
	//检查游戏价格
	public String checkGamePrice(){
		administratorService.findGames();
		return "checksuccess";
	}
	//根据id查找相应游戏
	public String searchGame(){
		administratorService.searchGame(game);
		return "searchsuccess";
	}
	//上架游戏
	public String onTheShelf(){
		administratorService.onTheShelf(game);
		return "onTheShelfsuccess";
	}
	//下架游戏
	public String offTheShelf(){
		administratorService.offTheShelf(game);
		return "offTheShelfsuccess";
	}
}
