<cfcomponent accessors="true" output="false">
	<cfproperty name="ogpcService"> <!--- data access --->

	<!--- *** init(fw) --->
	<cffunction name="init" access="public">
		<cfargument name="fw" required="true">
		<cfset variables.fw = fw>
		<cfreturn this>
	</cffunction>

	<cffunction name="before">
		<cfargument name="rc" required="true">

		<!--- if name and category not set, route to login: --->
		<cfif NOT (structKeyExists(client,'judgename') AND Len(client.judgename))>
			<cfset rc.displayName = ''>
			<cfset rc.categories = variables.ogpcService.getCategories()>
			<cfset rc.currentCategory = 0>
			<cfset variables.fw.setview('main.login')>
		</cfif>

	</cffunction>

	<!--- *** default(rc) --->
	<cffunction name="default" access="public">
		<cfargument name="rc" required="true">

		<!--- home page. --->
		<cfif structKeyExists(client,'judgename') AND Len(client.judgename)>
			<cfset rc.displayName = client.judgename>
		<cfelse>
			<cfset rc.displayName = ''>
		</cfif>

		 <cfset rc.displayName = client.judgename>
	</cffunction>


	<!--- *** enterscore(rc) --->
	<cffunction name="enterscore" access="public">
		<cfargument name="rc" required="true">

		<!--- get data to start scoring - teams and categories. --->
		<cfset rc.teams = variables.ogpcService.getTeams()>
		<cfset rc.achievements = variables.ogpcService.getAchievements(client.categoryID)>
		<cfset rc.displayCategory = variables.ogpcService.getCategories(client.categoryID).DESCR>

		<cfif structKeyExists(rc,'getTeam') AND rc.getTeam GT 0>
			<cfset rc.teamAchievements = variables.ogpcService.getTeamAchievements(rc.getTeam,client.categoryID)>
		</cfif>
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

		 <cfset rc.displayName = client.judgename>
	</cffunction>


	<!--- *** savelogin(rc) --->
	<cffunction name="savelogin" access="public">
		<cfargument name="rc" required="true">

		<!--- Save judge name to client var: --->
		<cfset client.judgename = rc.lastnameFI>
		<cfset client.categoryID = rc.categoryID>
		<cfset variables.fw.setview('main.default')>

	</cffunction>


	<!--- ***reset() - deletes client vars --->
	<cffunction name="reset">
		<cfargument name="rc" required="true">

		<cfif structKeyExists(client,'judgename')>
			<cfset DeleteClientVariable('judgename')>
		</cfif>
		<cfif structKeyExists(client,'categoryID')>
			<cfset DeleteClientVariable('categoryID')>
		</cfif>

	</cffunction>


	<!--- *** submitscore(rc) --->
	<cffunction name="submitscore" access="public">
		<cfargument name="rc" required="true">

		<cfset var result.returnCode = 0>
		<cfset var tempVar = ''>
		<cfset var logText = ''>

		<cfif structKeyExists(rc,'updatedScore')>
			<cfset logText &= 'UPDATED SCORE;'>
		</cfif>

		<cfif structKeyExists(client,'JUDGENAME') and structKeyExists(client,'CATEGORYID')>
			<cfset logText &= '#client.judgename#; Team:#rc.teamId#; Cat:#client.categoryId#;'>
		</cfif>

		<!--- save checkbox scores --->
		<cfif ListLen(rc.score) GTE 1>
			<cfset logText &= ' score:#rc.score#;'>

			<cfloop list="#rc.score#" index="listDex"><!---  --->
				<cfset result = variables.ogpcService.saveScore(rc.teamID,listDex)>
				<cfif result.returnCode>
					<cfset rc.errorMessage = 'There was an error. Please re-enter the score.'>
					<cfset rc.errorMessage &= '<br />DO NOT USE THE BACK BUTTON.<br /> Please use the link below.'>
					 <cfset variables.fw.setview("main.error")>
					 <cfbreak>
				</cfif>
			</cfloop>
		</cfif>

		<!--- save radio scores. a bit different. need to create dynamic var and then evaluate it  --->
		<cfloop collection="#rc#" item="currentValue">

			<cfif (Left(currentValue,5) EQ 'score') AND Len(currentValue) GT 5> <!--- like 'score95' but NOT 'score' --->

				<cfset tempVar = rc[currentValue]>
				<cfset result = variables.ogpcService.saveScore(rc.teamID,'#tempVar#')> <!--- de-reference tempVar --->

				<cfset logText &= ' radio: #tempVar#;'>

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

		<!--- categoryID was moved to login --->
		<!--- get team name for nice output on confirmation page: --->
		<cfset rc.team = variables.ogpcService.getTeams(rc.teamID)>

		<!--- save log: --->
		<cfset variables.ogpcService.loggit(logText)>
	</cffunction>


	<!--- updatescore(teamID,catID) reloads prior scores based on team, category --->
	<cffunction name="updatescore">
		<cfargument name="rc" required="true">

		<cfset var teamAchievements = variables.ogpcService.getTeamAchievements(rc.updateTeamID,rc.updateCatID)>
		<cfset rc.teamAchievementsList = ValueList(teamAchievements.OGPC_ACHIEVEMENT_ID)>

		<cfset rc.achievements = variables.ogpcService.getAchievements(rc.updateCatID)>
		<cfset rc.categories = variables.ogpcService.getCategories(rc.updateCatID)>
		<cfset rc.teams = variables.ogpcService.getTeams(rc.updateTeamID)>
		<cfset rc.teamComments = variables.ogpcService.getComments(rc.updateTeamID,rc.updateCatID)>

	</cffunction>


	<!--- updatescore(teamID,catID) deletes prior scores, re-routes to submit --->
	<cffunction name="processupdatescore">
		<cfargument name="rc" required="true">

		<!--- delete existing Achievements for this category: --->
		<cfset var teamAchievements = variables.ogpcService.getTeamAchievements(rc.teamID,rc.categoryID)>
<!--- <cfdump var="#teamAchievements#"> --->
		<cfloop query="teamAchievements">
			<cfset result = variables.ogpcService.deleteAchievements(rc.teamId,teamAchievements.OGPC_ACHIEVEMENT_ID)>
		</cfloop>

<!---
<cfset teamAchievements = variables.ogpcService.getTeamAchievements(rc.teamID,rc.categoryID)>
<cfdump var="#teamAchievements#">
<cfdump var="#rc#">
<cfabort>
 --->
		<!--- re-route updated scores to submit score: --->
		<cfset rc.updatedScore = true>
		<cfset variables.fw.redirect(action='main.submitscore',preserve='all')>
	</cffunction>

</cfcomponent>














