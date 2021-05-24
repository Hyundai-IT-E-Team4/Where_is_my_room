package com.org.team4.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.org.team4.dto.MapDTO;
import com.org.team4.service.MapService;


@Controller
public class MapController {

	@Autowired
	private MapService mapService;

	
	@GetMapping("/map")
	public String Map(Model model) {
		try {
			List<MapDTO> list = mapService.getMapList();
			model.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "map/map";
	}
	
	
}