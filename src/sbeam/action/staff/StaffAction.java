package sbeam.action.staff;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.ServletActionContext;

import sbeam.po.user.Customer;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.game.Game;
import sbeam.po.message.Message;
import sbeam.po.order.Order;
import sbeam.po.staff.Staff;
import sbeam.po.ticket.Ticket;
import sbeam.service.staff.IStaffService;

public class StaffAction {
	private Staff staff;
	private Game game;
	private TeamDeveloper teamDeveloper;
	private Order order;
	private Customer customer;
	private Ticket ticket;
	private IndividualDeveloper individualDeveloper;
	private Message message;
    private InputStream is;
    private String fileName;
	private IStaffService staffService;
	//getter方法
	public Staff getStaff(){
		return staff;
	}
	public Game getGame(){
		return game;
	}
	public IndividualDeveloper getIndividualDeveloper(){
		return individualDeveloper;
	}
	public TeamDeveloper getTeamDeveloper(){
		return teamDeveloper;
	}
	public Order getOrder(){
		return order;
	}
	public Customer getCustomer(){
		return customer;
	}
	public Ticket getTicket(){
		return ticket;
	}
	public Message getMessage() {
		return message;
	}
	public InputStream getIs(){
		return is;
	}
	public String getFileName(){
		return fileName;
	}
	//setter方法
	public void setTicket(Ticket ticket){
		this.ticket = ticket;
	}
	public void setStaff(Staff staff){
		this.staff = staff;
	}
	public void setGame(Game game){
		this.game = game;
	}
	public void setOrder(Order order){
		this.order = order;
	}
	public void setTeamDeveloper(TeamDeveloper teamDeveloper){
		this.teamDeveloper = teamDeveloper;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	public void setIndividualDeveloper(IndividualDeveloper individualDeveloper){
		this.individualDeveloper = individualDeveloper;
	}
	public void setStaffService(IStaffService staffService){
		this.staffService = staffService;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public void setIs(InputStream is){
		this.is = is;
	}
	public void setFilename(String fileName){
		this.fileName = fileName;
	}
	//工作人员登录
	public String staffLogin() {
		if (staffService.staffLogin(staff))
			return "loginsuccess";
		else
			return "loginfail";
	}
	//客服根据订单ID查找订单
	public String findOrder(){
		staffService.findOrder(order);
		return "findsuccess";
	}
	//客服修改订单状态
	public String modifyOrder(){
		staffService.modifyOrder(order);
		return "modifysuccess";
	}
	//客服更新客户信息
	public String updateCustomer(){
		staffService.updateCustomer(customer);
		return "updatesuccess";
	}
	//客服更新开发者信息
	public String updateDeveloper(){
		return "updatesuccess";
	}
	//审核个体开发者
	public String checkIDeveloper(){
		staffService.checkIDeveloper();
		return "checksuccess";
	}
	//审核团队开发者
	public String checkTDeveloper(){
		staffService.checkTDeveloper();
		return "checksuccess";
	}
	//个体开发者信息审核通过
	public String checkIDeveSuccess(){
		staffService.checkIDeveSuccess(individualDeveloper);
		return "checksuccess";
	}
	//个体开发者信息审核失败
	public String checkIDeveFail(){
		staffService.checkIDeveFail(individualDeveloper);
		return "checksuccess";
	}
	//团队开发者信息审核通过
	public String checkTDeveSuccess(){
		staffService.checkTDeveSuccess(teamDeveloper);
		return "checksuccess";
	}
	//团队开发者信息审核失败
	public String checkTDeveFail(){
		staffService.checkTDeveFail(teamDeveloper);
		return "checksuccess";
	}
	//查找游戏
	public String checkGame() {
		staffService.findGames();
		return "checksuccess";
	}
	//查看游戏的详情
	public String gameDetails(){
		staffService.gameDetails(game);
		return "detailsuccess";
	}
	//下载游戏
	public String downloadGame(){
	    String realPath = ServletActionContext.getServletContext().getRealPath(game.getDir()+"/package");
	    File file = new File(realPath);
	    //获取文件流
	    try {
			is = new FileInputStream((file.listFiles())[0]);
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
	    //设置文件名
	    try {
			fileName = new String((file.listFiles())[0].getName().getBytes(),"iso8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        if(is==null){
            System.out.println("null is!");
        }
        else System.out.println("not null is");
        return "downloadsuccess";
	}
	//审核者审核游戏代码
	/*public String checkGameCode(){
		staffService.checkGameCode();
		return "checksuccess";
	}*/
	//审核游戏内容通过
	public String checkGameContentSuccess(){
		staffService.checkGameContentSuccess(game);
		return "checksuccess";
	}
	//审核游戏内容失败
	public String checkGameContentFail(){
		staffService.checkGameContentFail(game);
		return "checksuccess";
	}
	//审核游戏代码通过
	/*public String checkGameCodeSuccess(){
		staffService.checkGameCodeSuccess(game);
		return "checksuccess";
	}*/
	//审核游戏代码失败
	/*public String checkGameCodeFail(){
		staffService.checkGameCodeFail(game);
		return "checksuccess";
	}*/
	
	//查找工单
	public String findTickets() {
		staffService.findTickets();
		return "findsuccess";
	}
	//查看工单的详情信息
	public String ticketDetail() {
		staffService.TicketDetail(ticket);
		return "detailsuccess";
	}
	//根据工单ID查找工单
	public String findTicket() {
		staffService.findTicket(ticket);
		return "findsuccess";
	}
	//客服回复工单
	public  String replyTicket(){
		staffService.replyTicket(ticket);
		return "replysuccess";
	}
	//客服转交工单
	public String deliverTicket(){
		staffService.deliverTicket(ticket,game);
		return "deliversuccess";
	}
	//查看消息
	public String viewMessage(){
		staffService.viewMessage(message);
		return "viewsuccess";
	}
	//发送消息
	public String sendMessage(){
		staffService.sendMessage(message);
		return "sendsuccess";
	}
	//已阅消息
	public String confirmMessage(){
		staffService.confirmMessage(message);
		return "confirmsuccess";
	}
}