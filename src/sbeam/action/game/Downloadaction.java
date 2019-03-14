package sbeam.action.game;

import org.apache.struts2.ServletActionContext;
import sbeam.po.game.Game;
import sbeam.service.game.IDownloadService;


import java.io.*;

import static com.opensymphony.xwork2.Action.SUCCESS;

public class Downloadaction {
    private IDownloadService iDownloadService;
    private  int gid;
    private InputStream is;
    private String fileName;

    public String download() {
        gid = 1;
        if (iDownloadService.download(gid)) {
            System.out.println("begin Download!");
            String realPath = ServletActionContext.getServletContext().getRealPath("/upload/game/");
            //获取文件夹
            File file=new File(realPath + iDownloadService.getFilename()+"/package");
            File files[] = file.listFiles();
            //获取文件流
            for(File f : files) {
                try {
                    is = new FileInputStream(f);
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
            }
            //设置文件名
            try {
                fileName = new String("game".getBytes(), "iso8859-1");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            System.out.println("end Download!");
            if (is == null) {
                System.out.println("null is!");
            } else System.out.println("not null is");
            return SUCCESS;
        }
        return "downloadFail";
    }
    public int getGid() {
        return gid;
    }

    public void setGid(int gid) {
        this.gid = gid;
    }

    public void setiDownloadService(IDownloadService iDownloadService) {
        this.iDownloadService = iDownloadService;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName =fileName;
    }

    public InputStream getIs() {
        return is;
    }

    public void setIs(InputStream is) {
        this.is = is;
    }
}
