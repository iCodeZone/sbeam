package sbeam.dao.developer;

import org.hibernate.Session;
import sbeam.po.developer.individual.IndividualDeveloper;

import java.util.List;

public interface IIndividualDeveloperDAO {
    //根据ID获取对象
    public IndividualDeveloper get(Integer id);
    //获取Session
    public Session getSession();
    //注册用户
    public void save(IndividualDeveloper indiDeve);
    //根据hql语句查询
    public List findByHql(String hql);
    //更新对象
    public void update(IndividualDeveloper indiDeve);
}
