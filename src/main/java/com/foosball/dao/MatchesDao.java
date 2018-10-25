package com.foosball.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.foosball.dto.MatchesDto;
import com.foosball.dto.TeamDto;
import com.foosball.model.Employee;
import com.foosball.model.Matches;
import com.foosball.model.Team;

@Repository
@Transactional
public class MatchesDao implements IMatchesDao {

	@Autowired
	HibernateTemplate template;  
	
	@Autowired
	ITeamDao teamDao; 
	
	public void setTemplate(HibernateTemplate template) {  
	    this.template = template;  
	}  
	//method to save Matches  
	public void saveMatches(Matches e){  
		try{ 
			Team team1 = teamDao.getById(e.getTeams().get(0).getId());
			Team team2 = teamDao.getById(e.getTeams().get(1).getId());
			team1.setScore(e.getScore1() + team1.getScore());
			team2.setScore(e.getScore2() + team2.getScore());
			List<Team> teams = new ArrayList<Team>();
			teams.add(team1);
			teams.add(team2);
			e.setTeams(teams);
			template.saveOrUpdate(e);
		}catch(DataIntegrityViolationException ex){
		}catch(Exception ex){
		} 
	}  
	//method to update Matches  
	public void updateMatches(Matches e){  
	    template.update(e);  
	}  
	//method to delete Matches  
	public void deleteMatches(int id){  
	    String hql = "delete Matches WHERE id = :id";
		Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
	}  
	//method to return one Matches of given id  
	public Matches getById(int id){  
	    Matches e=(Matches)template.get(Matches.class,id);  
	    return e;  
	}  
	//method to return all Matchess  
	@SuppressWarnings("unchecked")
	public List<MatchesDto> getMatches(){  
	    /*list=template.loadAll(Matches.class);  
	    return list;*/
	    String hql = "FROM Matches M order by id desc";
	    Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
	    List<Matches> matches = query.getResultList();
	    List<MatchesDto> matchesDto = new ArrayList<>();
	    for(Matches match: matches){
	    	MatchesDto dto = new MatchesDto();
	    	dto.setId(match.getId());
	    	dto.setDate(match.getDate());
	    	dto.setScore1(match.getScore1());
	    	dto.setScore2(match.getScore2());
	    	List<Team> team = match.getTeams();
	    	List<Employee> employees0 = team.get(0).getEmployees();
	    	List<Employee> employees1 = team.get(1).getEmployees();
	    	TeamDto teamDto0 = new TeamDto();
	    	teamDto0.setTeamName(team.get(0).getTeamName());
	    	teamDto0.setPlayer1(employees0.get(0).getId());
	    	teamDto0.setPlayer2(employees0.get(1).getId());
	    	teamDto0.setPlayer1Id(employees0.get(0).getEmployeeId());
	    	teamDto0.setPlayer2Id(employees0.get(1).getEmployeeId());
	    	teamDto0.setPlayer1Name(employees0.get(0).getEmployeeName());
	    	teamDto0.setPlayer2Name(employees0.get(1).getEmployeeName());
	    	teamDto0.setScore(team.get(0).getScore());
//	    	dto.add(teamDto0);
	    	TeamDto teamDto1 = new TeamDto();
	    	teamDto1.setTeamName(team.get(1).getTeamName());
	    	teamDto1.setPlayer1(employees1.get(0).getId());
	    	teamDto1.setPlayer2(employees1.get(1).getId());
	    	teamDto1.setPlayer1Id(employees1.get(0).getEmployeeId());
	    	teamDto1.setPlayer2Id(employees1.get(1).getEmployeeId());
	    	teamDto1.setPlayer1Name(employees1.get(0).getEmployeeName());
	    	teamDto1.setPlayer2Name(employees1.get(1).getEmployeeName());
	    	teamDto1.setScore(team.get(1).getScore());
	    	
	    	List<TeamDto> teamDto = new ArrayList<TeamDto>();
	    	teamDto.add(teamDto0);
	    	teamDto.add(teamDto1);
	    	dto.setTeamDto(teamDto);
	    	
	    	matchesDto.add(dto);
	    }
	    return matchesDto;
	}  
	
}
