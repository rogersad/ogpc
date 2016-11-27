<cfset rc.pageTitle = 'Score Achievements'>
<!--- <cfset rc.jslist = '<script src="includes/enterscore.js"></script>'> --->

<cfdump var="#rc#">
<cfabort>

<cfoutput>
	<h2>Score Achievements </h2>
<form id='frmUpdate' action="#BuildURL('main.updatescore')#" onSubmit='return teamNotZero();' method="post" autocomplete="off">
	<input type="hidden" name="teamID" id="updateTeamID" value="">
	<input type="hidden" name="catID" id="updateCatID" value="">
</form>

<form id='frmAchievements' action="#BuildURL('main.submitscore')#" method="post" autocomplete="off">
  <div class="form-group">
	<label>Team:
	<select class="form-control" name="teamID" id="teamID">
		<option value="">Select...</option>
		<cfloop query="rc.teams">
			<option value="#rc.teams.ID#">###rc.teams.ID#, #rc.teams.school_name# : #rc.teams.name#</option>
		</cfloop>
	</select>
	</label>
	&nbsp;
	<!--- this is the submit button for update form ABOVE: --->
	<label class="inline">
		<input id="reloadPrior" type="button" class="btn btn-default" onClick="copyTC();submitUpdate();" value="Update Score" />
	</label>

	</div>

	<div class="form-group">
	<label>Category:
	<select class="form-control" name="categoryID" id="categoryID">
		<option value="">Select...</option>
		<cfloop query="rc.categories">
			<cfset selected = ''>
			<cfif rc.categories.ID EQ client.categoryID>
				<cfset selected = 'selected'>
			</cfif>
			<option #selected# value="#rc.categories.ID#">#rc.categories.DESCR#</option>
		</cfloop>
	</select>
	</label>
	&nbsp;
	<!---
	<label class="inline">
		<input id="getQ" type="button" class="btn btn-default" value="Load Achievement List" />
	</label>
	 --->
	</div>

	<div class="form-group achievements" id='achList'>
	<!--- loaded via ajax on select change, else... --->
	<cfif structKeyExists(rc, 'achievements')>
		<cfloop query="rc.achievements">
			<div class="checkbox scoring" id="d#rc.achievements.ID#">
				<label>
				<input type="checkbox" class="cbox" id="c#rc.achievements.ID#"
					onClick="highlight(#rc.achievements.ID#)" name="score" value="#rc.achievements.ID#">
				#rc.achievements.DESCR#
				</label>
			</div>
		</cfloop>
	</cfif>
	</div>

	<div class="form-group" id='commentdiv'>
	<textarea class="form-control" name="comments" id="comments" placeholder="comments"></textarea>
	</div>
	<br />
	<button type="button" class="btn btn-default" id="btnSubmit">Submit Scores</button>
	<br /><br />
</form>

</cfoutput>











