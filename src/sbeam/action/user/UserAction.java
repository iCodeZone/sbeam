package sbeam.action.user;

import sbeam.po.user.Customer;
import sbeam.service.user.IUserService;

public class UserAction {
    private IUserService userService;
    private Customer loginUser;
    private Integer orderId;
    private Integer friendId;
    private Integer gameId;
    private String word;
    private Integer star;
    private Integer evaluateId;

    /* 登录 */
    public String login() {
        System.out.println("UserAction login");
        if (userService.login(loginUser)) {
            System.out.println("login success");
            return "loginSuccess";
        }
        System.out.println("login fail");
        return "loginFail";
    }

    /* 仅修改个人信息 */
    public String update() {
        System.out.println("user update");
        System.out.println(loginUser);
        userService.update(loginUser);
        System.out.println("update success");
        return "updateSuccess";

    }

    /* 注销用户 */
    public String delete() {
        System.out.println("user delete");
        userService.delete(loginUser);
        System.out.println("delete success");
        return "deleteSuccess";
    }

    /* 注册 */
    public String register() {
        System.out.println("user register");
        System.out.println(loginUser);
        if (userService.register(loginUser)) {
            System.out.println("register success");
            return "registerSuccess";
        }
        System.out.println("register fail");
        return "registerFail";
    }

    /* 设置展示游戏 */
    public String setShowGame() {
        userService.setShowGame(loginUser, orderId);
        return "success";
    }

    /* 获得展示游戏 */
    public String getShowGame() {
        System.out.println("user getShowGame");
        userService.getShowGame(friendId);
        System.out.println("getShowSuccess");
        return "success";
    }

    /* 设置收藏 */
    public String setCollection() {
        System.out.println(gameId);
        System.out.println(loginUser.getId());
        System.out.println("user collection");
        userService.setCollection(loginUser, gameId);
        System.out.println("collection success");
        return "success";
    }

    /* 获得收藏 */
    public String getCollection() {
        userService.getCollection(loginUser);
        return "success";
    }

    /* 设置评价 */
    public String addEvaluate() {
        System.out.println("user evaluate");
        userService.addEvaluate(loginUser, gameId, word, star);
        System.out.println("evaluate success");
        return "success";
    }

    /* 删除评价 */
    public String delEvaluate() {
        System.out.println("user evaluate");
        userService.delEvaluate(loginUser, evaluateId);
        System.out.println("evaluate success");
        return "success";
    }

    /* 获得评价 */
    public String getEvaluate() {
        userService.getEvaluate(loginUser);
        return "success";
    }

    /* 获得已经购买的游戏 */
    public String getMyGame() {
        userService.getMyGame(loginUser);
        return "success";
    }

    /* 获得订单 */
    public String getOrder() {
        userService.getOrder(loginUser);
        return "success";
    }

    public String getFriendGame() {
        userService.getFriendGame(friendId);
        return "success";
    }


    public IUserService getUserService() {
        return userService;
    }

    public void setUserService(IUserService userService) {
        this.userService = userService;
    }

    public Customer getLoginUser() {
        return loginUser;
    }

    public void setLoginUser(Customer loginUser) {
        this.loginUser = loginUser;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getFriendId() {
        return friendId;
    }

    public void setFriendId(Integer friendId) {
        this.friendId = friendId;
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

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public Integer getEvaluateId() {
        return evaluateId;
    }

    public void setEvaluateId(Integer evaluateId) {
        this.evaluateId = evaluateId;
    }
}
