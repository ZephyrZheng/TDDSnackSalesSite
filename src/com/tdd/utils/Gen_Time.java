package com.tdd.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

//时间类工具类
public class Gen_Time {

	//返回当前时间，格式（yyyy-MM-dd HH:mm:ss）
	public static String getFormattime(){
		String time = null;
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        Date date = new Date();  
        time = f.format(date);
		return time;
	}
	
	//根据时间戳生成订单号
	public static String getOrdId(){
		String ordID = null;
		//十五位订单号(随机2位+13位时间戳)
		int r1=(int)(Math.random()*(10));//产生2个0-9的随机数
		int r2=(int)(Math.random()*(10));
		long now = System.currentTimeMillis();//一个13位的时间戳
		ordID =String.valueOf(r1)+String.valueOf(r2)+String.valueOf(now);
		return ordID;
	}
	
}
