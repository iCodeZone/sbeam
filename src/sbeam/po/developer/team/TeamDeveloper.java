package sbeam.po.developer.team;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class TeamDeveloper {
    private Integer id;       //编号
    private String name;      //团队名称
    private String password;  //密码
    private String address;   //团队地址
    private String registmark;//公司注册编号
    private String website;   //公司网站
    private String bankcard;  //银行卡号
    private Boolean check;    //是否已经审核
    private Integer sid;      //核验者ID
    private Date time;        //核验时间
    private Set staffs=new HashSet(0);//成员

    public TeamDeveloper(){}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRegistmark() {
        return registmark;
    }

    public void setRegistmark(String registmark) {
        this.registmark = registmark;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getBankcard() {
        return bankcard;
    }

    public void setBankcard(String bankcard) {
        this.bankcard = bankcard;
    }

    public Boolean getCheck() {
        return check;
    }

    public void setCheck(Boolean check) {
        this.check = check;
    }

    public Set getStaffs() {
        return staffs;
    }

    public void setStaffs(Set staffs) {
        this.staffs = staffs;
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
