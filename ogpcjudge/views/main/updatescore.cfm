<cfset rc.pageTitle = 'Update Achievements'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>

<cfoutput>
	<h2>UPDATE Achievements </h2>
	<h3>Team ###rc.updateTeamID# , #rc.teams.school_name# : #rc.teams.name#</h3>
	<h3>Category: #rc.categories.DESCR#</h3>
	<form id='frmAchievements' action="#BuildURL('main.processupdatescore')#" method="post" autocomplete="off">
	<input type="hidden" name="teamId" value="#rc.updateTeamID#">
	<input type="hidden" name="categoryID" value="#rc.updateCatID#">

	<div class="form-group achievements" id='achList'>
		<cfloop query="rc.getAchievements">
			<cfif listFind(rc.teamAchievementsList,rc.getAchievements.id)>
				<cfset highlightClass = 'checkSelected'>
				<cfset isChecked = 'checked'>
			<cfelse>
				<cfset highlightClass = ''>
				<cfset isChecked = ''>
			</cfif>
			<div class="checkbox scoring #highlightClass#" id="d#rc.getAchievements.ID#">
			<label>
			<input type="checkbox" class="cbox" id="c#rc.getAchievements.ID#" #isChecked#
				onClick="highlight(#rc.getAchievements.ID#)" name="score" value="#rc.getAchievements.ID#">
				#rc.getAchievements.DESCR#
			</label>
		</div>
		</cfloop>
	</div>

	<div class="form-group" id='commentdiv'>
	<textarea class="form-control" name="comments" id="comments" placeholder="comments">#rc.teamComments.comment_txt#</textarea>
	</div>
	<br />
	<button type="button" class="btn btn-default" id="btnSubmit">Submit Scores</button>
	<br /><br />
</form>
</cfoutput>










