package sbeam.po.ticket;

import java.util.Date;

public class Ticket {
    private Integer pid;            //工单ID
    private Integer pfid;           //用户或开发者ID
    private Integer ptype;          //上传者类型（用户/开发者）
    private String pcontent;    //具体内容
    private Integer pstate;         //状态（已处理/待处理）
    private Date putime;        //反馈时间
    private Date petime;        //结束时间
    private String premes;      //反馈处理结果
    private String pphotoaddr;  //工单图片地址
    private Integer sid;            //处理工单的客服ID
    private Integer type;           //工单类型
    public Ticket(){}

    //getters方法
    public Integer getPid(){
        return pid;
    }
    public Integer getPfid(){
        return pfid;
    }
    public Integer getPtype(){
        return ptype;
    }
    public String getPcontent(){
        return pcontent;
    }
    public Integer getPstate(){
        return pstate;
    }
    public Date getPutime(){
        return putime;
    }
    public Date getPetime(){
        return petime;
    }
    public String getPremes(){
        return premes;
    }
    public String getPphotoaddr(){
        return pphotoaddr;
    }
    public Integer getSid(){
        return sid;
    }
    public Integer getType(){
        return type;
    }

    //setters方法
    public void setPid(Integer pid){
        this.pid = pid;
    }
    public void setPfid(Integer pfid){
        this.pfid = pfid;
    }
    public void setPtype(Integer ptype){
        this.ptype = ptype;
    }
    public void setPcontent(String pcontent){
        this.pcontent = pcontent;
    }
    public void setPstate(Integer pstate){
        this.pstate = pstate;
    }
    public void setPutime(Date putime){
        this.putime = putime;
    }
    public void setPetime(Date petime){
        this.petime = petime;
    }
    public void setPremes(String premes){
        this.premes = premes;
    }
    public void setPphotoaddr(String pphotoaddr){
        this.pphotoaddr = pphotoaddr;
    }
    public void setSid(Integer sid){
        this.sid = sid;
    }
    public void setType(Integer type){
        this.type = type;
    }
}

