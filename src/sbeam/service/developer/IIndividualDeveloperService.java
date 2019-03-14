package sbeam.service.developer;

import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;

public interface IIndividualDeveloperService {
    //注册
    public boolean register(IndividualDeveloper indiDeve);
    //登录
    public boolean login(IndividualDeveloper indiDeve);
    //根据hql语句查询对象
    public IndividualDeveloper findByHql(String hql);
    //根据团队ID找团队
    public void findteam(TeamDeveloper teamDeve);
    //根据请求发出消息
    public void jointeam(IndividualDeveloper indiDeve, TeamDeveloper teamDeve);
    //个人退出团队
    public void quitteam(IndividualDeveloper indiDeve);
    //是否接受团队邀请
    public void acceptteam(int iid, int tid, boolean accept);
    //修改个人数据
    public boolean alterIndiData(IndividualDeveloper indiDeve);
}
