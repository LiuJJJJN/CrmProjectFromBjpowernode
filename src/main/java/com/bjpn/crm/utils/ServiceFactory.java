package com.bjpn.crm.utils;

/**
 * 动态代理工厂工具
 */
public class ServiceFactory {
	
	public static Object getService(Object service){
		
		return new TransactionInvocationHandler(service).getProxy();
		
	}
	
}
