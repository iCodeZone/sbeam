package sbeam.po.evaluate;

import sbeam.po.game.Game;
import sbeam.po.user.Customer;

public class Evaluate {
    private Integer id;
    private Integer star;
    private String word;
    private Customer customer;
    private Game game;

    @Override
    public String toString() {
        return getClass().getName()
                + "[id=" + id
                + ",star=" + star
                + ",word=" + word
                + "]";
    }

    public Integer game() {
        return id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }
}
