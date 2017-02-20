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

		<cfset rc.teams = variables.ogpcService.getTeams()>

	</cffunction>


	<!--- *** reports(rc) --->
	<cffunction name="teamScore" access="public">
		<cfargument name="rc" required="true">

		<cfset var earnedPoints = 0>
		<cfset var zeroPointCount = 0>
		<cfset rc.grandTotal = 0>

		<cfset rc.results = structNew()>
		<cfset rc.categories = variables.ogpcService.getCategories()>
		<cfset rc.team = variables.ogpcService.getTeams(rc.teamID)>

		<cfloop query="rc.categories">
			<cfset rc.results[rc.categories.DESCR] = variables.ogpcService.getTeamAchievements(rc.teamID,rc.categories.ID)>
			<cfset rc.COMMENTS[rc.categories.ID] = variables.ogpcService.getComments(rc.teamID,rc.categories.ID)>
		</cfloop>

		<!--- Calculate points. this is actually the same as the display loop --->
		<cfloop from="1" to="#rc.categories.recordCount#" index="categoryRow">
			<cfset earnedPoints = 0>
			<cfset zeroPointCount = 0>
			<cfloop from="1" to="#rc.results[rc.categories.DESCR].recordCount#" index="resultRow">
				<cfif rc.results[rc.categories.DESCR[categoryRow]].EARNED_ACHIEVEMENT[resultRow] EQ 'X'>
					<cfset earnedPoints += rc.results[rc.categories.DESCR[categoryRow]].POINT_VALUE[resultRow]>
					<cfif rc.results[rc.categories.DESCR[categoryRow]].POINT_VALUE[resultRow] EQ 0>
						<cfset zeroPointCount += 1>
					</cfif>
				</cfif>
			</cfloop>

			<cfset rc.categoryAchievementScore[categoryRow] = earnedPoints>
			<cfset rc.categoryBonusCount[categoryRow] = zeroPointCount>
			<cfset rc.categoryTotalScore[categoryRow] = variables.ogpcService.BonusCalc(zeroPointCount) + earnedPoints>
			<cfset rc.grandTotal += rc.categoryTotalScore[categoryRow]>
		</cfloop>


	</cffunction>


		<!--- *** reports(rc) --->
	<cffunction name="reports" access="public">
		<cfargument name="rc" required="true">

		<cfset var currentTeam = 1>
		<cfset rc.scores = variables.ogpcService.getReport()>
		<cfset rc.teams = variables.ogpcService.getTeams()>
		<cfset rc.categories = variables.ogpcService.getCategories()>
		<cfset rc.teamCategories = structNew()>
		<cfset rc.teamResult = structNew()>
		<cfset rc.teamResult[1].ID = rc.scores.team_ID[1]>
		<cfset rc.teamResult[1].name = rc.scores.NAME[1]>
		<cfset rc.teamResult[1].points = 0>
		<cfset rc.teamResult[1].zeroCount = 0>
		<cfset rc.teamResult[1].totalScore = 0>

		<cfloop from="1" to="#rc.scores.recordCount#" index="curRow">
			<cfif rc.teamResult[currentTeam].ID NEQ rc.scores.team_ID[curRow]>
				<cfset currentTeam += 1>
				<cfset rc.teamResult[currentTeam].ID = rc.scores.team_ID[curRow]>
				<cfset rc.teamResult[currentTeam].name = rc.scores.NAME[curRow]>
				<cfset rc.teamResult[currentTeam].points = 0>
				<cfset rc.teamResult[currentTeam].zeroCount = 0>
				<cfset rc.teamResult[currentTeam].totalScore = 0>
			</cfif>

			<cfset rc.teamResult[currentTeam].points += rc.scores.POINT_VALUE[curRow]>
			<cfif rc.scores.POINT_VALUE[curRow] EQ 0>
				<cfset rc.teamResult[currentTeam].zeroCount += 1>
			</cfif>

		</cfloop>

		<cfloop from="1" to="#Len(rc.teamResult)#" index="curTeam">
			<cfset rc.teamResult[curTeam].totalScore = rc.teamResult[curTeam].points + variables.ogpcService.BonusCalc( rc.teamResult[curTeam].zeroCount)>
		</cfloop>

	</cffunction>


	<!--- loadSchoolsAndTeams(RawJSON) loads JSON dump from TMS --->
	<cffunction name="loadSchoolsAndTeams">
		<!--- loadSchools and loadTeams use same JSON record. --->
		<cfset var jsonResult = variables.ogpcService.getTMSRecord()>
		<cfdump var="#jsonResult#">

		<cfloop from="1" to="#ArrayLen(jsonResult)#" index="currentIndex">
			<cfset variables.ogpcService.insertSchools(jsonResult[currentIndex].schoolID,jsonResult[currentIndex].schoolName)>
		</cfloop>

		<cfset variables.ogpcService.insertTeams(jsonResult)>

	</cffunction>

</cfcomponent>














