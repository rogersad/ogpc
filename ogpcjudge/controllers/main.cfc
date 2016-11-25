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
		<!--- home page. nothing here really. --->

	</cffunction>


	<!--- *** enterscore(rc) --->
	<cffunction name="enterscore" access="public">
		<cfargument name="rc" required="true">

		<!--- get data to start scoring - teams and categories. --->
		<cfset rc.categories = variables.ogpcService.getCategories()>
		<cfset rc.judges = variables.ogpcService.getJudgeTeams()>
		<cfset rc.teams = variables.ogpcService.getTeams()>

	</cffunction>


	<!--- *** submitscore(rc) --->
	<cffunction name="submitscore" access="public">
		<cfargument name="rc" required="true">

		<!--- save team, achievement scores --->

	</cffunction>


</cfcomponent>