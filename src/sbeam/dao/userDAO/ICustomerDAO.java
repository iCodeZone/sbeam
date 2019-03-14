package sbeam.dao.userDAO;

import sbeam.po.user.Customer;

import java.util.List;

public interface ICustomerDAO {
    void save(Customer customer);//增

    void delete(Customer customer);//删

    void update(Customer customer);//改

    List query(String hql);//查

}
