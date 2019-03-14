package sbeam.po.game;

import sbeam.po.evaluate.Evaluate;
import sbeam.po.order.Order;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Game implements Serializable {
    private Integer id;         //游戏ID
    private Boolean type;       //开发者类型(个人0团队1)
    private Integer developerId;//开发者id
    private Date updatedate;    //上传时间
    private String name;        //游戏名
    private String dir;         //游戏存储地址
    private Double developerPrice;//开发者价格
    private Double mallPrice;     //商城价格
    private Double discountPrice; //折扣价
    private Boolean check;        //是否通过审核
    private Boolean ground;       //是否上架
    private Integer gpv;          //访问量
    private Integer sid;          //审核者ID
    private Date ctime;           //审核时间

    private Set<GameType> types;//游戏类型

    private Set<Evaluate> evaluates;//评价

    public Game(){ }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getType() {
        return type;
    }

    public void setType(Boolean type) {
        this.type = type;
    }

    public Integer getDeveloperId() {
        return developerId;
    }

    public void setDeveloperId(Integer developerId) {
        this.developerId = developerId;
    }

    public Date getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Date updatedate) {
        this.updatedate = updatedate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDir() {
        return dir;
    }

    public void setDir(String dir) {
        this.dir = dir;
    }

    public Double getDeveloperPrice() {
        return developerPrice;
    }

    public void setDeveloperPrice(Double developerPrice) {
        this.developerPrice = developerPrice;
    }

    public Double getMallPrice() {
        return mallPrice;
    }

    public void setMallPrice(Double mallPrice) {
        this.mallPrice = mallPrice;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public Boolean getCheck() {
        return check;
    }

    public void setCheck(Boolean check) {
        this.check = check;
    }

    public Boolean getGround() {
        return ground;
    }

    public void setGround(Boolean ground) {
        this.ground = ground;
    }

    public Integer getGpv() {
        return gpv;
    }

    public void setGpv(Integer gpv) {
        this.gpv = gpv;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    public Set<GameType> getTypes() {
        return types;
    }

    public void setTypes(Set<GameType> types) {
        this.types = types;
    }

    public Set<Evaluate> getEvaluates() {
        return evaluates;
    }

    public void setEvaluates(Set<Evaluate> evaluates) {
        this.evaluates = evaluates;
    }
}
