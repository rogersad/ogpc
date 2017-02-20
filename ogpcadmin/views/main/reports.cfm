<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>

<div class="secondary">
<!---  show3d="yes" --->
<cfchart title="Team Scores"
	chartheight="400" chartwidth="600">
	<cfchartseries type="pie">
		<cfloop from="1" to="#Len(rc.teamResult)#" index="curRow">
			<cfchartdata item="#rc.teamResult[curRow].id# #rc.teamResult[curRow].name#" value="#rc.teamResult[curRow].totalScore#">
		</cfloop>
	</cfchartseries>
</cfchart>

<cfdump var="#rc.teamResult#">
<cfdump var="#rc.scores#">
</div>
</cfoutput>
