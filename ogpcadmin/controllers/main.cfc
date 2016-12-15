<cfcomponent accessors="true" output="false">
	<cfproperty name="ogpcService"> <!--- data access --->

	<!--- *** init(fw) --->
	<cffunction name="init" access="public">
		<cfargument name="fw" required="true">
		<cfset variables.fw = fw>
		<cfreturn this>
	</cffunction>


	<!--- *** default(rc) --->
	<cffunction name="default" access="public">
		<cfargument name="rc" required="true">

		<cfset rc.teams = variables.ogpcService.getTeams()>

	</cffunction>


	<!--- *** reports(rc) --->
	<cffunction name="reports" access="public">
		<cfargument name="rc" required="true">

		<cfset rc.results = structNew()>
		<cfset rc.categories = variables.ogpcService.getCategories()>
		<cfloop query="rc.categories">
			<cfset rc.results[rc.categories.DESCR] = variables.ogpcService.getTeamAchievements(rc.teamID,rc.categories.ID)>
		</cfloop>

	</cffunction>




</cfcomponent>














