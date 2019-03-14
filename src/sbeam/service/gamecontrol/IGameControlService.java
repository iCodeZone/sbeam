package sbeam.service.gamecontrol;

import sbeam.po.game.Game;

import java.io.File;
import java.util.List;

public interface IGameControlService {
    //上传游戏
    public void gameupload(File[] upload, String [] uploadContentType, String [] uploadFileName, Game game,Integer type,Integer [] slecttypes);
    //获取所有游戏类型
    public void getalltype(Integer type);
    //删除游戏
    public void delgame(Game game);
    //上传游戏的新版本
    public void uploadnewversion(File upload,String uploadContentType,String uploadFileName,Game game);
    //获取游戏相关文件
    public void gamefiles(Game game);
    //按照索引删除一个游戏文件
    public void delgamefile(int index);
    //上传一个游戏的文件
    public void uploadNewGameFile(File upload,String uploadFilename,String uploadContentType,Game game);
    //获取一个游戏
    public void getGame(Game game);
    //根据天数获取一个游戏的销售情况
    public void getGameSaleStatus(Game game,int days);
    //获取一个开发者一定天数内所有游戏的状态
    public void getAllGamesSaleStatus(int days,Integer type);
}
