<cfcomponent accessors="true" output="false">
	<cfproperty name="ogpcService"> <!--- data access --->

	<!--- *** init(fw) --->
	<cffunction name="init" access="public">
		<cfargument name="fw" required="true">
		<cfset variables.fw = fw>
		<cfreturn this>
	</cffunction>


	<!--- **before() -- for ajax. this is always called. --->
	<cffunction name="before" access="public">
		<cfargument name="rc" required="true">

		<!---  turn off debug, layout for  --->
		<cfset request.layout = false>
		<cfsetting showdebugoutput="false">

	</cffunction>


	<!--- ***getAchievementsJSON(groupID) --->
	<cffunction name="getAchievementsJSON">
	      <cfargument name="rc" required="true">

	      <!--- get the achievements as json, renderData skips framework. --->
	      <cfset rc.getAch = variables.ogpcService.getAchievementsJSON(rc.id)>
	      <cfset result =  variables.fw.renderData('json', rc.getAch) >

	</cffunction>


	<!--- ***getScoresJSON(teamID,categoryID) used for alert if score already entered. --->
	<cffunction name="getScoresJSON">
	      <cfargument name="teamID" required="true">
	      <cfargument name="catID" required="true">

	      <!--- get existing score as json, renderData skips framework. --->
	      <cfset rc.getAch = variables.ogpcService.getScoresJSON(rc.teamID,rc.categoryID)>
	      <cfset result =  variables.fw.renderData('json', rc.getAch) >

	</cffunction>



</cfcomponent>






