package sbeam.service.game;

import com.opensymphony.xwork2.ActionContext;
import sbeam.dao.gameDAO.IGameDAO;
import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;
import sbeam.po.evaluate.Evaluate;
import sbeam.po.game.Game;
import sbeam.po.game.GameAndType;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

public class GameService implements IGameService {
    //session作用域
    ActionContext ctx;
    Map<String, Object> session;
    private IGameDAO gameDAO;

    //获取上传的游戏
    public void getgames(Integer type) {
        ctx = ActionContext.getContext();
        session = (Map) ctx.get("session");
        Integer temid;
        if (type == 1) {
            temid = ((IndividualDeveloper) session.get("indiDeve")).getId();
        } else {
            temid = ((TeamDeveloper) session.get("teamDeve")).getId();
        }
        String hql = "from Game as game where developerId='" + temid + "' and type='" + (type - 1) + "'";
        List games = gameDAO.findByHql(hql);
        session.put("games", games);
    }


    @Override
    public void getAllGame() {
        String hql = "from Game where ground=true and check=true";
        List game = gameDAO.query(hql);

        hql = "from GameType";
        List gameTypes = gameDAO.query(hql);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("allGame", game);
        session.put("gameTypes", gameTypes);
    }

    @Override
    public void getDiscount() {
        String hql = "from Game where ground=true and check=true and discountPrice<mallPrice";
        List discount = gameDAO.query(hql);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("DiscountGame", discount);
    }

    @Override
    public void getByType(Integer gameTypeId) {
        List<Game> games = new ArrayList<>();

        String hql = "from GameAndType where gameTypeId=" + gameTypeId;
        List<GameAndType> game = gameDAO.query(hql);

        for (GameAndType gameAndType : game) {
            Game typeGame = getGameById(gameAndType.getGameId());
            if (typeGame != null) {
                games.add(typeGame);
            }
        }
        System.out.println(games);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("allGameByType", games);


    }

    @Override
    public void getByWord(String word) {
        String hql = "from Game";
        List<Game> games = gameDAO.query(hql);
        List<Game> gameWord = new ArrayList<>();

        String pattern = ".*";
        for (int i = 0; i < word.length(); i++) {
            pattern = pattern + word.charAt(i) + ".*";
        }
        pattern = pattern.toLowerCase();
        for (Game game : games) {
            String aim = game.getName().toLowerCase();
            boolean isMatch = Pattern.matches(pattern, aim);
            if (isMatch) {
                gameWord.add(game);
            }
        }
        System.out.println(gameWord);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("allGameByWord", gameWord);
        session.put("keyWord", word);
    }

    @Override
    public void getById(Integer gameId) {
        Game game = getGameById(gameId);

        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("theGame", game);
        session.put("gameId", game.getId());

    }

    @Override
    public void getGameEvaluate(Integer gameId) {
        Game game = getGameById(gameId);
        Set<Evaluate> evaluates = game.getEvaluates();
        for (Evaluate evaluate : evaluates) {
            System.out.println(evaluate);
            System.out.println(evaluate.getCustomer());
        }
        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("theGameEvaluate", evaluates);

    }

    private Game getGameById(Integer gameId) {
        String hql = "from Game where ground=true and check=true and id=" + gameId;
        List<Game> list = gameDAO.query(hql);
        if (list.isEmpty()) return null;
        return list.get(0);
    }

    public void setGameDAO(IGameDAO gameDAO) {
        this.gameDAO = gameDAO;
    }
}
