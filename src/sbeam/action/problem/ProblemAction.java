package sbeam.action.problem;

import com.opensymphony.xwork2.ActionContext;
import sbeam.po.ticket.Ticket;
import sbeam.service.problem.IProblemService;

import java.io.File;
import java.util.Map;

public class ProblemAction {
    //私有属性
    private Ticket ticket;  //工单对象
    private File upload;    //问题截图
    private String uploadFileName;//文件名
    private String uploadContentType;//文件类型
    private String location;//返回时的界面地址
    private int type;       //用户类型
    private int index;      //第几个工单

    //私有属性的getter和setter方法
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
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
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
    public int getType() {
        return type;
    }
    public void setType(int type) {
        this.type = type;
    }
    public int getIndex() {
        return index;
    }
    public void setIndex(int index) {
        this.index = index;
    }


    //依赖的service
    private IProblemService problemService;
    //注入依赖项
    public void setProblemService(IProblemService problemService) {
        this.problemService = problemService;
    }

    //提交一个工单
    public String submitProblem(){
        //获取session
        //Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        //int type = (int)session.get("type");
        /*if(type==1){
            location = "/developer/IndiDeveLoginSuccess.jsp";
        }
        else{
            location = "/developer/TeamDeveLoginSuccess.jsp";
        }*/
        location = "/developer/LoginSuccessProblem.jsp";
        problemService.setNewProblem(ticket,upload,uploadFileName,uploadContentType);
        return "submitProblem";
    }

    //获取某用户的所有工单
    public String getAllProblem(){
        problemService.getAllProblem(type);
        return "getAllProblem";
    }

    //工单详情前置
    public String preProblemDetails(){
        System.out.println("index:"+index);
        return "preProblemDetails";
    }



}
