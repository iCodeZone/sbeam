package sbeam.action.order;

import sbeam.po.game.Game;
import sbeam.po.order.Order;
import sbeam.service.order.IorderService;

public class Orderaction {
    private IorderService iorderService;
    private Game game = new Game();
    private Order od = new Order();
    private int gid;

    public Orderaction() {
    }

    public String buy() {
        od.setGame(iorderService.getGame(gid));
        iorderService.buy(od);
        iorderService.pay(gid);
        System.out.println("buy success");
        return "buySuccess";
    }

    public IorderService getIorderService() {
        return iorderService;
    }

    public void setIorderService(IorderService iorderService) {
        this.iorderService = iorderService;
    }

    private Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public int getGid() {
        return gid;
    }

    public void setGid(int gid) {
        this.gid = gid;
    }
}
