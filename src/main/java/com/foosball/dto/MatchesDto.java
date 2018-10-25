package com.foosball.dto;

import java.util.Date;
import java.util.List;

public class MatchesDto {
	
	private int id;
	private Date date;
	private List<TeamDto> teamDto;
	private int score1;
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
	public List<TeamDto> getTeamDto() {
		return teamDto;
	}
	public void setTeamDto(List<TeamDto> teamDto) {
		this.teamDto = teamDto;
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
