package sbeam.action.gamecontrol;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import sbeam.po.game.Game;
import sbeam.service.gamecontrol.IGameControlService;

import javax.persistence.criteria.CriteriaBuilder;
import java.io.File;
import java.io.IOException;
import java.util.Map;

public class GameControlAction {
    private File [] upload;              //得到上传的文件
    private String [] uploadContentType; //得到文件的类型
    private String [] uploadFileName;    //得到文件的名称
    private Game game;                   //游戏对象
    private Integer type;                //上传类型，个人开发者还是团队开发者
    private Integer []slecttypes;        //选择的游戏类型
    private int index;                   //文件索引值，删除游戏文件时使用
    private int days;                    //根据天数查询销售情况，天数


    //私有成员的setter和getter方法
    public File[] getUpload() {
        return upload;
    }
    public void setUpload(File[] upload) {
        this.upload = upload;
    }
    public String[] getUploadContentType() {
        return uploadContentType;
    }
    public void setUploadContentType(String[] uploadContentType) {
        this.uploadContentType = uploadContentType;
    }
    public String[] getUploadFileName() {
        return uploadFileName;
    }
    public void setUploadFileName(String[] uploadFileName) {
        this.uploadFileName = uploadFileName;
    }
    public Game getGame() {
        return game;
    }
    public void setGame(Game game) {
        this.game = game;
    }
    public Integer getType() {
        return type;
    }
    public void setType(Integer type) {
        this.type = type;
    }
    public Integer[] getSlecttypes() {
        return slecttypes;
    }
    public void setSlecttypes(Integer[] slecttypes) {
        this.slecttypes = slecttypes;
    }
    public int getIndex() {
        return index;
    }
    public void setIndex(int index) {
        this.index = index;
    }
    public int getDays() {
        return days;
    }
    public void setDays(int days) {
        this.days = days;
    }

    //外部依赖项
    private IGameControlService gameControlService;
    //外部依赖项的注入
    public void setGameControlService(IGameControlService gameControlService) {
        this.gameControlService = gameControlService;
    }


    //游戏上传
    public String gameupload(){
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        type = (Integer) session.get("type");
        gameControlService.gameupload(upload,uploadContentType,uploadFileName,game,type,slecttypes);
        return "gameupload";
    }

    //获取所有游戏类型
    public String getalltype(){
        gameControlService.getalltype(type);
        return "alltype";
    }

    //删除游戏
    public String delgame(){
        gameControlService.delgame(game);
        return "delgame";
    }

    //上传游戏前的中转
    public String preuploadnewversion(){
        return "preuploadnewversion";
    }

    //上传游戏新版本
    public String uploadnewversion(){
        //判空
        if(upload==null){
            ActionContext ctx = ActionContext.getContext();
            Map<String, Object> session = (Map) ctx.get("session");
            session.put("tip","上传文件不能为空，请重试！");
            return "uploadnewversion";
        }
        gameControlService.uploadnewversion(upload[0],uploadContentType[0],uploadFileName[0],game);
        return "uploadnewversion";
    }

    //获取游戏相关文件
    public String gamefiles(){
        gameControlService.gamefiles(game);
        return "gamefiles";
    }

    //删除一个游戏相关文件
    public String delgamefile(){
        gameControlService.delgamefile(index);
        return "delgamefile";
    }

    //上传一个游戏相关文件
    public String uploadNewGameFile(){
        //判空
        if(upload==null){
            ActionContext ctx = ActionContext.getContext();
            Map<String, Object> session = (Map) ctx.get("session");
            session.put("tip","上传文件不能为空，请重试！");
            return "uploadNewGameFile";
        }
        gameControlService.uploadNewGameFile(upload[0],uploadFileName[0],uploadContentType[0],game);
        return "uploadNewGameFile";
    }

    //获取游戏细节
    public String seeGameDetails(){
        gameControlService.getGame(game);
        return "seeGameDetails";
    }

    //获取一个游戏在一定日期内的销售情况
    public String getGameSaleStatus(){
        gameControlService.getGameSaleStatus(game,days);
        return "getGameSaleStatus";
    }

    //获取某个开发者一段时间内所有游戏的状态
    public String getAllGamesSaleStatus(){
        gameControlService.getAllGamesSaleStatus(days,type);
        return "getAllGamesSaleStatus";
    }



}
