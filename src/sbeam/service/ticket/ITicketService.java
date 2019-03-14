package sbeam.service.ticket;

import sbeam.po.ticket.Ticket;

import java.io.File;

public interface ITicketService {
   public void send(Ticket ticket);
   public boolean upload(File upload, String uploadFileName, String uploadContentType);
   public boolean play();
}
