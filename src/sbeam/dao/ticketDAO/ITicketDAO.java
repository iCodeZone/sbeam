package sbeam.dao.ticketDAO;

import sbeam.po.message.Message;
import sbeam.po.ticket.Ticket;

import java.util.List;

public interface ITicketDAO {
    public List findByHql(String hql);
    public void send(Ticket ticket);
    public void update(Ticket ticket);

}
