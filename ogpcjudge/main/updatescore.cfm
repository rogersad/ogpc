<cfset rc.pageTitle = 'Update Achievements'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>

<cfoutput>
	<h2>UPDATE Achievements </h2>
	<h3>Team ###rc.updateTeamID# , #rc.teams.school_name# : #rc.teams.name#</h3>
	<h3>Category: #rc.categories.DESCR#</h3>
	<form id='frmAchievements' action="#BuildURL('main.submitscore')#" method="post" autocomplete="off">
	<input type="hidden" name="teamId" value="#rc.updateTeamID#">
	<input type="hidden" name="categoryID" value="#rc.updateCatID#">

	<div class="form-group achievements" id='achList'>
	<!--- loaded via ajax on select change, else... --->
	<cfif structKeyExists(rc, 'teamAchievements')>
		<cfloop query="rc.teamAchievements">

			<cfif rc.teamAchievements.Earned_Achievement EQ 'X'>
				<cfset isChecked = 'checked'>
				<cfset highlightClass = 'checkSelected'>
			<cfelse>
				<cfset isChecked = ''>
				<cfset highlightClass = ''>
			</cfif>
			<div class="checkbox scoring #highlightClass#" id="d#rc.teamAchievements.ID#">
				<label>
				<input type="checkbox" class="cbox" id="c#rc.teamAchievements.ID#" #isChecked#
					onClick="highlight(#rc.teamAchievements.ID#)" name="score" value="#rc.teamAchievements.ID#">
					#rc.teamAchievements.DESCR#
				</label>
			</div>
		</cfloop>
	</cfif>
	</div>

	<div class="form-group" id='commentdiv'>
	<textarea class="form-control" name="comments" id="comments" placeholder="comments">#rc.teamComments.comment_txt#</textarea>
	</div>
	<br />
	<button type="button" class="btn btn-default" id="btnSubmit">Submit Scores</button>
	<br /><br />
</form>
</cfoutput>










