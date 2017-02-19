<cfcomponent extends="framework.one" output="false">
<cfprocessingdirective suppressWhiteSpace="true" />

<cfset this.name = "ogpc_judging_app">
<cfset this.sessionManagement = true>
<cfset this.sessionTimeout = createTimeSpan(0,2,0,0)>
<cfset this.clientManagement = true>
<cfset this.setClientCookies = true>
<cfset this.clientStorage = 'cookie'>
<cfset this.dataSource = "ideaslide">

<!--- OGPC SPECIFIC: --->
<cfset this.eventYear = '2017'>
<!--- -------------- --->

<!--- framework settings --->
<!--- *** CHANGE THESE TO 'FALSE' FOR PRODUCTION: *** --->
<cfset framework.reloadApplicationOnEveryRequest = true>
<cfset framework.trace = true>
<cfset this.debugdump = true>
<!--- *** *** *** *** *** *** *** *** --->

<!--- these stay the same:   --->
<cfset framework.sesOmitIndex = false> <!---  dont show /index.cfm in url --->
<cfset framework.generateSES = false>  <!---  slash type urls with no '?action=' wasnt working. dunno why --->

<!--- end framework settings --->


<cffunction name="setupApplication">
    <!--- // copy to variables scope --->
    <cfset application.dsn = this.datasource>
	<cfset application.eventYear = this.eventYear>

</cffunction>


<cffunction name="setupRequest">
	<cfif this.debugdump EQ true>
		<cfsetting showdebugoutput="true"> <!--- --->
	</cfif>

</cffunction>

</cfcomponent>
