package com.foosball.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.foosball.dto.TeamDto;
import com.foosball.model.Employee;
import com.foosball.model.Team;


@Repository
@Transactional
public class TeamDao implements ITeamDao {
	
	@Autowired
	HibernateTemplate template;

	@Autowired
	IEmployeeDao employeeDao;
	
	public void setTemplate(HibernateTemplate template) {
		this.template = template;
	}

	// method to save Team
	public void saveTeam(TeamDto e) {
		Team team=new Team();
		team.setDeleted(false);
		team.setId(e.getId());
		team.setTeamName(e.getTeamName());
		team.setScore(e.getScore());
		List<Employee> list = new ArrayList<Employee>();
		list.add(employeeDao.getById(e.getPlayer1()));
		list.add(employeeDao.getById(e.getPlayer2()));
		team.setEmployees(list);
		try{ 
			template.saveOrUpdate(team);
		}catch(DataIntegrityViolationException ex){
		}catch(Exception ex){
		}
	}

	// method to update Team
	public void updateTeam(Team e) {
		template.update(e);
	}

	// method to delete Team
	public void deleteTeam(int id) {
		String hql = "UPDATE Team set deleted = true WHERE id = :id";
		Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
	}

	// method to return one Team of given id
	public Team getById(int id) {
		Team e = (Team) template.get(Team.class, id);
		return e;
	}

	// method to return all Teams
	@SuppressWarnings("unchecked")
	public List<TeamDto> getTeams() {
	    String hql = "FROM Team T WHERE deleted = false order by id desc";
	    Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
	    List<Team> teams = query.getResultList();
	    List<TeamDto> teamDto = new ArrayList<>();
	    for(Team team: teams){
	    	TeamDto dto = new TeamDto();
	    	dto.setId(team.getId());
	    	dto.setTeamName(team.getTeamName());
	    	List<Employee> employees = team.getEmployees();
	    	dto.setPlayer1(employees.get(0).getId());
	    	dto.setPlayer2(employees.get(1).getId());
	    	dto.setPlayer1Id(employees.get(0).getEmployeeId());
	    	dto.setPlayer2Id(employees.get(1).getEmployeeId());
	    	dto.setPlayer1Name(employees.get(0).getEmployeeName());
	    	dto.setPlayer2Name(employees.get(1).getEmployeeName());
	    	dto.setScore(team.getScore());
	    	teamDto.add(dto);
	    }
	    return teamDto;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TeamDto> getSortTeams() {
		// TODO Auto-generated method stub
		String hql = "FROM Team T WHERE deleted = false order by score desc";
	    Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
	    List<Team> teams = query.getResultList();
	    List<TeamDto> teamDto = new ArrayList<>();
	    for(Team team: teams){
	    	TeamDto dto = new TeamDto();
	    	dto.setId(team.getId());
	    	dto.setTeamName(team.getTeamName());
	    	List<Employee> employees = team.getEmployees();
	    	dto.setPlayer1(employees.get(0).getId());
	    	dto.setPlayer2(employees.get(1).getId());
	    	dto.setPlayer1Id(employees.get(0).getEmployeeId());
	    	dto.setPlayer2Id(employees.get(1).getEmployeeId());
	    	dto.setPlayer1Name(employees.get(0).getEmployeeName());
	    	dto.setPlayer2Name(employees.get(1).getEmployeeName());
	    	dto.setScore(team.getScore());
	    	teamDto.add(dto);
	    }
	    return teamDto;
	}
}
