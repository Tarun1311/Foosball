package com.foosball.service;

import java.util.List;

import com.foosball.dto.MatchesDto;
import com.foosball.model.Matches;

public interface MatchesService {

	//method to save Matches  
	public void saveMatches(Matches e);
	//method to update Matches  
	public void updateMatches(Matches e);
	//method to delete Matches  
	public void deleteMatches(int id);
	//method to return one Matches of given id  
	public Matches getById(int id);
	//method to return all Matchess  
	public List<MatchesDto> getMatches();
}
