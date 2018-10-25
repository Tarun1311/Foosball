package com.foosball.dao;

import java.util.List;

import com.foosball.dto.MatchesDto;
import com.foosball.model.Matches;

public interface IMatchesDao {

	//method to save employee  
			public void saveMatches(Matches t);
			//method to update employee  
			public void updateMatches(Matches t);
			//method to delete employee  
			public void deleteMatches(int id);
			//method to return one employee of given id  
			public Matches getById(int id);
			//method to return all employees  
			public List<MatchesDto> getMatches();
	
}
