<cfcomponent extends="framework.one" output="false">

<cfset this.name = "ogpc_admin_app">
<cfset this.sessionManagement = true>
<cfset this.sessionTimeout = createTimeSpan(1,0,0,0)>
<cfset this.clientManagement = true>
<cfset this.setClientCookies = true>
<cfset this.dataSource = "ideaslide">

<!--- OGPC SPECIFIC: --->
<cfset this.eventYear = '2017'>
<!--- -------------- --->

<!--- framework settings --->
<!--- *** CHANGE THESE TO 'FALSE' FOR PRODUCTION: *** --->
<cfset framework.reloadApplicationOnEveryRequest = false>
<cfset framework.trace = false>
<!--- *** *** *** *** *** *** *** *** --->

<!--- these stay the same:
<cfset framework.sesOmitIndex = true>
<cfset framework.generateSES = false>
  --->
<!--- end framework settings --->


<cffunction name="setupApplication">
    <!--- // copy to variables scope --->
    <cfset application.dsn = this.datasource>
	<cfset application.eventYear = this.eventYear>

</cffunction>


</cfcomponent>
