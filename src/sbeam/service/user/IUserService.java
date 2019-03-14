package sbeam.service.user;

import sbeam.po.user.Customer;

public interface IUserService {
    boolean login(Customer customer);

    boolean register(Customer customer);

    void update(Customer customer);

    void delete(Customer customer);

    void setShowGame(Customer customer, Integer orderId);

    void getShowGame(Integer customerId);

    void setCollection(Customer customer, Integer gameId);

    void getCollection(Customer customer);

    void addEvaluate(Customer customer, Integer gameId, String word, Integer star);

    void delEvaluate(Customer customer, Integer evaluateId);

    void getEvaluate(Customer customer);

    void getMyGame(Customer customer);

    void getOrder(Customer customer);

    void getFriendGame(Integer friendId);


}
