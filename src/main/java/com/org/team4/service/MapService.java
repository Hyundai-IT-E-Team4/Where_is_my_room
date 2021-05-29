package com.org.team4.service;

import java.util.List;

import com.org.team4.dto.LocationDTO;
import com.org.team4.dto.MapDTO;

public interface MapService {

	List<MapDTO> getMapListWithLoction(LocationDTO locationDTO) throws Exception;

}