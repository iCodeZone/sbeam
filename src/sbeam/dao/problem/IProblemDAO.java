package sbeam.dao.problem;

import sbeam.po.ticket.Ticket;

import java.util.List;

public interface IProblemDAO {
    //保存一个工单
    public void save(Ticket ticket);
    //根据hql查询对象
    public List findByHql(String hql);
    //更新一个数据
    public void update(Ticket ticket);
}
