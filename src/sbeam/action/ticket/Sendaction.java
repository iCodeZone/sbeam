package sbeam.action.ticket;


import sbeam.po.ticket.Ticket;
import sbeam.service.ticket.ITicketService;

import java.io.File;

public class Sendaction {
    private Ticket ticket;
    private File upload;//问题截图
    private ITicketService ticketService;
    private String uploadFileName;//文件名
    private String uploadContentType;//文件类型

    public String send() {
        System.out.println("Sendaction send");
        ticketService.send(ticket);
        if (ticketService.upload(upload, uploadFileName, uploadContentType))
            return "sendSuccess";
        return "sendFail";
    }

    public String play() {
        System.out.println("Sendaction send");
        if (ticketService.play())
            return "playSuccess";
        return "playFail";
    }


    public void setTicketService(ITicketService ticketService) {
        this.ticketService = ticketService;
    }

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public File getUpload() {
        return upload;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public String getUploadContentType() {
        return uploadContentType;
    }

    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }
}
