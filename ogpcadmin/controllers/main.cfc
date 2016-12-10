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


	<!--- *** reports(rc) --->
	<cffunction name="reports" access="public">
		<cfargument name="rc" required="true">
		<!--- home page. nothing here really. --->
		<cfset rc.results = variables.ogpcService.getScores()>

	</cffunction>




</cfcomponent>














