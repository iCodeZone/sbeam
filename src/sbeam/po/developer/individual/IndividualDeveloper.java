package sbeam.po.developer.individual;

import sbeam.po.developer.team.TeamDeveloper;

import java.util.Date;

//个人开发者持久化类
public class IndividualDeveloper {
    private Integer id;        //个人ID
    private String account;    //账户
    private String password;   //密码
    private String name;       //姓名
    private String idnumber;   //身份证号
    private Boolean check;     //是否已核验
    private TeamDeveloper team;//所属团队
    private String bankcard;   //银行卡号
    private Integer sid;           //核验者ID
    private Date time;         //核验时间

    public IndividualDeveloper(){}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdnumber() {
        return idnumber;
    }

    public void setIdnumber(String idnumber) {
        this.idnumber = idnumber;
    }

    public Boolean getCheck() {
        return check;
    }

    public void setCheck(Boolean check) {
        this.check = check;
    }

    public TeamDeveloper getTeam() {
        return team;
    }

    public void setTeam(TeamDeveloper team) {
        this.team = team;
    }

    public String getBankcard() {
        return bankcard;
    }

    public void setBankcard(String bankcard) {
        this.bankcard = bankcard;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
