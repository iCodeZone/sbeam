package sbeam.service.staff;


import java.util.Date;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import sbeam.dao.staff.IStaffDAO;
import sbeam.po.administrator.Administrator;
import sbeam.po.user.Customer;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.game.Game;
import sbeam.po.message.Message;
import sbeam.po.order.Order;
import sbeam.po.staff.Staff;
import sbeam.po.ticket.Ticket;
import sbeam.service.gamecontrol.IGameControlService;


public class StaffService implements IStaffService{
	private Map<String, Object> session;
	private IStaffDAO staffDAO = null;
	private IGameControlService gameControlService;
	public void setGameControlService(IGameControlService gameControlService){
		this.gameControlService = gameControlService;
	}
	public void setStaffDAO(IStaffDAO staffDAO){
		this.staffDAO = staffDAO;
	}
	//查找工作人员列表
	public void findByHql() {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from Staff where stype <> 9";
		List<Staff> Staffs = staffDAO.findByHql(hql);
		session.put("Staffs", Staffs);
	}
	//工作人员登录
	public boolean staffLogin(Staff staff) {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int sid = staff.getSid();
		String spassword = staff.getSpassword();
		String hql = "from Staff as user where sid='" + sid
				+ "' and spassword='" + spassword + "'"+"and stype <> 9";
		List list = staffDAO.findByHql(hql);
		if (list.size()==0) {
			session.put("loginfail","工作人员登录ID出错或密码出错");
			return false; 
		}
		else{
			staff=(Staff)list.get(0);
			session.put("staff", staff);     //存储工作人员对象
			if(staff.getStype()==0){
				session.put("type", 4);  //审核员登录类型记为4
			}
			if(staff.getStype()==1){
				session.put("type", 5);  //客服登录类型记为5
			}
			return true;
		}
	}
	//客服根据订单ID查找订单
	public void findOrder(Order order){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = order.getId();
		String hql = "from Order as user where oid=" + id;
		List list = staffDAO.findByHql(hql);
		if (list.size()==0) 
			session.put("OrderNull","找不到该订单！");
		else{
			Order Order=(Order)list.get(0);
			//解决懒加载问题
			Game game = Order.getGame();
			Customer customer = Order.getCustomer();
			System.out.println(game.getDir());
			System.out.println(customer.getAccount());
			session.put("Order", Order);
		}
	}
	//客服根据用户ID查找用户
	public void findCustomer(Customer customer){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = customer.getId();
		String hql = "from Customer as user where cid=" + id;
		List list = staffDAO.findByHql(hql);
		if (list.size()==0) 
			session.put("CustomerNull","找不到该用户！");
		else{
			Customer Customer=(Customer)list.get(0);
			session.put("Customer", Customer);
			session.put("isCustomer",true);
		}
	}
	//客服根据个人开发者ID查找个人开发者
	public void findIDeveloper(IndividualDeveloper individualDeveloper){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = individualDeveloper.getId();
		String hql = "from IndividualDeveloper as user where iid=" + id;
		List list = staffDAO.findByHql(hql);
		if (list.size()==0) 
			session.put("individualDeveloperNull","找不到该个人开发者！");
		else{
			IndividualDeveloper IndividualDeveloper=(IndividualDeveloper)list.get(0);
			session.put("IndividualDeveloper", IndividualDeveloper);
			session.put("isDeveloper",true);
		}
	}
	//客服根据团队开发者ID查找团队开发者
	public void findTDeveloper(TeamDeveloper teamDeveloper){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = teamDeveloper.getId();
		String hql = "from TeamDeveloper as user where tid=" + id;
		List list = staffDAO.findByHql(hql);
		if (list.size()==0) 
			session.put("TeamDeveloperNull","找不到该团队开发者！");
		else{
			TeamDeveloper TeamDeveloper=(TeamDeveloper)list.get(0);
			session.put("TeamDeveloper", TeamDeveloper);
		}
	}
	//客服修改订单状态
	public void modifyOrder(Order order){
		Order Order = (Order)session.get("Order");
		Order.setState(order.getState());
		staffDAO.modifyOrder(Order);
		session.put("Order",Order);
	}
	//客服更新用户信息
	public void updateCustomer(Customer customer){
		Customer Customer = (Customer)session.get("Customer");
		Customer.setPhone(customer.getPhone());   //重置用户的电话
		staffDAO.updateCustomer(Customer);
		session.put("Customer",Customer);
		session.put("isCustomer",false);
	}
	//客服更新个体开发者信息
	public void updateIDeveloper(IndividualDeveloper individualDeveloper){
		IndividualDeveloper IndividualDeveloper = (IndividualDeveloper)session.get("IndividualDeveloper");
		IndividualDeveloper.setIdnumber(individualDeveloper.getIdnumber()); //重置身份证号
		IndividualDeveloper.setBankcard(individualDeveloper.getBankcard()); //重置银行卡
		staffDAO.updateIDeveloper(IndividualDeveloper);
		session.put("IndividualDeveloper",IndividualDeveloper);
		session.put("isDeveloper",false);
	}
	//客服更新团队开发者的信息
	public void updateTDeveloper(TeamDeveloper teamDeveloper){
		List<TeamDeveloper> TDeveloper = (List<TeamDeveloper>)session.get("TDeveloper");
		/*此处修改团队开发者的信息*/
		staffDAO.updateTDeveloper(TDeveloper.get(0));
		session.put("TDeveloper",TDeveloper);
	}
	//辞退工作人员
	public boolean dismissStaff(Staff staff){
		try {
			Staff sta = new Staff();
			List<Staff> Staffs = (List<Staff>)session.get("Staffs");
			int id = staff.getSid();
			for(int i=0;i<Staffs.size();i++){
				if(((Staff)Staffs.get(i)).getSid()==id){
					sta = Staffs.get(i);
					Staffs.remove(i);
					break;
				}
			}
			sta.setStype(9);//出于简便的情况，不删除数据库内工作人员的账号，而是将其置为9，表示不再使用
			staffDAO.dismissStaff(staff); 	
			session.put("Staffs", Staffs);
			return true;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
	}
	//调度工作人员
	public boolean dispatchStaff(Staff staff){
		try {
			int id = staff.getSid();
			List<Staff> Staffs = (List<Staff>)session.get("Staffs");
			Staff sta= new Staff();
			for(int i=0;i<Staffs.size();i++){
				if(id==((Staff)Staffs.get(i)).getSid()){
					session.put("addStaffError","此编号已经存在，不可重复添加！！");
					return false;
				}
			}
			sta.setSid(staff.getSid());
			sta.setSpassword(staff.getSpassword());
			sta.setStype(staff.getStype());
			Staffs.add(sta);
			session.put("Staffs",Staffs);	
			staffDAO.dispatchStaff(sta); 
			return true;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
	}
	//审核个体开发者
	public void checkIDeveloper(){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from IndividualDeveloper where check = null";
		List IDevelopers = staffDAO.findByHql(hql);
		session.put("IDevelopers",IDevelopers);
		session.put("developerType",0);
	}
	//审核团队开发者
	public void checkTDeveloper(){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from TeamDeveloper where check = null";
		List TDevelopers = staffDAO.findByHql(hql);
		session.put("TDevelopers",TDevelopers);
		session.put("developerType",1);
	}
	//个体开发者审核通过
	public void checkIDeveSuccess(IndividualDeveloper individualDeveloper){
		try {	
			List<IndividualDeveloper> IDevelopers = (List<IndividualDeveloper>)session.get("IDevelopers");
			int id = individualDeveloper.getId();
			IndividualDeveloper IDeveloper = new IndividualDeveloper();
			for(int i=0;i<IDevelopers.size();i++){
				if(((IndividualDeveloper)IDevelopers.get(i)).getId()==id){
					IDevelopers.get(i).setCheck(true);
					IDeveloper = IDevelopers.get(i);
					IDevelopers.remove(i);
					break;
				}
			}
			Staff staff = (Staff)session.get("staff");
			Date date = new Date();
			IDeveloper.setTime(date);
			IDeveloper.setSid(staff.getSid());
			staffDAO.checkIDeve(IDeveloper); 
			session.put("IDevelopers", IDevelopers);
			//审核完成的时候，需要发送消息给对方	
			Message message = new Message();
			message.setContent("恭喜！您的个人开发者身份认证成功，欢迎加入我们！");
			message.setTime(date);   //存入时间
			message.setType(2);      //存入发送对象类型
			message.setCheck(false);
			message.setTid(id);  //填入个人开发者ID
			staffDAO.sendMessage(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	//个体开发者审核失败
	public void checkIDeveFail(IndividualDeveloper individualDeveloper){
		try {	
			List<IndividualDeveloper> IDevelopers = (List<IndividualDeveloper>)session.get("IDevelopers");
			int id = individualDeveloper.getId();
			IndividualDeveloper IDeveloper = new IndividualDeveloper();
			for(int i=0;i<IDevelopers.size();i++){
				if(((IndividualDeveloper)IDevelopers.get(i)).getId()==id){
					IDevelopers.get(i).setCheck(false);
					IDeveloper = IDevelopers.get(i);
					IDevelopers.remove(i);
					break;
				}
			}
			Staff staff = (Staff)session.get("staff");
			Date date = new Date();
			IDeveloper.setTime(date);
			IDeveloper.setSid(staff.getSid());
			staffDAO.checkIDeve(IDeveloper); 
			session.put("IDevelopers", IDevelopers);
			//审核完成的时候，需要发送消息给对方	
			Message message = new Message();
			message.setContent("很抱歉，您的个人开发者身份认证失败，请将您的注册信息填充详细或加以修改。");
			message.setTime(date);   //存入时间
			message.setType(2);      //存入发送对象类型
			message.setCheck(false);
			message.setTid(id);  //填入个人开发者ID
			staffDAO.sendMessage(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	//团队开发者审核通过
	public void checkTDeveSuccess(TeamDeveloper teamDeveloper){
		try {	
			List<TeamDeveloper> TDevelopers = (List<TeamDeveloper>)session.get("TDevelopers");
			int id = teamDeveloper.getId();
			TeamDeveloper TDeveloper = new TeamDeveloper();
			for(int i=0;i<TDevelopers.size();i++){
				if(((TeamDeveloper)TDevelopers.get(i)).getId()==id){
					TDevelopers.get(i).setCheck(true);
					TDeveloper = TDevelopers.get(i);
					TDevelopers.remove(i);
					break;
				}
			}
			Staff staff = (Staff)session.get("staff");
			Date date = new Date();
			TDeveloper.setTime(date);
			TDeveloper.setSid(staff.getSid());
			staffDAO.checkTDeve(TDeveloper); 
			session.put("TDevelopers", TDevelopers);
			//审核完成的时候，需要发送消息给对方
			Message message = new Message();
			message.setContent("恭喜！您的团队信息审核通过，祝您生活愉快！！");
			message.setTime(date);   //存入时间
			message.setType(3);      //存入发送对象类型
			message.setCheck(false);
			message.setTid(id);  //填入团队开发者ID
			staffDAO.sendMessage(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	//团队开发者审核失败
	public void checkTDeveFail(TeamDeveloper teamDeveloper){
		try {	
			List<TeamDeveloper> TDevelopers = (List<TeamDeveloper>)session.get("TDevelopers");
			int id = teamDeveloper.getId();
			TeamDeveloper TDeveloper = new TeamDeveloper();
			for(int i=0;i<TDevelopers.size();i++){
				if(((TeamDeveloper)TDevelopers.get(i)).getId()==id){
					TDevelopers.get(i).setCheck(false);
					TDeveloper = TDevelopers.get(i);
					TDevelopers.remove(i);
					break;
				}
			}
			Staff staff = (Staff)session.get("staff");
			Date date = new Date();
			TDeveloper.setTime(date);
			TDeveloper.setSid(staff.getSid());
			staffDAO.checkTDeve(TDeveloper); 
			session.put("TDevelopers", TDevelopers);
			//审核完成的时候，需要发送消息给对方	
			Message message = new Message();
			message.setContent("很抱歉，您申请团队开发者身份失败，请将团队的注册信息填充详细或加以修改。");
			message.setTime(date);   //存入时间
			message.setType(2);      //存入发送对象类型
			message.setCheck(false);
			message.setTid(id);  //填入团队开发者ID
			staffDAO.sendMessage(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	//查找游戏  --未经过审核
	public void findGames(){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from Game where gcheck = null";
		List Games = staffDAO.findByHql(hql);
		session.put("Games",Games);
		if(Games.size()==0){
			session.put("nullGames",false);
		}
		else{
			session.put("nullGames",true);
		}
	}
	//查看游戏详情
	public void gameDetails(Game game){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = game.getId();
		String hql = "from Game where gid ="+id;
		List Games = staffDAO.findByHql(hql);
		Game Game = (Game)Games.get(0);
		if(Game.getType()){  //如果游戏由团队开发者开发
			hql = "from TeamDeveloper where tid = "+Game.getDeveloperId();
			List deve = staffDAO.findByHql(hql);
			TeamDeveloper developer = (TeamDeveloper)deve.get(0); 
			session.put("developer",developer);
		}
		if(!Game.getType()){   //游戏由个体开发者开发
			System.out.println(Game.getDeveloperId());
			hql = "from IndividualDeveloper where iid = "+Game.getDeveloperId();
			List deve = staffDAO.findByHql(hql);
			IndividualDeveloper developer = (IndividualDeveloper)deve.get(0); 
			session.put("developer",developer);
		}
		session.put("Game",Game);
	}
	//审核者审核游戏代码
	/*public void checkGameCode(){
		try {
            Thread.sleep(5000);    //延迟的时间用来展示审核动画进度条
        } catch (InterruptedException e) {
            e.printStackTrace(); 
        }
	}*/
	
	//审核游戏内容通过
	public void checkGameContentSuccess(Game game){
		try {	
			List<Game> Games = (List<Game>)session.get("Games");
			int id = game.getId();
			Game ga = new Game();
			for(int i=0;i<Games.size();i++){
				if(((Game)Games.get(i)).getId()==id){
					Games.get(i).setCheck(true);
					ga = Games.get(i);   
					/*此处进行游戏代码审核*/
					/*若不通过，则将状态置为false*/
					Games.remove(i);
					break;
				}
			}
			Date date = new Date();
			int sid = ((Staff)session.get("staff")).getSid();
			ga.setCtime(date);
			ga.setSid(sid);
			staffDAO.checkGame(ga);
			session.put("Games",Games);
			if(Games.size()==0){
				session.put("nullGames",false);
			}
			//审核完成的时候，需要发送消息给对方	
			Message message = new Message();
			message.setContent("恭喜！您的游戏已经通过我们的审核，祝您的游戏能够得到大家的认可！");
			message.setTime(date);   //存入时间
			if(ga.getType()==false){
				message.setType(2);      //发送给个人开发者
			}
			if(ga.getType()==true){
				message.setType(3);      //发送给团队开发者
			}
			message.setCheck(false);
			message.setTid(ga.getDeveloperId());  //填入开发者ID
			staffDAO.sendMessage(message);
		} catch (Exception e) {
			throw e;
		}
	}
	//审核游戏内容失败
	public void checkGameContentFail(Game game){
		try {	
			List<Game> Games = (List<Game>)session.get("Games");
			int id = game.getId();
			Game ga = new Game();
			for(int i=0;i<Games.size();i++){
				if(((Game)Games.get(i)).getId()==id){
					Games.get(i).setCheck(false);
					ga = Games.get(i);
					Games.remove(i);
					break;
				}
			}
			Date date = new Date();
			int sid = ((Staff)session.get("staff")).getSid();
			ga.setCtime(date);
			ga.setSid(sid);
			staffDAO.checkGame(ga);
			session.put("Games",Games);
			if(Games.size()==0){
				session.put("nullGames",false);
			}
			/*此处将游戏从服务器中删除*/
			gameControlService.delgame(game);
			//审核完成的时候，需要发送消息给对方
			Message message = new Message();
			message.setContent("很抱歉，您上传的游戏未通过审核，请继续努力！");
			message.setTime(date);   //存入时间
			if(ga.getType()==false){
				message.setType(2);      //发送给个人开发者
			}
			if(ga.getType()==true){
				message.setType(3);      //发送给团队开发者
			}
			message.setCheck(false);
			message.setTid(ga.getDeveloperId());  //填入开发者ID
			staffDAO.sendMessage(message);
		} catch (Exception e) {
			throw e;
		}
	}
	
	//审核游戏代码通过
	//public void checkGameCodeSuccess(Game game){}
	//审核游戏代码失败
	//public void checkGameCodeFail(Game game){}
	
	//查找所有工单
	public void findAllTickets() {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from Ticket";
		List Tickets = staffDAO.findByHql(hql);
		session.put("Tickets", Tickets);
	}
	//查找未处理的工单
	public void findTickets() {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		String hql = "from Ticket where pstate = 0";
		List Tickets = staffDAO.findByHql(hql);
		session.put("Tickets", Tickets);
	}
	//根据工单ID查看工单详情
	public void TicketDetail(Ticket ticket) {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = ticket.getPid();
		String hql = "from Ticket where pid = "+id;
		List Ticket = staffDAO.findByHql(hql);
		session.put("Ticket", Ticket);
		if(Ticket.size()==0)
			session.put("nullTicket",false);
		else
			session.put("nullTicket",true);
	}
	//根据工单ID和工单类型查找工单
	public void findTicket(Ticket ticket) {
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = ticket.getPid();
		int type = ticket.getType();
		String hql = "from Ticket where pid = "+id+"and type = " + type;
		List Ticket = staffDAO.findByHql(hql);
		session.put("Ticket", Ticket);
	}
	//客服回复工单
	public void replyTicket(Ticket ticket){
		List<Ticket> Tickets = (List<Ticket>)session.get("Tickets");
		int id = ticket.getPid();
		Ticket tic = new Ticket();
		for(int i=0;i<Tickets.size();i++){
			if(Tickets.get(i).getPid()==id){
				Date date = new Date();
				Staff staff = (Staff)session.get("staff");
				Tickets.get(i).setPetime(date);          //存入处理该工单的时间
				Tickets.get(i).setSid(staff.getSid());   //存入处理该工单的客服ID
				Tickets.get(i).setPremes(ticket.getPremes()); //存入客服的回复
				Tickets.get(i).setPstate(1);   //该工单状态置为已处理
				tic = Tickets.get(i);
				Tickets.remove(i);
				//回复的时候，需要发送消息给对方	
				Message message = new Message();
				message.setContent("您的工单已处理");
				message.setTime(date);   //存入时间
				message.setType(tic.getPtype());      //开发者或用户类型
				message.setCheck(false);
				message.setTid(tic.getPfid());  //填入用户或开发者ID
				staffDAO.sendMessage(message);
				break;
			}
		}
		staffDAO.replyTicket(tic);
	}
	//客服转交工单
	public void deliverTicket(Ticket ticket,Game game){
		List<Ticket> Tickets = (List<Ticket>)session.get("Tickets");
		int id = ticket.getPid();
		Ticket tic = new Ticket();
		for(int i=0;i<Tickets.size();i++){
			if(Tickets.get(i).getPid()==id){
				Date date = new Date();
				Staff staff = (Staff)session.get("staff");
				Tickets.get(i).setSid(staff.getSid());   //存入处理该工单的客服ID
				//递交工单--通过发送消息完成
				Message message = new Message();
				message.setContent(
						"<form action='messageDetail' method='post'>"
						+ "<input type='hidden' name='ticket.pid' value='"+id+"'/>"
						+ "<input type='submit' class='btn btn-warning' value='点击查看详情'/>"
						+ "</form>");
				message.setTime(date);   //存入时间
				if(Tickets.get(i).getType()==2){   //bug问题提交给开发者
					if(game.getType()==false){
						message.setType(2);             //发给个人开发者
						message.setTid(tic.getPfid());  //填写个人开发者ID  **此处存在问题，填入的ID是发送工单的人的ID而不是个人开发者的ID**
					}
					else if(game.getType()==true){
						message.setType(3);             //发给团队开发者
						message.setTid(tic.getPfid());  //填写团队开发者ID  **此处存在问题，填入的ID是发送工单的人的ID而不是团队开发者的ID**
					}
				}
				else if(Tickets.get(i).getType()==3){   //侵权问题则递交给管理员
					message.setType(4);      //发给管理员
					message.setTid(1);       //默认发给1号管理员
				}
				message.setCheck(false);
				staffDAO.sendMessage(message);
				tic = Tickets.get(i);
				Tickets.remove(i);    //不再展示在页面中
				//递交的时候，需要发送消息给对方
				message = new Message();
				message.setContent("您的工单正在处理中");
				message.setTime(date);   //存入时间
				message.setType(1);      //存入发送对象类型
				message.setCheck(false);
				message.setTid(staff.getSid());  //填入客服ID
				staffDAO.sendMessage(message);
				break;
			}
		}
		staffDAO.deliverTicket(tic);
	}
	//查看消息
	public void viewMessage(Message message){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		Integer type = message.getType();
		String hql="select Message where type = "+type;
		List<Message> Messages = staffDAO.findByHql(hql);
		session.put("Messages",Messages);
	}
	//发送消息
	public void sendMessage(Message message){
		staffDAO.sendMessage(message);	
	}
	//已阅消息
	public void confirmMessage(Message message){
		ActionContext ctx= ActionContext.getContext();
		session=(Map) ctx.getSession();
		int id = message.getId();
		List<Message> Messages = (List<Message>)session.get("Messages");
		Message mess = new Message();
		for(int i=0;i<Messages.size();i++){
			System.out.println(Messages.get(i).getId()+"------");
			if(Messages.get(i).getId()==id){
				Messages.get(i).setCheck(true);  //状态置为已阅
				mess = Messages.get(i); 
				Messages.remove(i);              //从列表中移出，不再显示
				break;
			}
		}
		staffDAO.confirmMessage(mess);
	}
}
