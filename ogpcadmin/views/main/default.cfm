<cfoutput>
<cfset rc.pagetitle = "OGPC Admin " />	<!--- set a variable to be used in a layout --->

<h2>#rc.pagetitle#</h2>
<div>
	<h3>Get Team Scores</h3><br /> <!--- --->

	<form action="#buildURL('main.reports')#" method="post">
	<cfloop query="rc.teams">
		<input type="radio" name="teamID" value="#rc.teams.ID#"> #rc.teams.SCHOOL_NAME# <strong>#rc.teams.NAME#</strong><br />
	</cfloop>
	<input type="submit" name="submit" value="Get Scores">
	</form>
	<!--- <cfdump var="#rc#"> --->
</div>

</cfoutput>