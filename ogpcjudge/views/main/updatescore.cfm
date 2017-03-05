<cfset rc.pageTitle = 'Update Achievements'>
<!--- <cfset rc.jslist = '<script src="includes/enterscore.js"></script>'> --->
<cfset achIndex = 1> <!--- for sub-looping --->

<cfdump var="#rc.teamAchievementsList#">

<cfoutput>
	<h2>UPDATE Achievements </h2>
	<h3>Team ###rc.updateTeamID# , #rc.teams.school_name# : #rc.teams.name#</h3>
	<h3>Category: #rc.categories.DESCR#</h3>
	<form id='frmAchievements' action="#BuildURL('main.processupdatescore')#" method="post" autocomplete="off">
	<input type="hidden" name="teamId" value="#rc.updateTeamID#">
	<input type="hidden" name="categoryID" value="#rc.updateCatID#">

	<div class="form-group achievements" id='achList'>
		<cfloop from="1" to="#rc.achievements.RECORDCOUNT#" index="queryRow">

			<!--- use achIndex because queryRow cant be changed --->
			<cfif achIndex GT rc.achievements.RECORDCOUNT>
				<cfbreak>
			</cfif>

			<!--- radio set start --->
			<cfif rc.achievements.HAS_CHILD_FLAG[achIndex] EQ 'Y'>
				<cfset currentParent = rc.achievements.ID[achIndex]>

				<div class="checkbox scoring" id="d#currentParent#">
					<!--- 10 is arbitrary, larger than any subgroup --->
					<cfset checkedCount = 0>
					<cfloop from="1" to="10" index="radioRow">
						<cfif rc.achievements.PARENT_ID[achIndex] EQ currentParent>

							<!--- was this one checked? --->
							<cfif listFind(rc.teamAchievementsList,rc.achievements.ID[achIndex])>
								<cfset isChecked = 'checked'>
								<cfset checkedCount++>
							<cfelse>
								<cfset isChecked = ''>
							</cfif>

							<label>
							<input type="radio" class="cbox" id="c#rc.achievements.ID[achIndex]#" #isChecked#
								onClick="highlight(#currentParent#)" name="score#currentParent#" value="#rc.achievements.ID[achIndex]#">
								#rc.achievements.DESCR[achIndex]#
								<br />
							</label>
							<!--- increment ach: --->
							<cfset achIndex++>
						<cfelse>
							<!--- show 'None' for un-checking radios --->
							<cfif checkedCount EQ 0>
								<cfset checkNone = 'checked'>
							<cfelse>
								<cfset checkNone = ''>
							</cfif>
							<label>
							<input type="radio" class="cbox" id="none#rc.achievements.ID[achIndex]#" #checkNone#
								onClick="$('##d#currentParent#').removeClass('checkSelected');"
								name="score#currentParent#" value="none">
								None of the above
							</label>

							<cfset achIndex--> <!--- reset ach for outside loop --->
							<cfbreak>  <!--- break radioRow loop: --->

						</cfif>
					</cfloop>

				</div>

			<!--- regular checkox: --->
			<cfelse>
				<!--- was this one checked? --->
				<cfif listFind(rc.teamAchievementsList,rc.achievements.ID[achIndex])>
					<cfset highlightClass = 'checkSelected'>
					<cfset isChecked = 'checked'>
				<cfelse>
					<cfset highlightClass = ''>
					<cfset isChecked = ''>
				</cfif>

				<div class="checkbox scoring #highlightClass#" id="d#rc.achievements.ID[achIndex]#">
				<label>
				<input type="checkbox" class="cbox" id="c#rc.achievements.ID[achIndex]#" #isChecked#
					onClick="highlight(#rc.achievements.ID[achIndex]#)" name="score" value="#rc.achievements.ID[achIndex]#">
					#rc.achievements.DESCR[achIndex]#
				</label>
				</div>
			</cfif>

			<cfset achIndex++>

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
<script>
function highlight(checkId){
	//checkboxes cant be styled. highlight the wrapper div:
	var dNum = "d" + checkId; //changed to send id only, div id = d+ID
	$("#"+dNum).addClass('checkSelected');
	}
</script>









