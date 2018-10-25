<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/resources/img/foosball.jpg" var="foosballIMG"></spring:url>
<spring:url value="/resources/js/sidenav.js" var="sidenavJS"></spring:url>
<spring:url value="/match/save" var="matchsave"></spring:url>
<spring:url value="/match/delete" var="matchdelete"></spring:url>
<jsp:include page="headers.jsp"></jsp:include>
<body background="${foosballIMG }">
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="container-fluid p-0">
		<span id="nav-button" style="font-size: 30px; cursor: pointer"
			onclick="openNav()">&#9776; Foosball</span>
		<div id="main" align="center">
			<div class="container">
				<div class="my-auto">
					<h1 class="mb-0">
						Choose <span class="text-primary"> Teams</span>
					</h1>
				</div>
				<form:form class="form-inline">
					<div class="form-group">
						<input type="hidden" class="form-control" id="id" name="id">
					</div>
					<div class="form-group">
						<label for="team1">Team 1</label> <select class="form-control"
							id="team1">
							<option value="" disabled selected>Select Team 1</option>
							<c:forEach items="${listTeams }" var="team1">
								<option value="${team1.id }">${team1.id }-
									${team1.teamName }</option>
							</c:forEach>
						</select>
					</div>
					<span> </span>
					<div class="form-group">
						<label for="score1">Team 1 Score: </label> <input type="number"
							class="form-control" id="score1" name="score1" value="0">
					</div>
					<br>
					<br>
					<div class="form-group">
						<label for="team2">Team 1</label> <select class="form-control"
							id="team2">
							<option value="" disabled selected>Select Team 2</option>
							<c:forEach items="${listTeams }" var="team2">
								<option value="${team2.id }">${team2.teamName }</option>
							</c:forEach>
						</select>
					</div>
					<span> </span>
					<div class="form-group">
						<label for="score2">Team 2 Score: </label> <input type="number"
							class="form-control" id="score2" name="score2" value="0">
					</div>
					<br>
					<br>
					<div id="error" class="text-primary"></div>
					<button type="button" class="btn btn-success" onclick="saveTeam()">Save Match Result</button>
				</form:form>
			</div>
			<div id="matchList">
				<c:if test="${!listMatches.isEmpty() }">
					<section class="resume-section p-3 p-lg-5 d-flex d-column"
						id="addTeams">
						<div class="my-auto">
							<h1 class="mb-0">
								All <span class="text-primary"> Matches</span>
							</h1>
						</div>
					</section>
					<div>
						<table class="table table-hover" id="table-content">
							<thead>
								<tr>
									<th>Id</th>
									<th>Team1</th>
									<th>Team1 Score</th>
									<th>V/S</th>
									<th>Team2 Score</th>
									<th>Team2</th>
									<th colspan="2">Date</th>
								</tr>
							</thead>
							<c:forEach items="${listMatches }" var="match">
								<tr>
									<td>${match.id }</td>
									<c:forEach items="${match.teamDto }" var="team"
										varStatus="loop">
										<c:choose>
											<c:when test="${loop.index === '0'}">
												<td><b>${team.teamName }</b> <br>${team.player1Id }
													- ${team.player1Name } <br>${team.player2Id } -
													${team.player2Name }</td>
												<td>${team.score }</td>
											</c:when>
											<c:otherwise>
												<td>${team.score }</td>
												<td><b>${team.teamName }</b> <br>${team.player1Id }
													- ${team.player1Name } <br>${team.player2Id } -
													${team.player2Name }</td>
											</c:otherwise>
										</c:choose>
										<td></td>
									</c:forEach>
									<td><button class="btn btn-danger"
											onclick="deleteTeam(${match.id })">Delete</button> <%-- <span>
									</span>
										<button class="btn btn-warning"
											onclick="updateTeam(${team.id },'${team.teamName }',${team.player1 },${team.player2 },${team.score })">Update</button> --%></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<script src="${sidenavJS }"></script>
	<script>
	function updateTeam(id,teamName,player1,player2,score){
		document.getElementById("id").value = id;
		document.getElementById("teamname").value = teamName;
		document.getElementById("player1").value = player1;
		document.getElementById("player2").value = player2;
		document.getElementById("score").value = score;
		document.getElementById("teamname").focus();
	}
	function saveTeam(){
		var id=document.getElementById("id").value;
		var teamname=document.getElementById("teamname").value.trim();
		var player1=document.getElementById("player1").value.trim();
		var player2=document.getElementById("player2").value.trim();
		var score=document.getElementById("score").value;
		if(teamname==="" && player1==="" && player2===""){
			document.getElementById("error").innerHTML= "<span>TeamName can't be empty! Please select Player1 & Player2 as well!</span><br><br>";
			return;
		}
		else if(teamname==="" && player1===""){
			document.getElementById("error").innerHTML= "<span>TeamName can't be empty! Please select Player1 as well!!</span><br><br>";
			return;
		}
		else if(teamname==="" && player2===""){
			document.getElementById("error").innerHTML= "<span>TeamName can't be empty! Please select Player2 as well!</span><br><br>";
			return;
		}
		else if(player1==="" && player2===""){
			document.getElementById("error").innerHTML= "<span>Please select Player1 & Player2!</span><br><br>";
			return;
		}
		else if(teamname===""){
			document.getElementById("error").innerHTML= "<span>TeamName can't be empty!</span><br><br>";
			return;
		}
		else if(player1===""){
			document.getElementById("error").innerHTML= "<span>Please select Player1!</span><br><br>";
			return;
		}
		else if(player2===""){
			document.getElementById("error").innerHTML= "<span>Please select Player2!</span><br><br>";
			return;
		}
		document.getElementById("error").innerHTML="";
		 var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		      var listTeam = JSON.parse(this.responseText);
		      document.getElementById("teamname").value="";
		      document.getElementById("player1").value="";
		      document.getElementById("player2").value="";
		      document.getElementById("score").value="0";
		      document.getElementById("id").value=null;
		      var table="";
		      for(var i=0;i<listTeam.length;i++){
		    	  table+='<tr>';
		    	  table+='<td>' + listTeam[i].id + '</td>';
		    	  table+='<td>' + listTeam[i].teamName + '</td>';
		    	  table+='<td>' + listTeam[i].player1Id + " - " + listTeam[i].player1Name + '</td>';
		    	  table+='<td>' + listTeam[i].player2Id + " - " + listTeam[i].player2Name + '</td>';
		    	  table+='<td>' + listTeam[i].score + '</td>';
		    	  table+="<td><button class=\"btn btn-danger\" onclick=\"deleteTeam("+ listTeam[i].id + ")\">Delete</button>";
				  table+="<span>  </span><button class=\"btn btn-warning\" onclick=\"updateTeam("+ listTeam[i].id + ",\'" + listTeam[i].teamName + "\'," + listTeam[i].player1 + "," + listTeam[i].player2 + "," + listTeam[i].score + ")\">Update</button></td>";
		    	  table+='</tr>';
		      }
		      document.getElementById("teamList").innerHTML= "";
		      if(listTeam.length>0){
		      	document.getElementById("teamList").innerHTML="<section class=\"resume-section p-3 p-lg-5 d-flex d-column\" id=\"addPlayers\">"
				+ "<div class=\"my-auto\">"
				+	"<h1 class=\"mb-0\">"
					+	"All <span class=\"text-primary\"> Teams</span>"
				+	"</h1>"
				+"</div>"
			+"</section>"
		      	+	"<div>"
				+"<table class=\"table table-hover\" id=\"table-content\">"
				+	"<thead>"
					+	"<tr>"
							+"<th>Id</th>"
						+	"<th>TeamName</th>"
						+	"<th>Player1</th>"
						+   "<th>Player2</th>"
						+	"<th colspan=\"2\">Score</th>"
					+	"</tr>"
				+	"</thead>"
				+   table 
			+	"</table>"
			+"</div>"

		      }
		    }
		  };
		  xhttp.open("POST", "${teamsave }" + "?id=" + id + "&teamName=" + teamname + "&player1=" + player1 + "&player2=" + player2 + "&score=" + score, true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  xhttp.send();
		}

		function deleteTeam(tid){
			 var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      var listTeam = JSON.parse(this.responseText);
			      var table="";
			      for(var i=0;i<listTeam.length;i++){
			    	  table+='<tr>';
			    	  table+='<td>' + listTeam[i].id + '</td>';
			    	  table+='<td>' + listTeam[i].teamName + '</td>';
			    	  table+='<td>' + listTeam[i].player1Id + ' - ' + listTeam[i].player1Name + '</td>';
			    	  table+='<td>' + listTeam[i].player2Id + ' - ' + listTeam[i].player2Name + '</td>';
			    	  table+='<td>' + listTeam[i].score + '</td>';
			    	  table+="<td><button class=\"btn btn-danger\" onclick=\"deleteTeam("+ listTeam[i].id + ")\">Delete</button>";
					  table+="<span>  </span><button class=\"btn btn-warning\" onclick=\"updateTeam("+ listTeam[i].id + ",\'" + listTeam[i].teamName + "\'," + listTeam[i].player1 + "," + listTeam[i].player2 + "," + listTeam[i].score + ")\">Update</button></td>";
			    	  table+='</tr>';
			      }
			      document.getElementById("teamList").innerHTML= "";
			      if(listTeam.length>0){
			      	document.getElementById("teamList").innerHTML="<section class=\"resume-section p-3 p-lg-5 d-flex d-column\" id=\"addPlayers\">"
					+ "<div class=\"my-auto\">"
					+	"<h1 class=\"mb-0\">"
						+	"All <span class=\"text-primary\"> Players</span>"
					+	"</h1>"
					+"</div>"
				+"</section>"
			      	+	"<div>"
					+"<table class=\"table table-hover\" id=\"table-content\">"
					+	"<thead>"
						+	"<tr>"
								+"<th>Id</th>"
							+	"<th>TeamName</th>"
							+	"<th>Player1</th>"
							+	"<th>Player2</th>"
							+	"<th colspan=\"2\">Score</th>"
						+	"</tr>"
					+	"</thead>"
					+   table
				+	"</table>"
				+"</div>"

			      }
			    }
			  };
			  xhttp.open("GET", "${teamdelete }" + "?id=" + tid, true);
			  xhttp.send();
			}
	</script>
	<jsp:include page="/WEB-INF/jsp/templates/footer.jsp"></jsp:include>
</body>
</html>