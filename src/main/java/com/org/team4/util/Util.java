package com.org.team4.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

public class Util {
	public static String originImgFolder = "imgs/";
	public static String thumbImgFolder = "thumb/";
	public static String profileFolder = "profile/";
	public static byte[] mamkeThumbnail(String filePath) throws IOException {
		URL url = new URL(filePath);
		BufferedImage srcImg = ImageIO.read(url);
		BufferedImage destImg = Scalr.resize(srcImg, Scalr.Method.AUTOMATIC,
				Scalr.Mode.FIT_TO_HEIGHT, 100);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(destImg, getType(filePath), baos);
		return baos.toByteArray();
	}
	public static String makeFileName(MultipartFile file) {
		StringBuffer sb = new StringBuffer();
		sb.append(UUID.randomUUID().toString());
		sb.append("_");
		sb.append(file.getOriginalFilename());
		return sb.toString();
	}
	public static String getCurrentUploadPath() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE);
		return makeDay(Integer.toString(year), makeLength(month), makeLength(day));
	}
	private static String makeLength(int n) {
		return new DecimalFormat("00").format(n).toString();
	}
	private static String makeDay(String ... days) {
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < days.length; i++) {
			sb.append(days[i]);
			sb.append("/");
		}
		return sb.toString();
	}
	
	private static String getType(String file) {
		int idx = file.lastIndexOf(".");
		return file.substring(idx + 1);
	}
}
