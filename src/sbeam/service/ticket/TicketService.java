package sbeam.service.ticket;

import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import sbeam.dao.ticketDAO.ITicketDAO;
import sbeam.po.ticket.Ticket;
import sbeam.po.user.Customer;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class TicketService implements ITicketService {
    private ITicketDAO ticketDAO;

    public void send(Ticket ticket) {//发送工单
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        Date date = new Date();
        date.setTime(date.getTime() / 1000 * 1000l);
        ticket.setPutime(date);//获取系统时间
        Customer customer = (Customer) session.get("user");
        ticket.setPfid(customer.getId());//设置发送用户id
        ticket.setPtype(0);//设置用户类型
        ticket.setPstate(0);//设置处理状态（未处理）
        ticketDAO.send(ticket);
        ActionContext context = ActionContext.getContext();
        session = context.getSession();
        session.put("ticket", ticket);
    }

    public boolean upload(File upload, String uploadFileName, String uploadContentType) {//上传图片
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        Ticket ticket = (Ticket) session.get("ticket");
        if (upload != null) {
            System.out.println("in");
            //判断文件类型是否是图片
            if (!uploadContentType.contains("image")) {
                session.put("tip", "截图类型不正确，工单已创建成功！");
                return false;
            }
            //把数据再取出来要获取它的id
            /*Date date = new Date();
            long miaos = date.getTime();
            System.out.println(miaos);
            miaos = miaos / 1000 * 1000l;
            System.out.println(miaos);
            Date newDate = new Date(miaos);
            System.out.println(newDate);
            ticket.setPutime(newDate);*/
            //把数据再取出来要获取它的id
            String putime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ticket.getPutime());
            System.out.println(putime);
            String hql = "from Ticket as ticket where pfid ='" + ticket.getPfid()
                    + "' and ptype='" + ticket.getPtype() + "' and putime = '" + putime + "'";
            List list = ticketDAO.findByHql(hql);
            ticket = (Ticket) list.get(0);
            //获取要保存文件夹的物理路径(绝对路径)
            String realPath = ServletActionContext.getServletContext().getRealPath("/upload/ticket/" + ticket.getPid());    //一个以ID命名的文件夹
            File file = new File(realPath);
            System.out.println("66666");
            //测试此抽象路径名表示的文件或目录是否存在，不存在则创建
            if (!file.exists()) {
                file.mkdirs();
            }
            try {
                System.out.println("777777");
                //保存文件
                FileUtils.copyFile(upload, new File(file, uploadFileName));
                System.out.println("8888");
            } catch (IOException e) {
                session.put("tip", "图片上传失败，工单创建成功，可进入管理页面进行操作");
                e.printStackTrace();
            }
            System.out.println("999999");
            //更新
            ticket.setPphotoaddr("/upload/ticket/" + ticket.getPid() + "/" + uploadFileName);
            ticketDAO.update(ticket);
            //session提示
            session.put("tip", "工单提交成功");
            return true;
        }
        System.out.println("success");
        session.put("tip", "工单提交成功！");
        return true;
    }

    public boolean play() {
        Map<String, Object> session = (Map) ActionContext.getContext().getSession();
        Customer customer = (Customer) session.get("user");
        String hql = "from Ticket as ticket where pfid='" + customer.getId() + "'";
        List list = ticketDAO.findByHql(hql);
        if (list.isEmpty()) {
            return false;
        } else {
            ActionContext context = ActionContext.getContext();
            session = context.getSession();
            session.put("tickets", list);
            return true;
        }
    }


    public void setTicketDAO(ITicketDAO ticketDAO) {
        this.ticketDAO = ticketDAO;
    }
}
