package com.foosball.dao;

import java.util.List;

import com.foosball.dto.TeamDto;
import com.foosball.model.Team;

public interface ITeamDao {

	//method to save employee  
		public void saveTeam(TeamDto t);
		//method to update employee  
		public void updateTeam(Team t);
		//method to delete employee  
		public void deleteTeam(int id);
		//method to return one employee of given id  
		public Team getById(int id);
		//method to return all employees  
		public List<TeamDto> getTeams();
		public List<TeamDto> getSortTeams();
}
