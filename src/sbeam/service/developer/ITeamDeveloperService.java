package sbeam.service.developer;

import sbeam.po.developer.individual.IndividualDeveloper;
import sbeam.po.developer.team.TeamDeveloper;

//团队开发者Service接口
public interface ITeamDeveloperService {
    //处理注册逻辑
    public boolean register(TeamDeveloper teamDeve);
    //根据hql语句查询对象
    public TeamDeveloper findByHql(String hql);
    //处理登录逻辑
    public boolean login(TeamDeveloper teamDeve);
    //从团队中删除成员
    public void deletestaff(TeamDeveloper teamDeve, IndividualDeveloper indiDeve);
    //确认成员加入申请
    public void acceptstaff(int iid, int tid, boolean accept);
    //根据ID查找个人开发者
    public void findindi(IndividualDeveloper indiDeve);
    //根据信息给个人发送邀请加入的消息
    public  void inviteindi(IndividualDeveloper indiDeve, TeamDeveloper teamDeve);
    //修改团队信息
    public boolean alterTeamData(TeamDeveloper teamDeve);
}
