package com.org.team4.web;

import java.util.List;

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

	
//	@GetMapping("/map")
//	@ResponseBody
//	public HashMap<String, Object> Map() {
//		try {
//			MapDTO mapDTO = mapService.getMapList();
//			HashMap<String, Object> data = new HashMap<String, Object>();
//			data.put("title", mapDTO.getTitle());
//			data.put("longitude", mapDTO.getLongitude());
//			data.put("latitude", mapDTO.getLatitude());
//			
//			return data;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return null;
//		}
//	}
	
	@GetMapping("/map")
	public String Map1() {
		return "map/map";
	}
	@GetMapping("/map2")
	@ResponseBody
	public List<MapDTO> Map2() {
		try {
			List<MapDTO> list = mapService.getMapList();
			return list;		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
	}
		
	}
	//남서 위도 경도 북동 위도 경
	@GetMapping("/map2/{swLat}/{swLng}/{neLat}/{neLng}")
	@ResponseBody
	public List<MapDTO> Map2(@PathVariable double swLat,
							 @PathVariable double swLng,
							 @PathVariable double neLat,
							 @PathVariable double neLng) {
		try {
			LocationDTO locationDTO = new LocationDTO(swLat,swLng,neLat,neLng,0);
			List<MapDTO> list = mapService.getMapListWithLoction(locationDTO);
			return list;		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
	}
		
	}
	
	
	
	
	
//	@GetMapping("/")
//	@ResponseBody
//	public String getMapList(Model model){
//		try {
//			List<MapDTO> list = mapService.getMapList();
//			model.addAttribute("list", list);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "map/map";
//	}
	
	
}