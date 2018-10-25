package com.foosball.controller;

import java.io.IOException;
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

import com.foosball.dto.TeamDto;
import com.foosball.model.Employee;
import com.foosball.model.Team;
import com.foosball.service.EmployeeService;
import com.foosball.service.TeamService;

@Controller
@RequestMapping(value = "/team")
public class TeamController {

	@Autowired
	TeamService teamService;
	
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView toAddTeams(){
		List<TeamDto> teams = teamService.getTeams();
		List<Employee> emps = employeeService.getEmployees();
		ModelAndView model = new ModelAndView("addteams");
		model.addObject("listTeams",teams);
		model.addObject("listPlayers",emps);
		return model;
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public String save(@RequestParam(value = "id", required = false) Integer id, @RequestParam("teamName") String teamName, @RequestParam("player1") int player1, @RequestParam("player2") int player2, @RequestParam("score") int score){
		TeamDto team = new TeamDto();
		if(id!=null)
			team.setId(id);
//		team.setTeamId(teamId);
		team.setTeamName(teamName);
		team.setScore(score);
		team.setPlayer1(player1);
		team.setPlayer2(player2);
		teamService.saveTeam(team);
		
		return "redirect:/team/list";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public void update(@ModelAttribute("team") Team team){
		teamService.updateTeam(team);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String delete(@RequestParam("id") int id){
		teamService.deleteTeam(id);
		return "redirect:/team/list";
	}
	
	@RequestMapping(value="/get/{id}", method=RequestMethod.GET)
	public void getById(@PathVariable("id") int id){
		teamService.getById(id);
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void list(HttpServletResponse response) throws IOException{
		List<TeamDto> emps = teamService.getTeams();
		JSONArray array = new JSONArray();
		response.setContentType("application/json");
		for(TeamDto e:emps){
			JSONObject obj = new JSONObject();
			obj.put("id", e.getId());
			obj.put("teamName", e.getTeamName());
			obj.put("player1", e.getPlayer1());
			obj.put("player2", e.getPlayer2());
			obj.put("player1Id", e.getPlayer1Id());
			obj.put("player2Id", e.getPlayer2Id());
			obj.put("player1Name", e.getPlayer1Name());
			obj.put("player2Name", e.getPlayer2Name());
			obj.put("score", e.getScore());
			array.put(obj);
		}
		response.getWriter().print(array);
	}
	
	@RequestMapping(value="/lead", method=RequestMethod.GET)
	public ModelAndView toGetTeams(){
		List<TeamDto> teams = teamService.getSortTeams();
		ModelAndView model = new ModelAndView("leadteams");
		model.addObject("listTeams",teams);
		return model;
	}
}

