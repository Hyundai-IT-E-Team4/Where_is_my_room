package com.org.team4.service;

import java.io.FileNotFoundException;
import java.util.List;
import com.amazonaws.services.s3.model.Bucket;

public interface S3Service {
	public List<Bucket> getBucketList();

	// 버킷을 생성하는 메서드이다.
	public Bucket createBucket(String bucketName);

	// 폴더 생성 (폴더는 파일명 뒤에 "/"를 붙여야한다.)
	public void createFolder(String bucketName, String folderName);

	// 파일 업로드
	public void fileUpload(String bucketName, String fileName, byte[] fileData) throws FileNotFoundException ;

	// 파일 삭제
	public void fileDelete(String bucketName, String fileName);

	// 파일 URL
	public String getFileURL(String bucketName, String fileName);
	
}
