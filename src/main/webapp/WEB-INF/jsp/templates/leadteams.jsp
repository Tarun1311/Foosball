<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/resources/img/foosball.jpg" var="foosballIMG"></spring:url>
<spring:url value="/resources/js/sidenav.js" var="sidenavJS"></spring:url>
<jsp:include page="headers.jsp"></jsp:include>
<body background="${foosballIMG }">
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="container-fluid p-0">
		<span id="nav-button" style="font-size: 30px; cursor: pointer"
			onclick="openNav()">&#9776; Foosball</span>
		<div id="main" align="center">
			<div id="teamList">
				<c:choose>
					<c:when test="${!listTeams.isEmpty() }">
						<section class="resume-section p-3 p-lg-5 d-flex d-column"
							id="addTeams">
							<div class="my-auto">
								<h1 class="mb-0">
									Leader<span class="text-primary">Board</span>
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
										<th>Score</th>
									</tr>
								</thead>
								<c:forEach items="${listTeams }" var="team">
									<tr>
										<td>${team.id }</td>
										<td>${team.teamName }</td>
										<td>${team.player1Id }-${team.player1Name }</td>
										<td>${team.player2Id }-${team.player2Name }</td>
										<td>${team.score }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</c:when>
					<c:otherwise>
						<div class="container">
							<div class="my-auto">
								<h1 class="mb-0">
									Add Teams<span class="text-primary"> First</span>
								</h1>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<script src="${sidenavJS }"></script>
	<jsp:include page="/WEB-INF/jsp/templates/footer.jsp"></jsp:include>
</body>
</html>