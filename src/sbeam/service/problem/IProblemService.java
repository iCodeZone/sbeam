package sbeam.service.problem;

import sbeam.po.ticket.Ticket;

import java.io.File;

public interface IProblemService {
    //添加一个新工单
    public void setNewProblem(Ticket ticket, File upload, String uploadFileName, String uploadContentType);
    //获取某个人用户的所有工单
    public void getAllProblem(int type);
}
