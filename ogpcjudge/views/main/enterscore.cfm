<!--- variables for this page: --->
<cfset rc.pageTitle = 'Score Achievements'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>
<!--- in case of achievement radio set --->
<cfset currentParent = -1>
<cfset achIndex = 0>  <!--- loop index for achievememts. starts at 0, incremented before 1st row --->

<cfoutput>
<h2>Score Achievements </h2>

<h3>Category: #rc.displayCategory#</h3>

<cfif NOT structKeyExists(client,'judgename')>
	<cflocation addtoken="false" url="#BuildURL('main.login')#">
<cfelse>
	<div>Current user: #client.judgename# <br /><br /></div>
</cfif>

<form id='frmUpdate' action="#BuildURL('main.updatescore')#" onSubmit='return teamNotZero();' method="post" autocomplete="off">
	<input type="hidden" name="teamID" id="updateTeamID" value="">
	<input type="hidden" name="catID" id="updateCatID" value="">
	<input type="hidden" name="categoryID" id="categoryID" value="#client.categoryID#">
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
	</div>

	<div id="warning" class="error hide"></div>

	<div class="form-group achievements" id='achList'>
	<!--- loaded via ajax on select change, else... --->
	<cfif structKeyExists(rc, 'achievements')>
		<!--- loop by number so outer loop can be reset in case of radios --->
		<cfloop from="1" to="#rc.achievements.RECORDCOUNT#" index="queryRow">
			<!--- must use achIndex and not achIndex. queryRow can't be updated --->
			<cfset achIndex++>
			<cfif achIndex GT rc.achievements.RECORDCOUNT>
				<cfbreak>
			</cfif>

			<!--- test for radio set --->
			<cfif rc.achievements.HAS_CHILD_FLAG[achIndex] EQ 'Y'>
				<cfset currentParent = rc.achievements.ID[achIndex]>

				<div class="checkbox scoring" id="d#rc.achievements.ID[achIndex]#">
				<!--- do this one, then loop children --->
				<label>
				<input type="radio" class="cbox" id="c#rc.achievements.ID[achIndex]#"
					onClick="highlight(#rc.achievements.ID[achIndex]#)" name="score#currentParent#" value="#rc.achievements.ID[achIndex]#">
					#rc.achievements.DESCR[achIndex]#
					<br />
				</label>

				<!--- Assumes children will follow parents (DISPLAY_ORDER_NUM) --->
				<!--- when done, this loop must BREAK and set outer loop index to next row --->
				<cfloop  from="#achIndex+1#" to="#rc.achievements.RECORDCOUNT#" index="radioRow">
					<cfif rc.achievements.PARENT_ID[radioRow] EQ currentParent>
						<label>
						<input type="radio" class="cbox" id="c#rc.achievements.ID[radioRow]#"
							onClick="highlight(#rc.achievements.ID[radioRow]#)" name="score#currentParent#" value="#rc.achievements.ID[radioRow]#">
							#rc.achievements.DESCR[radioRow]#
							<br />
						</label>
					<cfelse>
						<cfset currentParent = -1>  <!--- reset parent id --->
						<cfset achIndex = radioRow> <!--- reset outerloop --->
						<cfbreak>					<!--- break --->
					</cfif>
				</cfloop>
				</div>                      <!--- close radio div --->
			</cfif>

			<div class="checkbox scoring" id="d#rc.achievements.ID[achIndex]#">
			<label>
			<input type="checkbox" class="cbox" id="c#rc.achievements.ID[achIndex]#"
				onClick="highlight(#rc.achievements.ID[achIndex]#)" name="score" value="#rc.achievements.ID[achIndex]#">
				#rc.achievements.DESCR[achIndex]#
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
	<button type="reset" class="btn btn-default" id="btnReset" onClick="highlight(0);" >Reset</button>

	<br /><br />
</form>

</cfoutput>











