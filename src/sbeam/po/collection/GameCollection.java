package sbeam.po.collection;

import sbeam.po.game.Game;
import sbeam.po.user.Customer;

public class GameCollection {
    private Integer id;
    private Game game;
    private Customer customer;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Override
    public String toString() {
        return "GameCollection{" +
                "id=" + id +
                ", game=" + game +
                ", customer=" + customer +
                '}';
    }
}
