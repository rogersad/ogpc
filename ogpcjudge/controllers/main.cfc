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


	<!--- *** enterscore(rc) --->
	<cffunction name="enterscore" access="public">
		<cfargument name="rc" required="true">

		<!--- get data to start scoring - teams and categories. --->
		<cfset rc.categories = variables.ogpcService.getCategories()>
		<cfset rc.judges = variables.ogpcService.getJudgeTeams()>
		<cfset rc.teams = variables.ogpcService.getTeams()>

		<cfif NOT structKeyExists(client,'categoryID')>
			<cfset client.categoryID = 0>
		<cfelse>
			<!--- preload: --->
			<cfset rc.achievements = variables.ogpcService.getAchievements(client.categoryID)>
		</cfif>

	</cffunction>


	<!--- *** submitscore(rc) --->
	<cffunction name="submitscore" access="public">
		<cfargument name="rc" required="true">

		<cfset var result.returnCode = 0>

		<!--- save team, achievement scores --->
		<cfloop list="#rc.score#" index="listDex">
			<cfset result = variables.ogpcService.saveScore(rc.teamID,listDex)>
			<cfif result.returnCode>
				<cfset rc.errorMessage = 'There was an error. Please re-enter the score.'>
				<cfset rc.errorMessage &= '<br />DO NOT USE THE BACK BUTTON.<br /> Please use the link below.'>
				 <cfset variables.fw.setview("main.error")>
				 <cfbreak>
			</cfif>
		</cfloop>

		<!--- saveComment(catID,teamID,text) --->
		<cfif result.returnCode>
			<!--- will get re-routed to error --->
		<cfelse>
			<cfset result = variables.ogpcService.saveComment(rc.teamID,rc.categoryID,rc.comments)>
		</cfif>

		<!--- judges don't change categories, so this will trigger preload of cat list --->
		<cfif client.categoryID NEQ rc.categoryID>
			<cfset client.categoryID = rc.categoryID> <!--- change catid --->
		</cfif>

		<!--- get team name for nice output on confirmation page: --->
		<cfset rc.team = variables.ogpcService.getTeams(rc.teamID)>

	</cffunction>


</cfcomponent>














