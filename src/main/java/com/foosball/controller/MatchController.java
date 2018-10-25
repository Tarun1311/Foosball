package com.foosball.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.foosball.dto.MatchesDto;
import com.foosball.dto.TeamDto;
import com.foosball.model.Matches;
import com.foosball.model.Team;
import com.foosball.service.MatchesService;
import com.foosball.service.TeamService;

@Controller
@RequestMapping(value = "/match")
public class MatchController {

	@Autowired
	MatchesService matchesService;
	
	@Autowired
	TeamService teamService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView toAddMatches(){
		List<MatchesDto> matches = matchesService.getMatches();
		List<TeamDto> teams = teamService.getTeams();
		ModelAndView model = new ModelAndView("addmatches");
		model.addObject("listMatches",matches);
		model.addObject("listTeams",teams);
		return model;
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public String save(@RequestParam(value = "id", required = false) Integer id, @RequestParam("teamName1") int teamName1, @RequestParam("teamName2") int teamName2, @RequestParam("score1") int score1, @RequestParam("score2") int score2){
		Matches match = new Matches();
		if(id!=null)
			match.setId(id);
		match.setDate(new Date());
		List<Team> team = new ArrayList<Team>();
		Team t0 = new Team();
		Team t1 = new Team();
		t0.setId(teamName1);
		match.setScore1(score1);
		t1.setId(teamName2);
		match.setScore2(score2);
		team.add(t0);
		team.add(t1);
		match.setTeams(team);
//		match.setMatchName(MatchName);
		matchesService.saveMatches(match);
		return "redirect:/match/list";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public void update(@ModelAttribute("match") Matches employe){
		matchesService.updateMatches(employe);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String delete(@RequestParam("id") int id){
		matchesService.deleteMatches(id);
		return "redirect:/match/list";
	}
	
	@RequestMapping(value="/get/{id}", method=RequestMethod.GET)
	public void getById(@PathVariable("id") int id){
		matchesService.getById(id);
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void list(HttpServletResponse response) throws IOException{
		List<MatchesDto> matchesDto = matchesService.getMatches();
		JSONArray array = new JSONArray();
		response.setContentType("application/json");
		for(MatchesDto dto: matchesDto){
			JSONObject obj = new JSONObject();
			obj.put("id", dto.getId());
			obj.put("date", dto.getDate());
			obj.put("score1", dto.getScore1());
			obj.put("score2", dto.getScore2());
			obj.put("teamDto", dto.getTeamDto());
			array.put(obj);
		}
		response.getWriter().print(array);
	}
}
