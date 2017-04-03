package cn.itcast.bos.utils;

import java.util.UUID;

/**
 * 负责uuid 生成
 * 
 * @author seawind
 * 
 */
public class UUIDUtils {
	/**
	 * 生成随机uuid
	 * 
	 * @return
	 */
	public static String generatePrimaryKey() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
