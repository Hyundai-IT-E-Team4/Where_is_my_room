package com.org.team4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.org.team4.dao.BoardDAO;
import com.org.team4.dto.LocationDTO;
import com.org.team4.dto.MapDTO;
import com.org.team4.util.Util;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MapServiceImpl implements MapService{

   @Autowired
   @Qualifier(value="boardDAO")
   private BoardDAO boardDAO;
   
   @Autowired
   private S3Service s3Service;

   @Override
   public List<MapDTO> getMapListWithLoction(LocationDTO locationDTO) throws Exception {
      try {
         List<MapDTO> locations = boardDAO.getMapListWithLoction(locationDTO); 
         for(MapDTO dto : locations) {
            if(dto.getRepreFile() != null) dto.setRepreFile(s3Service.getFileURL("team4", Util.thumbImgFolder + dto.getRepreFile()));
         }
         return locations;
      } catch (Exception e) {
         log.info(e.getMessage());
         throw e;
      }   
   }
}