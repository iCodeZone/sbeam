package sbeam.action.order;

import sbeam.po.order.Order;
import sbeam.service.order.IorderService;

public class Refundaction {
    private IorderService iorderService;
    private Order od = new Order();
    private int oid;

    public IorderService getIorderService() {
        return iorderService;
    }

    public void setIorderService(IorderService iorderService) {
        this.iorderService = iorderService;
    }

    public String refund() {
        od = iorderService.getOrder(oid);
        if (iorderService.refund(od))
            return "refundSuccess";
        return "refundFail";
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

}
