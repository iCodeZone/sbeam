package sbeam.dao.staff;

import java.util.List;

import sbeam.po.user.Customer;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.game.Game;
import sbeam.po.game.GameType;
import sbeam.po.message.Message;
import sbeam.po.order.Order;
import sbeam.po.staff.Staff;
import sbeam.po.ticket.Ticket;

public interface IStaffDAO {
	public List findByHql(String hql);
	public void modifyOrder(Order order);
	public void updateCustomer(Customer customer);
	public void updateIDeveloper(IndividualDeveloper individualDeveloper);
	public void updateTDeveloper(TeamDeveloper teamDeveloper);
	public void dismissStaff(Staff staff);
	public void dispatchStaff(Staff staff);
	public void checkIDeve(IndividualDeveloper individualDeveloper);
	public void checkTDeve(TeamDeveloper teamDeveloper);
	public void checkGame(Game game);
	public void replyTicket(Ticket ticket);
	public void deliverTicket(Ticket ticket);
	public void sendMessage(Message message);
	public void confirmMessage(Message message);
}
