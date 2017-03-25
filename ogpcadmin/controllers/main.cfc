<cfcomponent accessors="true" output="false">
	<cfproperty name="ogpcService"> <!--- data access --->

	<!--- *** init(fw) --->
	<cffunction name="init" access="public">
		<cfargument name="fw" required="true">
		<cfset variables.fw = fw>
		<cfreturn this>
	</cffunction>


	<!--- *** default(rc) --->
	<cffunction name="default" access="public" output="false">
		<cfargument name="rc" required="true">

		<cfset rc.teams = variables.ogpcService.getTeams()>

	</cffunction>


	<!--- *** default(rc) --->
	<cffunction name="error" access="public" output="false">
		<cfargument name="rc" required="true">


	</cffunction>


	<!--- *** default(rc) --->
	<cffunction name="readlog" access="public" output="false">
		<cfargument name="rc" required="true">

		<cfset rc.log = variables.ogpcService.getLog()>

	</cffunction>



	<!--- *** teamScore(rc) creates everything for the team completed score sheets --->
	<cffunction name="teamScore" access="public" output="false">
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


	<cffunction name="reports" access="public" output="false">
		<cfargument name="rc" required="true">

		<cfset var indexArray = ArrayNew()>
		<cfset var teamIndex = 0>
		<cfset var tempBonus = 0>
		<cfset var teamList = variables.ogpcService.getTeams()>
		<cfset rc.rawScore = variables.ogpcService.getReport()>
		<cfset rc.grid = ArrayNew()>  <!--- an array of structs --->

		<cfloop from="1" to="#teamList.recordCount#" index="teamRow">
			<!--- do index: --->
			<cfset indexArray[teamRow] = teamList.ID[teamRow]>
			<!--- insert grid struct: T.ID, T.NAME, T.M_H_CODE, S.SCHOOL_NAME --->
			<cfset rc.grid[teamRow] = structNew()>
			<cfset rc.grid[teamRow].teamId = teamList.ID[teamRow]>
			<cfset rc.grid[teamRow].name = teamList.NAME[teamRow]>
			<cfset rc.grid[teamRow].mh = teamList.M_H_CODE[teamRow]>
			<cfset rc.grid[teamRow].cat1Bonus = 0>
			<cfset rc.grid[teamRow].cat2Bonus = 0>
			<cfset rc.grid[teamRow].cat3Bonus = 0>
			<cfset rc.grid[teamRow].cat4Bonus = 0>
			<cfset rc.grid[teamRow].cat5Bonus = 0>
		</cfloop>

		<cfloop from="1" to="#rc.rawScore.recordCount#" index="curRow">
			<!--- get the index of team Struct from indexArray: --->
			<cfset teamIndex = ArrayFind(indexArray,rc.rawScore.TEAM_ID[curRow])>

			<cfif rc.rawScore.POINT_VALUE[curRow] GT 0> <!--- regular scores: --->
				<cfif structKeyExists(rc.grid[teamIndex], 'cat#rc.rawScore.CATEGORY_ID[curRow]#')>
					<cfset rc.grid[teamIndex]['cat#rc.rawScore.CATEGORY_ID[curRow]#'] += rc.rawScore.POINT_VALUE[curRow]>
				<cfelse>
					<cfset rc.grid[teamIndex]['cat#rc.rawScore.CATEGORY_ID[curRow]#'] = rc.rawScore.POINT_VALUE[curRow]>
				</cfif>
			<cfelse> <!--- bonus scores --->
				<cfif structKeyExists(rc.grid[teamIndex], 'catBonus#rc.rawScore.CATEGORY_ID[curRow]#')>
					<cfset rc.grid[teamIndex]['catBonus#rc.rawScore.CATEGORY_ID[curRow]#'] += 1> <!--- bonus = count of 0 --->
				<cfelse>
					<cfset rc.grid[teamIndex]['cat#rc.rawScore.CATEGORY_ID[curRow]#'] = 1>
				</cfif>
			</cfif>
		</cfloop>

		<!--- loop again to calc bonus scores from catBonus1, catBonus2... --->
		<cfloop from="1" to="#teamList.recordCount#" index="curRow">
			<cfset tempBonus = variables.ogpcService.BonusCalc(rc.grid[curRow].cat1Bonus)>
			<cfset rc.grid[curRow].cat1Bonus = tempBonus>

			<cfset tempBonus = variables.ogpcService.BonusCalc(rc.grid[curRow].cat2Bonus)>
			<cfset rc.grid[curRow].cat2Bonus = tempBonus>

			<cfset tempBonus = variables.ogpcService.BonusCalc(rc.grid[curRow].cat3Bonus)>
			<cfset rc.grid[curRow].cat3Bonus = tempBonus>

			<cfset tempBonus = variables.ogpcService.BonusCalc(rc.grid[curRow].cat4Bonus)>
			<cfset rc.grid[curRow].cat4Bonus = tempBonus>

			<cfset tempBonus = variables.ogpcService.BonusCalc(rc.grid[curRow].cat5Bonus)>
			<cfset rc.grid[curRow].cat5Bonus = tempBonus>
		</cfloop>
	</cffunction>


	<!--- loadSchools(RawJSON) loads JSON dump from TMS --->
	<cffunction name="loadSchools" output="false">
		<cfargument name="rc" required="true">

		<cfset var schoolURL = "http://tms.ogpc.info/api/schools">
		<cfset var jsonResult = variables.ogpcService.getTMSRecord(schoolURL)>

		<cfset var argList = structNew()>

		<!--- <cfdump var="#jsonResult#"> --->
		<cfif rc.password EQ 'Omicr0n'>
			<cfloop from="1" to="#ArrayLen(jsonResult)#" index="currentIndex">
				<cfset variables.ogpcService.insertSchools(jsonResult[currentIndex].ID,jsonResult[currentIndex].Name)>
			</cfloop>
		</cfif>
		<cfset variables.fw.redirect('main.default')>
	</cffunction>


	<!--- loadTeams(RawJSON) loads JSON dump from TMS --->
	<cffunction name="loadTeams">
		<cfargument name="rc" required="true">
		<cfset var teamURL="http://tms.ogpc.info/api/Entries/season/year/2017">
		<cfset var jsonResult = variables.ogpcService.getTMSRecord(teamURL)>
		<cfset var argList = structNew()>

		<cfdump var="#jsonResult#">
		<cfif rc.password EQ 'Omicr0n'>
			<cfloop from="1" to="#ArrayLen(jsonResult)#" index="currentIndex">
			<!---
			<cfargument name='teamName' required="true">
			<cfargument name='teamTmsId' required="true">
			<cfargument name='schoolId' required="true">
			<cfargument name='membersNum' required="true">
			 --->
			 	<cfset argList.schoolId = variables.ogpcService.getSchoolFromTMSId(jsonResult[currentIndex].schoolId)>
				<cfset argList.teamTmsId = jsonResult[currentIndex].teamId>
				<cfset argList.teamName = jsonResult[currentIndex].teamName>
				<cfset argList.membersNum = jsonResult[currentIndex].teamMemberCount>
				<cfset argList.divcode = jsonResult[currentIndex].TeamDivisionId>
				<cfset variables.ogpcService.insertTeams(argList.teamName,argList.teamTmsId,argList.schoolId.ID,argList.membersNum,argList.divcode)>
			</cfloop>

		</cfif>

		<cfset variables.fw.redirect('main.default')>

	</cffunction>
</cfcomponent>














