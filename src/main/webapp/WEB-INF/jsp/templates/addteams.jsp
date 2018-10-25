<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/resources/img/foosball.jpg" var="foosballIMG"></spring:url>
<spring:url value="/resources/js/sidenav.js" var="sidenavJS"></spring:url>
<spring:url value="/team/save" var="teamsave"></spring:url>
<spring:url value="/team/delete" var="teamdelete"></spring:url>
<%-- <spring:url value="/employee/hlll" var="addplayers"></spring:url> --%>
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
						Add <span class="text-primary"> Team</span>
					</h1>
				</div>
				<form:form class="form-inline">
					<div class="form-group">
						<input type="hidden" class="form-control" id="id" name="id">
					</div>
					<!-- <div class="form-group">
						<label for="email">Employee ID: </label> <input type="text" class="form-control" id="empid" placeholder="Enter Employee Id" name="employeeId" required>
					</div> -->
					<!-- <span>  </span> -->
					<div class="form-group">
						<label for="pwd">Team Name: </label> <input type="text" class="form-control" id="teamname" placeholder="Enter Team Name" name="teamName">
					</div>
					<span>  </span>
					<div class="form-group">
						<label for="player1">Player 1</label> <select
							class="form-control" id="player1">
							<option value="" disabled selected>Select Player 1</option>
							<c:forEach items="${listPlayers }" var="employee1">
								<option value="${employee1.id }">${employee1.employeeId } - ${employee1.employeeName }</option>
								</c:forEach>
						</select>
					</div>
					<span>  </span>
					<div class="form-group">
						<label for="player2">Player 2</label> <select
							class="form-control" id="player2">
							<option value="" disabled selected>Select Player 2</option>
							<c:forEach items="${listPlayers }" var="employee2">
								<option value="${employee2.id }">${employee2.employeeId } - ${employee2.employeeName }</option>
								</c:forEach>
						</select>
					</div>
					<span> </span>
					<div class="form-group">
						<label for="pwd">Team Score: </label> <input type="number" class="form-control" id="score" name="score" value="0">
					</div>
					<br><br>
					<div id="error" class="text-primary"></div>
					<button type="button" class="btn btn-success" onclick="saveTeam()">Save</button>
				</form:form>
			</div>
			<div id="teamList">
				<c:if test="${!listTeams.isEmpty() }">
					<section class="resume-section p-3 p-lg-5 d-flex d-column"
						id="addTeams">
						<div class="my-auto">
							<h1 class="mb-0">
								All <span class="text-primary"> Teams</span>
							</h1>
						</div>
					</section>
					<div>
						<table class="table table-hover" id="table-content">
							<thead>
								<tr>
									<th>Id</th>
									<th>TeamName</th>
									<th>Player1</th>
									<th>Player2</th>
									<th colspan="2">Score</th>
								</tr>
							</thead>
							<c:forEach items="${listTeams }" var="team">
								<tr>
									<td>${team.id }</td>
									<td>${team.teamName }</td>
									<td>${team.player1Id } - ${team.player1Name }</td>
									<td>${team.player2Id } - ${team.player2Name }</td>
									<td>${team.score }</td>
									<td><button class="btn btn-danger"
											onclick="deleteTeam(${team.id })">Delete</button> <span>
									</span>
										<button class="btn btn-warning"
											onclick="updateTeam(${team.id },'${team.teamName }',${team.player1 },${team.player2 },${team.score })">Update</button></td>
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
		if(player2 == player1){
			document.getElementById("error").innerHTML= "<span>Player1 & Player2 can't be same!</span><br><br>";
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