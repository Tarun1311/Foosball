package com.foosball.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foosball.dao.ITeamDao;
import com.foosball.dto.TeamDto;
import com.foosball.model.Team;
@Service
public class TeamServiceImpl implements TeamService{

	@Autowired 
	private ITeamDao teamDao;
	//method to save Team  
		public void saveTeam(TeamDto e){
			teamDao.saveTeam(e);
		}
		//method to update Team  
		public void updateTeam(Team e){
			teamDao.updateTeam(e);
		}
		//method to delete Team  
		public void deleteTeam(int id){
			teamDao.deleteTeam(id);
		}
		//method to return one Team of given id  
		public Team getById(int id){
			return teamDao.getById(id);
		}
		//method to return all Teams  
		public List<TeamDto> getTeams(){
			return teamDao.getTeams();
		}
		@Override
		public List<TeamDto> getSortTeams() {
			// TODO Auto-generated method stub
			return teamDao.getSortTeams();
		}
}
