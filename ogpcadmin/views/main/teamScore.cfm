<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>

<div class="secondary">

<h4>
<form name="fprint" action="#buildURL('print.teamScore')#" method="post">
	<input type="hidden" name="teamID" value="#rc.teamID#">
	<input type="submit" name="submit" value="PDF Version">
</form>
</h4>

<h2>Team: ###rc.team.ID# #rc.team.NAME#, #rc.team.SCHOOL_NAME#</h2>
<h2>Total Score: #rc.grandTotal#</h2> <!--- --->

<cfloop from="1" to="#rc.categories.recordCount#" index="categoryRow">
	<table id='results#categoryRow#' class="table dataTable">
	<thead>
	<tr>
		<th colspan="3"><h4>#Ucase(rc.categories.DESCR[categoryRow])#</h4></th>
	</tr>
	<tr>
		<th>RESULT</th>
		<th>POINTS</th>
		<th>ACHIEVEMENT</th>
	</tr>
	</thead>
	<tbody>
	<!--- ID POINT_VALUE CATEGORY_ID EARNED_ACHIEVEMENT RC.COMMENTS[CATEGORY_ID]--->
	<cfloop from="1" to="#rc.results[rc.categories.DESCR].recordCount#" index="resultRow">
		<tr>
			<td>#rc.results[rc.categories.DESCR[categoryRow]].EARNED_ACHIEVEMENT[resultRow]#</td>
			<td>#rc.results[rc.categories.DESCR[categoryRow]].POINT_VALUE[resultRow]#</td>
			<td>#rc.results[rc.categories.DESCR[categoryRow]].DESCR[resultRow]#</td>
		</tr>
	</cfloop>
	<tr>
		<td colspan="3">#rc.COMMENTS[categoryRow].COMMENT_TXT#</td>
	</tr>
	<tr>
		<td colspan="3">
			Points for this category: #rc.categoryAchievementScore[categoryRow]# <br />
			Bonus Achievements: #rc.categoryBonusCount[categoryRow]# <br />
			<h4>Total Points: #rc.categoryTotalScore[categoryRow]#</h4>
		</td>
	</tr>

	</tbody>
	</table>
	<hr />
</cfloop>


</div>
</cfoutput>
<!--- <cfdump var="#rc#"> --->
