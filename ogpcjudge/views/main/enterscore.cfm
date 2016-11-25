<cfset rc.pageTitle = 'Score Achievements'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>

<cfoutput>
	<h2>Score Achievements </h2>
	<!---<cfdump var="#rc#"> --->
<form id='frmAchievements' action="#BuildURL('main.submitscore')#" method="post" autocomplete="off">
  <div class="form-group">
	<label>Team:
	<select class="form-control" name="teamID" id="teamID">
		<cfloop query="rc.teams">
			<option value="#rc.teams.ID#">###rc.teams.ID#, #rc.teams.school_name# : #rc.teams.name#</option>
		</cfloop>
	</select>
	</label>
	&nbsp;
	<!---
	<label class="inline">
		<input type="hidden" id="locked" value="false">
  		<!--- <input type="checkbox" id="lockTeam" value="lockTeam" onclick="lock();"> Lock --->
		<input id="lockTeam" type="button" class="btn btn-default notlocked" onClick="lock();" value="Lock" />
	</label>
	 --->
	</div>

	<div class="form-group">
	<label>Category:
	<select class="form-control" name="categoryID" id="categoryID">
		<option value="">Select...</option>
		<cfloop query="rc.categories">
			<option value="#rc.categories.ID#">#rc.categories.DESCR#</option>
		</cfloop>
	</select>
	</label>
	&nbsp;
	<label class="inline">
		<input id="getQ" type="button" class="btn btn-default" value="Load Achievement List" />
	</label>
	</div>

	<div class="form-group achievements" id='achList'>
	<!--- loaded via ajax --->
	</div>

	<div class="form-group" id='commentdiv'>
	<textarea class="achievements" name="comments" id="comments" cols="60" rows="4" placeholder="comments"></textarea>
	</div>
	<br />
	<button type="button" class="btn btn-default" id="btnSubmit">Submit Scores</button>
	<br /><br />
</form>


</cfoutput>
