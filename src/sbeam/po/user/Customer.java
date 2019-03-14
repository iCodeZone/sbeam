package sbeam.po.user;

import sbeam.po.collection.GameCollection;
import sbeam.po.evaluate.Evaluate;
import sbeam.po.order.Order;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Customer {
    private Integer id;
    private String account;
    private String password;
    private String phone;
    private Date birthday;

    private Set<Order> orders = new HashSet<>(0);
    private Set<GameCollection> collections = new HashSet<>(0);
    private Set<Evaluate> evaluates = new HashSet<>(0);

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Set<Order> getOrders() {
        return orders;
    }

    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }

    public Set<Evaluate> getEvaluates() {
        return evaluates;
    }

    public void setEvaluates(Set<Evaluate> evaluates) {
        this.evaluates = evaluates;
    }

    public Set<GameCollection> getCollections() {
        return collections;
    }

    public void setCollections(Set<GameCollection> collections) {
        this.collections = collections;
    }

    @Override
    public String toString() {
        return "Customer [id=" + id
                + ",account=" + account
                + ",password=" + password
                + ",phone=" + phone
                + ",birthday=" + birthday
                + "]";
    }
}
