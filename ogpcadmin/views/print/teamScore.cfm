<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>

<div class="secondary">

<h2>Team: ###rc.team.ID# #rc.team.NAME#, #rc.team.SCHOOL_NAME#</h2>
<h2>Total Score: #rc.grandTotal#</h2> <!--- --->

<table class="table dataTable"> <!---  id='results#categoryRow#' --->
<cfloop from="1" to="#rc.categories.recordCount#" index="categoryRow">
	<!--- <thead> --->
	<tr>
		<td colspan="3"><h4>#Ucase(rc.categories.DESCR[categoryRow])#</h4></td>
	</tr>
	<tr>
		<td>RESULT</td>
		<td>POINTS</td>
		<td>ACHIEVEMENT</td>
	</tr>
	<!--- </thead> --->
	<!--- <tbody> --->
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
			<hr />
		</td>
	</tr>

	<!--- </tbody> --->
</cfloop>
	</table>
	<!--- <hr /> --->


</div>
</cfoutput>
<!--- <cfdump var="#rc#"> --->
