<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/resources/img/foosball.jpg" var="foosballIMG"></spring:url>
<spring:url value="/resources/js/sidenav.js" var="sidenavJS"></spring:url>
<spring:url value="/employee/save" var="empsave"></spring:url>
<spring:url value="/employee/delete" var="empdelete"></spring:url>
<%-- <spring:url value="/employee/hlll" var="addplayers"></spring:url> --%>
<jsp:include page="headers.jsp"></jsp:include>
<body background="${foosballIMG }">
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="container-fluid p-0">
		<span id="nav-button" style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776; Foosball</span>
		<div id="main" align="center">
			<div class="container">
				<div class="my-auto">
					<h1 class="mb-0">
						Add <span class="text-primary"> Player</span>
					</h1>
				</div>
				<form:form class="form-inline">
					<%-- action="${empsave }" modelAttribute="employee" method="POST" --%>
					<div class="form-group">
						<input type="hidden" class="form-control" id="id" name="id">
					</div>
					<!-- <div class="form-group"> -->
						<label for="email">Employee ID: </label> <input type="text" class="form-control" id="empid" placeholder="Enter Employee Id" name="employeeId" required>
					<!-- </div> -->
					<span>  </span>
					<!-- <div class="form-group"> -->
						<label for="pwd">Employee Name: </label> <input type="text" class="form-control" id="empname" placeholder="Enter Employee Name" name="employeeName" required>
					<!-- </div> -->
					<span>  </span>
					<!-- <div class="checkbox">
						<label><input type="checkbox" name="remember">
							Remember me</label>
					</div> -->

					<button type="button" class="btn btn-success" onclick="saveEmp()">Save</button>
					<br>
					<br>
					<div id="error" class="text-primary"></div>
				</form:form>
			</div>
			<div id="playerList">
				<c:if test="${!listPlayers.isEmpty() }">
					<section class="resume-section p-3 p-lg-5 d-flex d-column" id="addPlayers">
						<div class="my-auto">
							<h1 class="mb-0">
								All <span class="text-primary"> Players</span>
							</h1>
						</div>
					</section>
					<div>
						<table class="table table-hover" id="table-content">
							<thead>
								<tr>
									<th>Id</th>
									<th>EmployeeId</th>
									<th colspan="2">EmployeeName</th>
								</tr>
							</thead>
							<c:forEach items="${listPlayers }" var="employee">
								<tr>
									<td>${employee.id }</td>
									<td>${employee.employeeId }</td>
									<td>${employee.employeeName }</td>
									<td><button class="btn btn-danger" onclick="deleteEmp(${employee.id })">Delete</button>
									<span>  </span>
									<button class="btn btn-warning"	onclick="updateEmp(${employee.id },'${employee.employeeId }','${employee.employeeName }')">Update</button></td>
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
	function updateEmp(id,empId,empName){
		document.getElementById("id").value = id;
		document.getElementById("empid").value = empId;
		document.getElementById("empname").value = empName;
		document.getElementById("empid").focus();
	}
	function saveEmp(){
		var id=document.getElementById("id").value;
		var eid=document.getElementById("empid").value.trim();
		var ename=document.getElementById("empname").value.trim();
		if(eid==="" && ename===""){
			document.getElementById("error").innerHTML= "<span>EmployeeId and EmloyeeName can't be empty!</span>";
			return;
		}
		if(eid===""){
			document.getElementById("error").innerHTML= "<span>EmployeeId can't be empty!</span>";
			return;
		}
		if(ename===""){
			document.getElementById("error").innerHTML= "<span>EmpplyeeName can't be empty!</span>";
			return;
		}
		if(eid.length>60){
			document.getElementById("error").innerHTML= "<span>EmpplyeeId to large!</span>";
			return;
		}
		document.getElementById("error").innerHTML="";
		 var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		      var listPlay = JSON.parse(this.responseText);
		      document.getElementById("empid").value="";
		      document.getElementById("empname").value="";
		      document.getElementById("id").value=null;
		      var table="";
		      for(var i=0;i<listPlay.length;i++){
		    	  table+='<tr>';
		    	  table+='<td>' + listPlay[i].id + '</td>';
		    	  table+='<td>' + listPlay[i].employeeId + '</td>';
		    	  table+='<td>' + listPlay[i].employeeName + '</td>';
		    	  table+="<td><button class=\"btn btn-danger\" onclick=\"deleteEmp("+ listPlay[i].id + ")\">Delete</button>";
				  table+="<span>  </span><button class=\"btn btn-warning\" onclick=\"updateEmp("+ listPlay[i].id + ",\'" + listPlay[i].employeeId + "\',\'" + listPlay[i].employeeName + "\')\">Update</button></td>";
		    	  table+='</tr>';
		      }
		      document.getElementById("playerList").innerHTML= "";
		      if(listPlay.length>0){
		      	document.getElementById("playerList").innerHTML="<section class=\"resume-section p-3 p-lg-5 d-flex d-column\" id=\"addPlayers\">"
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
						+	"<th>EmployeeId</th>"
						+	"<th colspan=\"2\">EmployeeName</th>"
					+	"</tr>"
				+	"</thead>"
				+   table 
				/* +	"<c\:forEach items=\"${listPlay }\" var=\"employee\" >"
					+	"<tr>"
						+	"<td>" + employee.id + "</td>"
						+	"<td>${employee[id] }</td>"
						+	"<td>${employee.id }</td>"
						+	"<td><button class=\"btn btn-danger\""
								+	"onclick=\"deleteEmp(${employee.id })\">Delete</button>"
							+	"<button class=\"btn btn-warning\">Update</button></td>"
					+	"</tr>"
					+"</c\:forEach>" */
			+	"</table>"
			+"</div>"

		      }
		    }
		  };
		  xhttp.open("POST", "${empsave }" + "?id=" + id + "&employeeId=" + eid + "&employeeName=" + ename , true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  xhttp.send();
		}

		function deleteEmp(eid){
			 var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      var listPlay = JSON.parse(this.responseText);
			      var table="";
			      for(var i=0;i<listPlay.length;i++){
			    	  table+='<tr>';
			    	  table+='<td>' + listPlay[i].id + '</td>';
			    	  table+='<td>' + listPlay[i].employeeId + '</td>';
			    	  table+='<td>' + listPlay[i].employeeName + '</td>';
			    	  table+="<td><button class=\"btn btn-danger\" onclick=\"deleteEmp("+ listPlay[i].id + ")\">Delete</button>";
					  table+="<span>  </span><button class=\"btn btn-warning\" onclick=\"updateEmp("+ listPlay[i].id + ",\'" + listPlay[i].employeeId + "\',\'" + listPlay[i].employeeName + "\')\">Update</button></td>";
			    	  table+='</tr>';
			      }
			      document.getElementById("playerList").innerHTML= "";
			      if(listPlay.length>0){
			      	document.getElementById("playerList").innerHTML="<section class=\"resume-section p-3 p-lg-5 d-flex d-column\" id=\"addPlayers\">"
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
							+	"<th>EmployeeId</th>"
							+	"<th colspan=\"2\">EmployeeName</th>"
						+	"</tr>"
					+	"</thead>"
					+   table 
					/* +	"<c\:forEach items=\"${listPlay }\" var=\"employee\" >"
						+	"<tr>"
							+	"<td>" + employee.id + "</td>"
							+	"<td>${employee[id] }</td>"
							+	"<td>${employee.id }</td>"
							+	"<td><button class=\"btn btn-danger\""
									+	"onclick=\"deleteEmp(${employee.id })\">Delete</button>"
								+	"<button class=\"btn btn-warning\">Update</button></td>"
						+	"</tr>"
						+"</c\:forEach>" */
				+	"</table>"
				+"</div>"

			      }
			    }
			  };
			  xhttp.open("GET", "${empdelete }" + "?id=" + eid, true);
			  xhttp.send();
			}
	</script>
	<jsp:include page="/WEB-INF/jsp/templates/footer.jsp"></jsp:include>
</body>
</html>