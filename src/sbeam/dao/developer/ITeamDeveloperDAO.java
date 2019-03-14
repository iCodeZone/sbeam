package sbeam.dao.developer;

import sbeam.po.developer.team.TeamDeveloper;

import java.util.List;

//团队开发者DAO接口
public interface ITeamDeveloperDAO {
    //用于存取数据
    public void save(TeamDeveloper teamDeve);
    //根据hql语句查询数据
    public List findByHql(String hql);
    //根据ID获取对象
    public TeamDeveloper get(Integer id);
    //更新对象
    public void update(TeamDeveloper teamDeve);
}
