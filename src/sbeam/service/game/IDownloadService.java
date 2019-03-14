package sbeam.service.game;

import sbeam.dao.gameDAO.IDownloadDAO;

import java.io.InputStream;

public interface IDownloadService {
    public boolean download(int gid);
    public String getFilename();
}
