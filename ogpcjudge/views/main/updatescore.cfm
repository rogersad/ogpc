<cfset rc.pageTitle = 'Update Achievements'>
<!--- <cfset rc.jslist = '<script src="includes/enterscore.js"></script>'> --->
<cfset achIndex = 1> <!--- for sub-looping --->

<!--- <cfdump var="#rc#"> --->

<cfoutput>
	<h2>UPDATE Achievements </h2>
	<h3>Team ###rc.updateTeamID# , #rc.teams.school_name# : #rc.teams.name#</h3>
	<h3>Category: #rc.categories.DESCR#</h3>
	<form id='frmAchievements' action="#BuildURL('main.processupdatescore')#" method="post" autocomplete="off">
	<input type="hidden" name="teamId" id='teamId' value="#rc.updateTeamID#">
	<input type="hidden" name="categoryID" value="#rc.updateCatID#">

	<div class="form-group achievements" id='achList'>
		<!--- loop by number so outer loop can be reset in case of radios --->
		<cfloop from="1" to="#rc.achievements.RECORDCOUNT#" index="queryRow">
			<!--- must use achIndex and not achIndex. queryRow can't be updated --->
			<cfif achIndex GT rc.achievements.RECORDCOUNT>
				<cfbreak>
			</cfif>

<!--- id:#rc.achievements.ID[achIndex]#, achIndex:#achIndex#, parentID: #rc.achievements.PARENT_ID[achIndex]#<br /> --->
			<!--- test for radio set --->
			<cfif rc.achievements.HAS_CHILD_FLAG[achIndex] EQ 'Y'>
				<cfset currentParent = rc.achievements.ID[achIndex]>

				<div class="checkbox scoring" id="d#rc.achievements.ID[achIndex]#">
				<!--- Assumes children will follow parents (DISPLAY_ORDER_NUM) --->
				<!--- when done, this loop must BREAK and set outer loop index to next row --->
				<cfset noRadioChecked = true>
				<cfloop condition="rc.achievements.PARENT_ID[achIndex] EQ currentParent">

					<cfif listFind(rc.teamAchievementsList,rc.achievements.ID[achIndex])>
						<cfset isChecked = 'checked'>
						<cfset noRadioChecked = false>
					<cfelse>
						<cfset isChecked = ''>
					</cfif>

					<label>
					<input type="radio" class="cbox" id="c#rc.achievements.ID[achIndex]#" #isChecked#
						onClick="$('##d#currentParent#').addClass('checkSelected');" name="score#currentParent#" value="#rc.achievements.ID[achIndex]#">
						#rc.achievements.DESCR[achIndex]#
						<br />
					</label>
					<cfset achIndex++>
				</cfloop>

				<!--- write default: --->
				<label>
				<input type="radio" class="cbox" id="none#rc.achievements.ID[achIndex]#" <cfif noRadioChecked>checked</cfif>
					name="score#currentParent#" value="0" onClick="$('##d#currentParent#').removeClass('checkSelected');" >
					None of the above
					<br />
				</label>
				<!--- <cfset currentParent = -1>  reset parent id --->
				</div>
			</cfif>

			<!--- was this checkbox checked? --->
			<cfif listFind(rc.teamAchievementsList,rc.achievements.ID[achIndex])>
				<cfset isChecked = 'checked'>
				<cfset highlightClass = 'checkSelected'>
				<!--- <cfset checkedCount++> --->
			<cfelse>
				<cfset highlightClass = ''>
				<cfset isChecked = ''>
			</cfif>

			<div class="checkbox scoring #highlightClass#" id="d#rc.achievements.ID[achIndex]#">
			<label>
			<input type="checkbox" class="cbox" id="c#rc.achievements.ID[achIndex]#" #isChecked#
				onClick="highlight(#rc.achievements.ID[achIndex]#);" name="score" value="#rc.achievements.ID[achIndex]#">
				#rc.achievements.DESCR[achIndex]#
			</label>
			</div>
			<cfset achIndex++>
		</cfloop>


<!--- 		<cfloop from="1" to="#rc.achievements.RECORDCOUNT#" index="queryRow">

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
								onClick="$('##d#currentParent#').addClass('checkSelected');" name="score#currentParent#" value="#rc.achievements.ID[achIndex]#">
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
								name="score#currentParent#" value="0">
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

		</cfloop> --->
	</div>

	<div class="form-group" id='commentdiv'>
	<textarea class="form-control" name="comments" id="comments" placeholder="comments">#rc.teamComments.comment_txt#</textarea>
	</div>
	<br />
	<button type="button" class="btn btn-default" id="btnSubmit" onClick="frmAchievements.submit();">Submit Scores</button>
	&nbsp;&nbsp;
	<a class="btn btn-default" href="#BuildURL('main.enterscore')#">Return to Enter Score</a>
	<br /><br />
</form>


</cfoutput>
<script>
// clik function for submit
$('#btnSubmit').click(function(){
	confirmscore();
});

/*
function highlight(checkId){
	//checkboxes cant be styled. highlight the wrapper div:
	var dNum = "d" + checkId; //changed to send id only, div id = d+ID
	$("#"+dNum).addClass('checkSelected');
}
*/
function highlight(checkId){
	//checkboxes cant be styled. highlight the wrapper div:
	var dNum = "d" + checkId; //changed to send id only, div id = d+ID
	var checkboxId = "c" + checkId;

	//for reset
	if(checkId == 0){
		$('div').removeClass('checkSelected');
	}
	else if ($("#"+checkboxId).prop('checked')) {
		$("#"+dNum).addClass('checkSelected');
	}
	else{
		$("#"+dNum).removeClass('checkSelected');
	}

}

// for main enter score page
function confirmscore(){
	var theMessage = 'Confirm achievements for \n\n';
	theMessage += $('#teamID').val();

	if(confirm(theMessage)){
			$('#frmAchievements').submit();
	}
}

</script>









