<cfoutput>
<cfset rc.pagetitle = "Sign In" />	<!--- set a variable to be used in a layout --->

<h2>#rc.pagetitle#</h2>


<cfif StructKeyExists(client,'judgename') and Len(client.judgename)>
	<div>
		Current user: #client.judgename#
		<br /><br />
	</div>
</cfif>

<div>
<form action="#BuildURL('main.login')#" method="post">
If this is not you, please enter your lastname and first initial:<br />

<input type="text" id="lastnameFI" name="lastnameFI" value="" placeholder="Lastname FI">
<input type="submit" id="savename" value="Save" name="submit">
</form>
</div>


</cfoutput>
