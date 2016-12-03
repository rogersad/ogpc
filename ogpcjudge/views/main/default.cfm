<cfoutput>
<cfset rc.pagetitle = "Judging Home" />	<!--- set a variable to be used in a layout --->

<h2>OGPC Judging</h2>


<cfif StructKeyExists(client,'judgename') and Len(client.judgename)>
	<div>Welcome #client.judgename#</div>
	<div>
		<h3><a href="#BuildURL('main.enterscore')#">Score Achievements</a></h3><br /> <!--- --->
		<!--- <a href="#BuildURL('main.enterscore')#">Start scoring</a><br />  --->
	</div>
</cfif>


</cfoutput>
