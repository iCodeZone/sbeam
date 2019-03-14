package sbeam.service.game;

import org.apache.struts2.ServletActionContext;
import sbeam.dao.gameDAO.IDownloadDAO;
import sbeam.po.game.Game;

import java.io.*;
import java.util.List;


public class Downloadservice implements IDownloadService{
    private IDownloadDAO idownloadDAO;
    private String fileName;

    public Downloadservice(){
        System.out.println("create Downloadservice.");
    }

    public IDownloadDAO getIdownloadDAO() {
        return idownloadDAO;
    }

    public void setIdownloadDAO(IDownloadDAO idownloadDAO) {
        System.out.println("--setIdownloadDAO--");
        this.idownloadDAO = idownloadDAO;
    }

    public boolean download(int gid){
        String hql = "from Game as game where id='" + gid +"'";
        List list = idownloadDAO.findByHql(hql);
        Game game=new Game();
        if (list.isEmpty()) {
            return false;
        }
        else {
            game = (Game) list.get(0);
            fileName=game.getName();
            return true;
        }
    }

    public String getFilename() {
        return fileName;
    }

    public void setFilename(String filename) {
        this.fileName = filename;
    }
}

