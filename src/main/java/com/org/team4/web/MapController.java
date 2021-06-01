package com.org.team4.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.team4.dto.LocationDTO;
import com.org.team4.dto.MapDTO;
import com.org.team4.service.MapService;

@Controller
public class MapController {

	@Autowired
	private MapService mapService;

	//남서 위도 경도 북동 위도 경
	@GetMapping("/map/{swLat}/{swLng}/{neLat}/{neLng}/")
	@ResponseBody
	public Map<String, Object> Map2(@PathVariable double swLat,
							 @PathVariable double swLng,
							 @PathVariable double neLat,
							 @PathVariable double neLng) {
		try {
			LocationDTO locationDTO = new LocationDTO(swLat,swLng,neLat,neLng);
			List<MapDTO> list = mapService.getMapListWithLoction(locationDTO);
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("positions",list);
			return result;		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
	}
		
	}
	
	@GetMapping("/map")
	public String Map4() {
		return "map/map";
	}
		
	
}