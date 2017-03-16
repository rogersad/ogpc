<cfsetting showdebugoutput="true">
<cfset rc.pageTitle = 'There was an error'>

<cfoutput>
	<h2>#rc.pageTitle#!</h2>

	<!--- <cfdump var="#rc#"> --->

	<cfif structKeyExists(rc,'errorMessage') AND Len(rc.errorMessage)>
		<div class="error">
			#rc.errorMessage#
		</div>
	</cfif>

<br />


	<h3><a href="#BuildURL('main.enterscore')#&reload=true"> Score Achievements </a></h3>

	<h3><a href="#BuildURL('main.default')#?reload=true"> Home </a></h3>


</cfoutput>
