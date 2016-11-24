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
		<!--- this should be done a little more dynamically, but categories wont change that often --->
		<cfset rc.achprogramming  = variables.ogpcService.getAchievements(1)> <!--- programming --->
		<cfset rc.achdesign       = variables.ogpcService.getAchievements(2)> <!--- gamedesign --->
		<cfset rc.achtheme        = variables.ogpcService.getAchievements(3)> <!--- theme --->
		<cfset rc.achassets       = variables.ogpcService.getAchievements(4)> <!--- assets --->
		<cfset rc.achprofessional = variables.ogpcService.getAchievements(5)> <!--- professional --->

	</cffunction>


	<!--- *** confirmscore(rc) --->
	<cffunction name="submitscore" access="public">
		<cfargument name="rc" required="true">

		<!--- get data to start scoring - teams and categories. --->

	</cffunction>


</cfcomponent>