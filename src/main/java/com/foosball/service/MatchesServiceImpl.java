package com.foosball.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foosball.dao.IMatchesDao;
import com.foosball.dto.MatchesDto;
import com.foosball.model.Matches;

@Service
public class MatchesServiceImpl implements MatchesService{

	@Autowired 
	IMatchesDao matchesDao;
	//method to save Matches  
		public void saveMatches(Matches e){
			matchesDao.saveMatches(e);
		}
		//method to update Matches  
		public void updateMatches(Matches e){
			matchesDao.updateMatches(e);
		}
		//method to delete Matches  
		public void deleteMatches(int id){
			matchesDao.deleteMatches(id);
		}
		//method to return one Matches of given id  
		public Matches getById(int id){
			return matchesDao.getById(id);
		}
		//method to return all Matchess  
		public List<MatchesDto> getMatches(){
			return matchesDao.getMatches();
		}
}
