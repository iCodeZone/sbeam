package sbeam.action.order;

import com.opensymphony.xwork2.ActionContext;
import sbeam.po.order.Order;
import sbeam.service.order.IorderService;

import java.util.Map;

public class Sureaction {
	private IorderService iorderService; 
	
	public void setIorderService(IorderService iorderService) {
		this.iorderService = iorderService;
	}
	
	public IorderService getIorderService() {
		return iorderService;
	}

	public String sure() {
		iorderService.update();
		return "buysuccess";
	}
}
