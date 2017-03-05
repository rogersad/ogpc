<cfset rc.pageTitle = 'Update Achievements'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>
<cfset achIndex = 0> <!--- for sub-looping --->

<cfoutput>
	<h2>UPDATE Achievements </h2>
	<h3>Team ###rc.updateTeamID# , #rc.teams.school_name# : #rc.teams.name#</h3>
	<h3>Category: #rc.categories.DESCR#</h3>
	<form id='frmAchievements' action="#BuildURL('main.processupdatescore')#" method="post" autocomplete="off">
	<input type="hidden" name="teamId" value="#rc.updateTeamID#">
	<input type="hidden" name="categoryID" value="#rc.updateCatID#">

	<div class="form-group achievements" id='achList'>
		<cfloop from="1" to="#rc.achievements.RECORDCOUNT#" index="queryRow">
			<!--- must use achIndex and not queryRow. queryRow can't be updated --->
			<!--- achIndex stars off = queryRow, but will get updated --->
			<cfset achIndex++>
			<cfif achIndex GT rc.achievements.RECORDCOUNT>
				<cfbreak>
			</cfif>

			<!--- highlight, is checkd: --->
			<cfif listFind(rc.teamAchievementsList,rc.achievements.id[queryRow])>
				<cfset highlightClass = 'checkSelected'>
				<cfset isChecked = 'checked'>
<!--- FOUND #rc.achievements.id[queryRow]#; --->
			<cfelse>
				<cfset highlightClass = ''>
				<cfset isChecked = ''>
<!--- **NOT #rc.achievements.id[queryRow]#; --->
			</cfif>

rc.achievements.HAS_CHILD_FLAG[queryRow]:#rc.achievements.HAS_CHILD_FLAG[queryRow]#
			<!--- test for radio set --->
			<cfif rc.achievements.HAS_CHILD_FLAG[queryRow] EQ 'Y'>
				<cfset currentParent = rc.achievements.ID[queryRow]>

				<div class="checkbox scoring" id="d#currentParent#">
				<!--- remove all of these: --->

				<!--- do this one, then loop children
				<label>
				<input type="radio" class="cbox" id="c#rc.achievements.ID[achIndex]#"
					onClick="highlight(#currentParent#)" name="score#currentParent#" value="#rc.achievements.ID[achIndex]#">
					#rc.achievements.DESCR[achIndex]#
					<br />
				</label>
 --->
				<!--- Assumes children will follow parents (DISPLAY_ORDER_NUM) --->
				<!--- when done, this loop must BREAK and set outer loop index to next row
				<cfloop  from="#achIndex+1#" to="#rc.achievements.RECORDCOUNT#" index="radioRow">
achID:#rc.achievements.id[achIndex]# achIndex: #achIndex#; highlightClass: #highlightClass#; isChecked: #isChecked#; radioRow: #radioRow#;
					<cfif rc.achievements.PARENT_ID[radioRow] EQ currentParent>
						<label>
						<input type="radio" class="cbox" id="c#rc.achievements.ID[radioRow]#" #isChecked#
							onClick="highlight(#currentParent#)" name="score#currentParent#" value="#rc.achievements.ID[radioRow]#">
							#rc.achievements.DESCR[radioRow]#
							<br />
						</label>
					<cfelse>
						<cfset currentParent = -1>  <!--- reset parent id --->
						<cfset achIndex = radioRow+1> <!--- reset outerloop --->
						<cfbreak>					<!--- break --->
					</cfif>
				</cfloop>
				</div>                      <!--- close radio div --->
			 --->

				 <!--- 10 is arbitray, bigger than any sub-radio list. will break out when done --->
				<cfloop from="#queryRow#" to="#queryRow+10#" index="radioRow">

					<cfif rc.achievements.PARENT_ID[achIndex] NEQ currentParent>
has child in loop radio neq parent radioRow: #radioRow#, currentParent: #currentParent# achIndex:#achIndex#
rc.achievements.PARENT_ID[queryRow]:#rc.achievements.PARENT_ID[queryRow]#
<cfabort>
						<cfbreak>
					</cfif>

					<cfif listFind(rc.teamAchievementsList,rc.achievements.id[radioRow])>
						<cfset setHighlight = true>
						<cfset isChecked = 'checked'>
					<cfelse>
						<cfset isChecked = ''>
					</cfif>
					<label>
					<input type="radio" class="cbox" id="c#rc.achievements.ID[radioRow]#" #isChecked#
						onClick="highlight(#currentParent#)" name="score#currentParent#" value="#rc.achievements.ID[radioRow]#">
						#rc.achievements.DESCR[radioRow]#
						<br />
					</label>
					<cfset achIndex++> <!--- keep this in sync with outer loop --->
				</cfloop>

				<label>
				<input type="radio" class="cbox" id="none"
					onClick="$('##d#currentParent#').removeClass('checkSelected');" name="score#currentParent#" value="0">
					None of the items above
					<br />
				</label>
				<cfif setHighlight>
					<script>highlight(#currentParent#);</script>
				</cfif>
				</div>


			<!--- Need to reset hightlight loop after radios.
			<cfif listFind(rc.teamAchievementsList,rc.achievements.id[achIndex])>
				<cfset highlightClass = 'checkSelected'>
				<cfset isChecked = 'checked'>
				<!--- FOUND #rc.achievements.id[achIndex]#; --->
			<cfelse>
				<cfset highlightClass = ''>
				<cfset isChecked = ''>
			</cfif>
 --->
			<cfelse> <!--- not radio set --->
				<div class="checkbox scoring #highlightClass#" id="d#rc.achievements.ID[achIndex]#">
				<label>
				<input type="checkbox" class="cbox" id="c#rc.achievements.ID[achIndex]#" #isChecked#
					onClick="highlight(#rc.achievements.ID[achIndex]#)" name="score" value="#rc.achievements.ID[achIndex]#">
					#rc.achievements.DESCR[achIndex]#
				</label>
				</div>
			</cfif>

		</cfloop>
		<!---
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
		 --->
	</div>

	<div class="form-group" id='commentdiv'>
	<textarea class="form-control" name="comments" id="comments" placeholder="comments">#rc.teamComments.comment_txt#</textarea>
	</div>
	<br />
	<button type="button" class="btn btn-default" id="btnSubmit">Submit Scores</button>
	<br /><br />
</form>
<cfdump var="#rc#">

</cfoutput>










