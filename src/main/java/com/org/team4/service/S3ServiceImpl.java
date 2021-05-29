package com.org.team4.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;

@Service
public class S3ServiceImpl implements S3Service{
	@Autowired
	AmazonS3 S3Client;
	
	@Override
	public List<Bucket> getBucketList() {
		return S3Client.listBuckets();
	}

	// 버킷을 생성하는 메서드이다.
	@Override
	public Bucket createBucket(String bucketName) {
		return S3Client.createBucket(bucketName);
	}

	// 폴더 생성 (폴더는 파일명 뒤에 "/"를 붙여야한다.)
	@Override
	public void createFolder(String bucketName, String folderName) {
		S3Client.putObject(bucketName, "imgs/" + folderName, new ByteArrayInputStream(new byte[0]), new ObjectMetadata());
	}

	// 파일 업로드
	@Override
	public void fileUpload(String bucketName, String fileName, byte[] fileData) throws FileNotFoundException {
		String filePath = (fileName).replace(File.separatorChar, '/'); // 파일 구별자를 `/`로 설정(\->/) 이게 기존에 / 였어도 넘어오면서 \로 바뀌는 거같다.
		ObjectMetadata metaData = new ObjectMetadata();
		metaData.setContentLength(fileData.length);   //메타데이터 설정 -->원래는 128kB까지 업로드 가능했으나 파일크기만큼 버퍼를 설정시켰다.
	    ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(fileData); //파일 넣음
		S3Client.putObject(bucketName, filePath, byteArrayInputStream, metaData);
	}

	// 파일 삭제
	@Override
	public void fileDelete(String bucketName, String fileName) {
		String imgName = (fileName).replace(File.separatorChar, '/');
		S3Client.deleteObject(bucketName, imgName);
		System.out.println("삭제성공");
	}

	// 파일 URL
	@Override
	public String getFileURL(String bucketName, String fileName) {
		System.out.println("넘어오는 파일명 : "+fileName);
		String imgName = (fileName).replace(File.separatorChar, '/');
		return S3Client.generatePresignedUrl(new GeneratePresignedUrlRequest(bucketName, imgName)).toString();
	}
}
