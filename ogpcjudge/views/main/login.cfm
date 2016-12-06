<cfoutput>
<cfset rc.pagetitle = "Sign In" />
<cfset rc.jslist = '<script src="includes/login.js"></script>'> <!--- --->

<h2>#rc.pagetitle#</h2>


<div>
	<cfif structKeyExists(client,'judgename')>
		Current user: #client.judgename#
		<br /><br />
		If this is not you, please enter your lastname and first initial:
	<cfelse>
		Please sign in.
	</cfif>
	<br /><br />
</div>

<div>
	<form action="#BuildURL('main.savelogin')#" method="post" onsubmit="return validate();">
	<div class="form-group">
	<label>Last name and first initial:<br />
	<input type="text" id="lastnameFI" name="lastnameFI" value="#rc.displayName#" placeholder="LastnameI">
	<label>
	</div>

	<div class="form-group">
	<label>Select Category:
	<select class="form-control" name="categoryID" id="categoryID">
		<option>Select...</option>
		<cfloop query="rc.categories">
			<cfset selected = ''>
			<cfif rc.categories.ID EQ rc.currentCategory>
				<cfset selected = 'selected'>
			</cfif>
			<option #selected# value="#rc.categories.ID#">#rc.categories.DESCR#</option>
		</cfloop>
	</select>
	</label>
	&nbsp;
	</div>
	<div class="form-group">
		<input type="submit" id="save" value="Save" name="submit">
	</div>
</form>
</div>


</cfoutput>
