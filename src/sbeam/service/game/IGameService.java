package sbeam.service.game;

public interface IGameService {
    void getAllGame();

    void getDiscount();

    void getByType(Integer gameTypeId);

    void getByWord(String word);

    void getById(Integer gameId);

    void getGameEvaluate(Integer gameId);

    //获取上传的游戏
    public void getgames(Integer type);

}
