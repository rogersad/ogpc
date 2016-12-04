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
		<!--- home page. --->

	</cffunction>


	<!--- *** enterscore(rc) --->
	<cffunction name="enterscore" access="public">
		<cfargument name="rc" required="true">

		<!--- get data to start scoring - teams and categories. --->
		<cfset rc.teams = variables.ogpcService.getTeams()>
		<cfset rc.achievements = variables.ogpcService.getAchievements(client.categoryID)>
		<cfset rc.displayCategory = variables.ogpcService.getCategories(client.categoryID).DESCR>

	</cffunction>


	<!--- *** login(rc) --->
	<cffunction name="login" access="public">
		<cfargument name="rc" required="true">

		<!--- load category list: --->
		<cfset rc.categories = variables.ogpcService.getCategories()>

		<!--- set category var for display: --->
		<cfif structKeyExists(client,'categoryID')>
			<cfset rc.currentCategory = client.categoryID>
		<cfelse>
			<cfset rc.currentCategory = 0>
		</cfif>

		<!--- show judge name (or not): --->
		<cfif structKeyExists(client,'judgename') AND Len(client.judgename)>
			<cfset rc.displayName = client.judgename>
		<cfelse>
			<cfset rc.displayName = ''>
		</cfif>

	</cffunction>


	<!--- *** savelogin(rc) --->
	<cffunction name="savelogin" access="public">
		<cfargument name="rc" required="true">

		<!--- Save judge name to client var: --->
		<cfset client.judgename = rc.lastnameFI>
		<cfset client.categoryID = rc.categoryID>

		<cfset variables.fw.setview('main.default')>

	</cffunction>




	<!--- ***reset() - deletes judge name --->
	<cffunction name="reset">
		<cfargument name="rc" required="true">

		<cfif structKeyExists(client,'judgename')>
			<cfset DeleteClientVariable('judgename')>
		</cfif>

	</cffunction>


	<!--- *** submitscore(rc) --->
	<cffunction name="submitscore" access="public">
		<cfargument name="rc" required="true">

		<cfset var result.returnCode = 0>
		<cfset var tempVar = ''>

		<!--- save checkbox scores --->
		<cfloop list="#rc.score#" index="listDex"><!---  --->
			<cfset result = variables.ogpcService.saveScore(rc.teamID,listDex)>
			<cfif result.returnCode>
				<cfset rc.errorMessage = 'There was an error. Please re-enter the score.'>
				<cfset rc.errorMessage &= '<br />DO NOT USE THE BACK BUTTON.<br /> Please use the link below.'>
				 <cfset variables.fw.setview("main.error")>
				 <cfbreak>
			</cfif>
		</cfloop>

		<!--- save radio scores. a bit different. need to create dynamic var and then evaluate it  --->
		<cfloop collection="#rc#" item="currentValue">

			<cfif (Left(currentValue,5) EQ 'score') AND Len(currentValue) GT 5> <!--- like 'score95' but NOT 'score' --->

				<cfset tempVar = rc[currentValue]>
				<cfset result = variables.ogpcService.saveScore(rc.teamID,'#tempVar#')> <!--- de-reference tempVar --->

				<cfif result.returnCode>
					<cfset rc.errorMessage = 'There was an error. Please re-enter the score.'>
					<cfset rc.errorMessage &= '<br />DO NOT USE THE BACK BUTTON.<br /> Please use the link below.'>
					 <cfset variables.fw.setview("main.error")>
					 <cfbreak>
				</cfif>
			</cfif>
		</cfloop>

		<!--- saveComment(catID,teamID,text) --->
		<cfif Len(Trim(rc.comments))>
			<cfset rc.comments &= ' -#client.judgename#'>
			<cfset result = variables.ogpcService.saveComment(rc.teamID,rc.categoryID,rc.comments)>
		</cfif>

		<!--- judges don't usually change categories, so this will trigger preload of cat list --->
		<cfif NOT StructKeyExists(client,'categoryID')>
			<cfset client.categoryID = rc.categoryID>
		<cfelseif client.categoryID NEQ rc.categoryID>
			<cfset client.categoryID = rc.categoryID>
		</cfif>

		<!--- get team name for nice output on confirmation page: --->
		<cfset rc.team = variables.ogpcService.getTeams(rc.teamID)>

	</cffunction>


	<!--- updatescore(teamID,catID) reloads prior scores based on team, category --->
	<cffunction name="updatescore">
		<cfargument name="rc" required="true">

		<cfset rc.categories = variables.ogpcService.getCategories(rc.catID)>
		<cfset rc.teams = variables.ogpcService.getTeams(rc.teamID)>
		<cfset rc.achievements = variables.ogpcService.getAchievements(rc.catID)>

	</cffunction>

</cfcomponent>














