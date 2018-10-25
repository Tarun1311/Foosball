package com.foosball.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name="matches")
public class Matches {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="matchDate")
	private Date date;
	
	@ManyToMany
	@JoinTable(name="matches_team", joinColumns = {@JoinColumn(name="fk_matches", referencedColumnName="id")},inverseJoinColumns = {@JoinColumn(name="fk_teams", referencedColumnName="teamId")})
	private List<Team> teams= new ArrayList<>(2);

	@Column(name="team1score")
	private int score1;
	
	@Column(name="team2score")
	private int score2;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public List<Team> getTeams() {
		return teams;
	}

	public void setTeams(List<Team> teams) {
		this.teams = teams;
	}

	public int getScore1() {
		return score1;
	}

	public void setScore1(int score1) {
		this.score1 = score1;
	}

	public int getScore2() {
		return score2;
	}

	public void setScore2(int score2) {
		this.score2 = score2;
	}
	
}
