package sbeam.dao.userDAO;

import sbeam.dao.BaseHibernateDAO;
import sbeam.po.user.Customer;

import java.util.List;

public class CustomerDAO extends BaseHibernateDAO
        implements ICustomerDAO {
    @Override
    public void save(Customer customer) {
        getSession().save(customer);
    }

    @Override
    public void delete(Customer customer) {
        getSession().delete(customer);
    }

    @Override
    public void update(Customer customer) {
        getSession().update(customer);
    }

    @Override
    public List query(String hql) {
        return getSession().createQuery(hql).list();
    }
}
