package sbeam.service.staff;

import sbeam.po.user.Customer;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.game.Game;
import sbeam.po.message.Message;
import sbeam.po.order.Order;
import sbeam.po.staff.Staff;
import sbeam.po.ticket.Ticket;

public interface IStaffService {
	public void findByHql();
	public boolean staffLogin(Staff staff);
	public void findOrder(Order order);
	public void findCustomer(Customer customer);
	public void findIDeveloper(IndividualDeveloper individualDeveloper);
	public void findTDeveloper(TeamDeveloper teamDeveloper);
	public void modifyOrder(Order order);
	public void updateCustomer(Customer customer);
	public void updateIDeveloper(IndividualDeveloper individualDeveloper);
	public void updateTDeveloper(TeamDeveloper teamDeveloper);
	public boolean dismissStaff(Staff staff);
	public boolean dispatchStaff(Staff staff);
	public void checkIDeveloper();
	public void checkTDeveloper();
	public void checkIDeveSuccess(IndividualDeveloper individualDeveloper);
	public void checkIDeveFail(IndividualDeveloper individualDeveloper);
	public void checkTDeveSuccess(TeamDeveloper teamDeveloper);
	public void checkTDeveFail(TeamDeveloper teamDeveloper);
	public void findGames();
	public void gameDetails(Game game);
	//public void checkGameCode();
	public void checkGameContentSuccess(Game game);
	public void checkGameContentFail(Game game);
	//public void checkGameCodeSuccess(Game game);
	//public void checkGameCodeFail(Game game);
	public void findAllTickets();
	public void findTickets();
	public void TicketDetail(Ticket ticket);
	public void findTicket(Ticket ticket);
	public void replyTicket(Ticket ticket);
	public void deliverTicket(Ticket ticket, Game game);
	public void viewMessage(Message message);
	public void sendMessage(Message message);
	public void confirmMessage(Message message);
}
