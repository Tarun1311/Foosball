package com.foosball.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import com.foosball.model.Matches;

@Entity
@Table(name="team")
public class Team {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="teamId")
	private int id;
	
	@Column(name="teamName")
	private String teamName;
	
	@ManyToMany
	@JoinTable(name="team_employee", joinColumns = { @JoinColumn(name ="fk_team", referencedColumnName = "teamId") },inverseJoinColumns = { @JoinColumn(name = "fk_employee", referencedColumnName = "id") })
	private List<Employee> employees = new ArrayList<>(2);
	
	@Column(name="score")
	private int score;

	@ManyToMany(mappedBy="teams")
	private List<Matches> matches = new ArrayList<Matches>();
	
	@Column(name="deleted")
	private boolean deleted=false;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public List<Employee> getEmployees() {
		return employees;
	}

	public void setEmployees(List<Employee> employees) {
		this.employees = employees;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public List<Matches> getMatches() {
		return matches;
	}

	public void setMatches(List<Matches> matches) {
		this.matches = matches;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	
}
