<cfoutput>
<cfset rc.pagetitle = "OGPC Admin " />	<!--- set a variable to be used in a layout --->

<h2>#rc.pagetitle#</h2>
	<h3>Get Team Scores</h3> <!--- --->

	<form action="#buildURL('main.teamScore')#" method="post">
	<div class="form-group">
	<select name="teamID">
	<cfloop query="rc.teams">
		<option value="#rc.teams.ID#">###rc.teams.ID# #rc.teams.SCHOOL_NAME# <strong>#rc.teams.NAME#</strong></option>
	</cfloop>
	</div>
	<div class="form-group">
	<input type="submit" name="submit" value="Get Scores">
	</div>
	</form>


	<!--- *** load schools, teams:

	<div style="margin:10px; padding:6px; border:2px solid blue; width:20%;">

		<form action="#buildURL('main.loadSchools')#" method="post"> <!---  onSubmit="return false" --->
		<div class="form-group">
		Password:<input type="password" name="password" value="">
		<input type="submit" name="submit" value="Load Schools">
		</div>
		</form>

	</div>
	<div style="margin:10px; padding:6px; border:2px solid blue; width:20%;">
		(load schools first, please)
		<form action="#buildURL('main.loadTeams')#" method="post"> <!---  onSubmit="return false" --->
		<div class="form-group">
		Password:<input type="password" name="password" value="">
		<input type="submit" name="submit" value="Load Teams">
		</div>
		</form>

	</div>
--->


</cfoutput>