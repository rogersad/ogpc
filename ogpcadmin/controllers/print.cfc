<cfcomponent accessors="true" output="false">
	<cfproperty name="ogpcService"> <!--- data access --->

	<!--- *** init(fw) --->
	<cffunction name="init" access="public">
		<cfargument name="fw" required="true">
		<cfset variables.fw = fw>
		<cfreturn this>
	</cffunction>


	<!--- *** printTeamScore(rc) --->
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

</cfcomponent>

