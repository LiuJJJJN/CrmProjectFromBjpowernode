package com.bjpn.crm.utils;

import java.util.UUID;

/**
 * 随机唯一ID生成工具
 */
public class UUIDUtil {
	
	public static String getUUID(){
		
		return UUID.randomUUID().toString().replaceAll("-","");
		
	}
	
}
