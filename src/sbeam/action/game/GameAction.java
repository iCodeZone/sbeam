package sbeam.action.game;

import sbeam.service.game.IGameService;

public class GameAction {
    private IGameService gameService;
    private Integer gameTypeId;
    private Integer gameId;
    private String word;
    private Integer type;

    //获得上传的游戏列表
    public String gamelist() {
        gameService.getgames(type);
        return "gamelist";
    }

    public String getAllGame() {
        gameService.getAllGame();
        return "success";
    }

    public String getDiscount() {
        gameService.getDiscount();
        return "success";
    }

    public String getByType() {
        gameService.getByType(gameTypeId);
        System.out.println("getByTypeSuccess");
        return "success";
    }

    public String getByWord() {
        gameService.getByWord(word);
        System.out.println("getByWord success");
        return "success";
    }

    public String getById() {
        gameService.getById(gameId);
        System.out.println("getById success");
        return "success";
    }

    public String getGameEvaluate() {
        gameService.getGameEvaluate(gameId);
        return "success";
    }

    //私有属性的getter与setter方法
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public IGameService getGameService() {
        return gameService;
    }

    public void setGameService(IGameService gameService) {
        this.gameService = gameService;
    }

    public Integer getGameTypeId() {
        return gameTypeId;
    }

    public void setGameTypeId(Integer gameTypeId) {
        this.gameTypeId = gameTypeId;
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }
}
