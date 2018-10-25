package com.foosball.service;

import java.util.List;

import com.foosball.dto.TeamDto;
import com.foosball.model.Team;

public interface TeamService {
	
	//method to save Team  
			public void saveTeam(TeamDto e);
			//method to update Team  
			public void updateTeam(Team e);
			//method to delete Team  
			public void deleteTeam(int id);
			//method to return one Team of given id  
			public Team getById(int id);
			//method to return all Teams  
			public List<TeamDto> getTeams();
			public List<TeamDto> getSortTeams();
}
