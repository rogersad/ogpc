<cfset rc.pageTitle = 'Score Achievements'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>

<cfoutput>
	<h2>Score Achievements </h2>
	<!---<cfdump var="#rc#"> --->
<form action="#BuildURL('main.submitscore')#" method="post" autocomplete="off">
  <div class="form-group">
	<label>Team:
	<select class="form-control" name="teamID" id="teamID">
		<cfloop query="rc.teams">
			<option value="#rc.teams.ID#">###rc.teams.ID#, #rc.teams.school_name# : #rc.teams.name#</option>
		</cfloop>
	</select>
	</label>
	&nbsp;
	<label class="inline">
		<input type="hidden" id="locked" value="false">
  		<!--- <input type="checkbox" id="lockTeam" value="lockTeam" onclick="lock();"> Lock --->
		<input id="lockTeam" type="button" class="btn btn-default notlocked" onClick="lock();" value="Lock" />
	</label>
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
		<input id="getQ" type="button" class="btn btn-default" onClick="showQ()" value="Load Achievement List" />
	</label>
	</div>

	<!--- attempted to do this dynamically.. a lot of trouble --->
	<!--- <cfloop from="1" to="#rc.categories.recordCount#" index="currentRow"> --->
	<!--- this creates multiple divs using dynamic var names achievements1.ID,acheivements2.ID, etc --->
	<!--- </cfloop> --->
	<div class="form-group achievements" id="programming">
		<cfloop query="rc.achprogramming">
			<div class="checkbox scoring" id="d#rc.achprogramming.ID#">
			<label>
			&nbsp;
			<input type="checkbox" id="pg#rc.achprogramming.ID#" onClick="highlight(this.id)"
				name="score<!--- pg#rc.achprogramming.ID# --->" value="#rc.achprogramming.ID#">
			#DESCR#
			</label>
			</div>
		</cfloop>
	</div>

	<div class="form-group achievements" id="design">
		<cfloop query="rc.achdesign">
			<div class="checkbox scoring" id="d#rc.achdesign.ID#">
			<label>
			&nbsp;
			<input type="checkbox" id="de#rc.achdesign.ID#" onClick="highlight(this.id)"
				name="score<!--- de#rc.achdesign.ID# --->" value="#rc.achdesign.ID#">
			#DESCR#
			</label>
			</div>
		</cfloop>
	</div>

	<div class="form-group achievements" id="theme">
		<cfloop query="rc.achtheme">
			<div class="checkbox scoring" id="d#rc.achtheme.ID#">
			<label>
			&nbsp;
			<input type="checkbox" id="th#rc.achtheme.ID#" onClick="highlight(this.id)"
				name="score<!--- th#rc.achtheme.ID# --->" value="#rc.achtheme.ID#">
			#DESCR#
			</label>
			</div>
		</cfloop>
	</div>

	<div class="form-group achievements" id="assets">
		<cfloop query="rc.achassets">
			<div class="checkbox scoring" id="d#rc.achassets.ID#">
			<label>
			&nbsp;
			<input type="checkbox" id="as#rc.achassets.ID#" onClick="highlight(this.id)"
				name="score<!--- as#rc.achassets.ID# --->" value="#rc.achassets.ID#">
			#DESCR#
			</label>
			</div>
		</cfloop>
	</div>

	<div class="form-group achievements" id="professional">
		<cfloop query="rc.achprofessional">
			<div class="checkbox scoring" id="d#rc.achprofessional.ID#">
			<label>
			&nbsp;
			<input type="checkbox" id="pf#rc.achprofessional.ID#" onClick="highlight(this.id)"
				name="score<!--- pf#rc.achprofessional.ID# --->" value="#rc.achprofessional.ID#">
			#DESCR#
			</label>
			</div>
		</cfloop>
	</div>

	<button type="submit" class="btn btn-default">Enter Score</button>
	<br /><br />
</form>


</cfoutput>
