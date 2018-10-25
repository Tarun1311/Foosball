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
								<option value="${team1.id }">${team1.teamName }</option>
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
						<label for="team2"> Team 2</label> <select class="form-control"
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
					<button type="button" class="btn btn-success" onclick="saveMatch()">Save Match Result</button>
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
											<c:when test="${loop.index == 0}">
												<td><b>${team.teamName }</b> <br>${team.player1Id }
													- ${team.player1Name } <br>${team.player2Id } -
													${team.player2Name }</td>
												<td>${match.score1 }</td>
												<td></td>
											</c:when>
											<c:otherwise>
												<td>${match.score2 }</td>
												<td><b>${team.teamName }</b> <br>${team.player1Id }
													- ${team.player1Name } <br>${team.player2Id } -
													${team.player2Name }</td>
													<td>${match.date }</td>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<td><button class="btn btn-danger"
											onclick="deleteMatch(${match.id })">Delete</button> <%-- <span>
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
	function saveMatch(){
		var id=document.getElementById("id").value;
		var teamname1=document.getElementById("team1").value;
		var teamname2=document.getElementById("team2").value;
		var score1=document.getElementById("score1").value;
		var score2=document.getElementById("score2").value;
		if(teamname1==="" && teamname2===""){
			document.getElementById("error").innerHTML= "<span>Please select Team1 & Team2!</span><br><br>";
			return;
		}
		else if(teamname1===""){
			document.getElementById("error").innerHTML= "<span>Please select Team1!</span><br><br>";
			return;
		}
		else if(teamname2===""){
			document.getElementById("error").innerHTML= "<span>Please select Team2!</span><br><br>";
			return;
		}
		if(document.getElementById("team1").value==document.getElementById("team2").value){
			document.getElementById("error").innerHTML= "<span>Team1 & Team2 can't be same!</span><br><br>";
			return;
		}
			
		document.getElementById("error").innerHTML="";
		 var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		      var listMatch = JSON.parse(this.responseText);
		      document.getElementById("team1").value="";
		      document.getElementById("team2").value="";
		      document.getElementById("score1").value=0;
		      document.getElementById("score2").value=0;
		      document.getElementById("id").value=null;
		      var table="";
		      
		      for(var i=0;i<listMatch.length;i++){
		    	  table+='<tr>';
		    	  table+='<td>' + listMatch[i].id + '</td>';
		    	  table+='<td><b>' + listMatch[i].teamDto[0].teamName + '</b><br>';
		    	  table+= listMatch[i].teamDto[0].player1Id + " - " + listMatch[i].teamDto[0].player1Name + '<br>';
		    	  table+= listMatch[i].teamDto[0].player2Id + " - " + listMatch[i].teamDto[0].player2Name + '</td>';
		    	  table+='<td>' + listMatch[i].score1 + '</td><td></td>';
		    	  table+='<td>' + listMatch[i].score2 + '</td>';
		    	  table+='<td><b>' + listMatch[i].teamDto[1].teamName + '</b><br>';
		    	  table+= listMatch[i].teamDto[1].player1Id + " - " + listMatch[i].teamDto[1].player1Name + '<br>';
		    	  table+= listMatch[i].teamDto[1].player2Id + " - " + listMatch[i].teamDto[1].player2Name + '</td>';
		    	  
		    	  table+="<td><button class=\"btn btn-danger\" onclick=\"deleteMatch("+ listMatch[i].id + ")\">Delete</button></td>";
				  /* table+="<span>  </span><button class=\"btn btn-warning\" onclick=\"updateTeam("+ listTeam[i].id + ",\'" + listTeam[i].teamName + "\'," + listTeam[i].player1 + "," + listTeam[i].player2 + "," + listTeam[i].score + ")\">Update</button></td>"; */
		    	  table+='</tr>';
		      }
		      document.getElementById("matchList").innerHTML= "";
		      if(listMatch.length>0){
		      	document.getElementById("matchList").innerHTML="<section class=\"resume-section p-3 p-lg-5 d-flex d-column\" id=\"addPlayers\">"
				+ "<div class=\"my-auto\">"
				+	"<h1 class=\"mb-0\">"
					+	"All <span class=\"text-primary\"> Matches</span>"
				+	"</h1>"
				+"</div>"
			+"</section>"
		      	+	"<div>"
				+"<table class=\"table table-hover\" id=\"table-content\">"
				+	"<thead>"
				+	"<tr>"
				+	"<th>Id</th>"
				+	"<th>Team1</th>"
				+	"<th>Team1 Score</th>"
				+ 	"<th>V/S</th>"
				+	"<th>Team2 Score</th>"
				+	"<th>Team2</th>"
				+	"<th colspan=\"2\">Date</th>"
				+	"</tr>"
				+	"</thead>"
				+   table 
			+	"</table>"
			+"</div>"

		      }
		    }
		  };
		  xhttp.open("POST", "${matchsave }" + "?id=" + id + "&teamName1=" + teamname1 + "&teamName2=" + teamname2 + "&score1=" + score1 + "&score2=" + score2, true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  xhttp.send();
		}

		function deleteMatch(mid){
			 var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      var listMatch = JSON.parse(this.responseText);
			      var table="";
			      for(var i=0;i<listMatch.length;i++){
			    	  table+='<tr>';
			    	  table+='<td>' + listMatch[i].id + '</td>';
			    	  table+='<td><b>' + listMatch[i].teamDto[0].teamName + '</b><br>';
			    	  table+= listMatch[i].teamDto[0].player1Id + " - " + listMatch[i].teamDto[0].player1Name + '<br>';
			    	  table+= listMatch[i].teamDto[0].player2Id + " - " + listMatch[i].teamDto[0].player2Name + '</td>';
			    	  table+='<td>' + listMatch[i].score1 + '</td><td></td>';
			    	  table+='<td>' + listMatch[i].score2 + '</td>';
			    	  table+='<td><b>' + listMatch[i].teamDto[1].teamName + '</b><br>';
			    	  table+= listMatch[i].teamDto[1].player1Id + " - " + listMatch[i].teamDto[1].player1Name + '<br>';
			    	  table+= listMatch[i].teamDto[1].player2Id + " - " + listMatch[i].teamDto[1].player2Name + '</td>';
			    	  
			    	  table+="<td><button class=\"btn btn-danger\" onclick=\"deleteMatch("+ listMatch[i].id + ")\">Delete</button></td>";
					  /* table+="<span>  </span><button class=\"btn btn-warning\" onclick=\"updateTeam("+ listTeam[i].id + ",\'" + listTeam[i].teamName + "\'," + listTeam[i].player1 + "," + listTeam[i].player2 + "," + listTeam[i].score + ")\">Update</button></td>"; */
			    	  table+='</tr>';
			      }
			      document.getElementById("matchList").innerHTML= "";
			      if(listMatch.length>0){
			      	document.getElementById("matchList").innerHTML="<section class=\"resume-section p-3 p-lg-5 d-flex d-column\" id=\"addPlayers\">"
					+ "<div class=\"my-auto\">"
					+	"<h1 class=\"mb-0\">"
						+	"All <span class=\"text-primary\"> Matches</span>"
					+	"</h1>"
					+"</div>"
				+"</section>"
			      	+	"<div>"
					+"<table class=\"table table-hover\" id=\"table-content\">"
					+	"<thead>"
					+	"<tr>"
					+	"<th>Id</th>"
					+	"<th>Team1</th>"
					+	"<th>Team1 Score</th>"
					+ 	"<th>V/S</th>"
					+	"<th>Team2 Score</th>"
					+	"<th>Team2</th>"
					+	"<th colspan=\"2\">Date</th>"
					+	"</tr>"
					+	"</thead>"
					+   table 
				+	"</table>"
				+"</div>"

			      }
			    }
			  };
			  xhttp.open("GET", "${matchdelete }" + "?id=" + mid, true);
			  xhttp.send();
			}
	</script>
	<jsp:include page="/WEB-INF/jsp/templates/footer.jsp"></jsp:include>
</body>
</html>