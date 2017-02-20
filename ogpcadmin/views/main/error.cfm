<cfset rc.pageTitle = 'There was an error'>

<cfoutput>
	<h2>#rc.pageTitle#</h2>

	<cfdump var="#rc#">
	<cfdump var="#catch#">
	<cfabort>


	<cfif structKeyExists(rc,'errorMessage') AND Len(rc.errorMessage)>
		<div class="error">
			#rc.errorMessage#
		</div>
	</cfif>

<br />

	<h3><a href="#BuildURL('main.default')#"> Home </a></h3>


</cfoutput>
