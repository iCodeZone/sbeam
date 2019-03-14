package sbeam.po.message;

import java.util.Date;

public class Message {
    private Integer id;    //消息ID
    private Date time;     //消息创建时间
    private String content;//消息的具体内容
    private boolean check; //消息是否已看
    private Integer tid;   //发送对象的ID
    private  Integer type; //对象类型 1客户2个人开发者3团队开发者

    //无参构造方法
    public Message(){}

    //有参构造方法
    public Message(Date time,String content,Boolean check,Integer tid,Integer type){
        this.time=time;
        this.content=content;
        this.check=check;
        this.tid=tid;
        this.type=type;
    }

    //私有属性的setter与getter方法
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean getCheck() {
        return check;
    }

    public void setCheck(boolean check) {
        this.check = check;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
