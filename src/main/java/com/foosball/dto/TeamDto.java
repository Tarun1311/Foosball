package com.foosball.dto;

public class TeamDto {

	private int id;
	private String teamName;
	private int player1;
	private int player2;
	private String player1Id;
	private String player2Id;
	private String player1Name;
	private String player2Name;
	private int score;
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
	public int getPlayer1() {
		return player1;
	}
	public void setPlayer1(int player1) {
		this.player1 = player1;
	}
	public int getPlayer2() {
		return player2;
	}
	public void setPlayer2(int player2) {
		this.player2 = player2;
	}
	public String getPlayer1Id() {
		return player1Id;
	}
	public void setPlayer1Id(String player1Id) {
		this.player1Id = player1Id;
	}
	public String getPlayer2Id() {
		return player2Id;
	}
	public void setPlayer2Id(String player2Id) {
		this.player2Id = player2Id;
	}
	public String getPlayer1Name() {
		return player1Name;
	}
	public void setPlayer1Name(String player1Name) {
		this.player1Name = player1Name;
	}
	public String getPlayer2Name() {
		return player2Name;
	}
	public void setPlayer2Name(String player2Name) {
		this.player2Name = player2Name;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
}
