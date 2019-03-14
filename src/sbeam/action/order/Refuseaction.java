package sbeam.action.order;

import sbeam.po.order.Order;
import sbeam.service.order.IorderService;

public class Refuseaction {
    private IorderService iorderService;
    private int oid;

    public IorderService getIorderService() {
        return iorderService;
    }

    public void setIorderService(IorderService iorderService) {
        this.iorderService = iorderService;
    }

    public String refuse() {//取消订单
        Order od = iorderService.getOrder(oid);
        if (iorderService.delet(od)) {
            System.out.println("buy refuse");
            return "buyfail";
        }
        return "refusefail";
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }
}
