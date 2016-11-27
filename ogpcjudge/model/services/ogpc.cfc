<cfcomponent accessors="true">

	<!--- *** getAchievements() reinstated for preload if client.categoryID exists: --->
	<cffunction name="getAchievements">
		<cfargument name="catID" required="true">
		<cfargument name="eventYear" default="#application.eventYear#">

		<cfquery name="get_achievements" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT ID,CATEGORY_ID,CHALLENGE_FLAG,DESCR,DISPLAY_ORDER_NUM,POINT_VALUE
		FROM OGPC_ACHIEVEMENTS
		WHERE EVENT_YEAR = '#arguments.eventYear#'
		  AND VALID_FLAG = 'Y'
		  AND CATEGORY_ID = #arguments.catID#
		ORDER BY CATEGORY_ID, DISPLAY_ORDER_NUM
		</cfquery>

		<cfreturn get_achievements>
	</cffunction>


	<!--- *** getAchievementsJSON(categoryID) --->
	<cffunction name="getAchievementsJSON" returntype="any" returnformat="json">
		<cfargument name="catID" required="true">
		<cfargument name="eventYear" default="#application.eventYear#">

		<cfquery name="get_achievements" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT ID,CATEGORY_ID,CHALLENGE_FLAG,DESCR,DISPLAY_ORDER_NUM,POINT_VALUE
		FROM OGPC_ACHIEVEMENTS
		WHERE EVENT_YEAR = '#arguments.eventYear#'
		  AND VALID_FLAG = 'Y'
		  AND CATEGORY_ID = #arguments.catID#
		ORDER BY CATEGORY_ID, DISPLAY_ORDER_NUM
		</cfquery>

		<cfreturn get_achievements>
	</cffunction>


	<!--- *** getCategores() returns full category list --->
	<cffunction name="getCategories" returntype="query">
		<cfargument name="catID" default=0>

		<cfquery name="get_categories" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT ID, DESCR
		FROM OGPC_CATEGORIES
		WHERE VALID_FLAG = 'Y'
		  <cfif arguments.catID GT 0>
		  	AND ID = #arguments.catID#
		  </cfif>
		</cfquery>

		<cfreturn get_categories>
	</cffunction>


	<!--- *** getJudgeTeams() returns full team list --->
	<cffunction name="getJudgeTeams">

		<cfquery name="get_judge_teams" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT ID,DESCR
		FROM OGPC_JUDGE_TEAMS
		</cfquery>

		<cfreturn get_judge_teams>
	</cffunction>

	<!--- *** getTeams([teamId][,eventYear]) no params: full list --->
	<cffunction name="getTeams">
		<cfargument name="teamId" default="0">
		<cfargument name="eventYear" default="#application.eventYear#">

		<cfquery name="get_teams" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT T.ID, T.NAME, T.M_H_CODE, S.SCHOOL_NAME
		FROM OGPC_TEAMS T, OGPC_SCHOOLS S
		WHERE T.OGPC_SCHOOL_ID = S.ID
		  AND EVENT_YEAR = '#arguments.eventYear#'
		  <cfif arguments.teamID GT 0>
		  	AND T.ID = #arguments.teamID#
		  </cfif>
		ORDER BY S.SCHOOL_NAME, T.NAME
		</cfquery>

		<cfreturn get_teams>
	</cffunction>


	<!--- ***saveComment(teamID,categoryID,text)  --->
	<cffunction name="saveComment">
		<cfargument name="teamID" type="string" required="true">
		<cfargument name="catID" type="string" required="true">
		<cfargument name="commentText" type="string" required="true">

		<cfquery name="save_score" datasource="#application.dsn#">
			INSERT INTO OGPC_TEAM_CATEGORY_COMMENT
				(OGPC_TEAM_ID, 	OGPC_CATEGORY_ID, COMMENT_TXT)
			VALUES
				(#arguments.teamID#,#arguments.catID#,'#arguments.commentText#')
		</cfquery>

	</cffunction>


	<!--- ***saveScore(teamID,achievementID)  --->
	<cffunction name="saveScore" returntype="struct">
		<cfargument name="teamID" type="string" required="true">
		<cfargument name="achID" type="string" required="true">

		<cfset var rStruct = structNew()>
		<cfset rStruct.returnCode = 0>
		<cfset rStruct.returnMessage = ''>

		<!--- insert success is critical: --->
		<cftry>
			<cfquery name="save_score" datasource="#application.dsn#">
				INSERT INTO OGPC_TEAM_ACHIEVEMENTS
					(OGPC_TEAM_ID, 	OGPC_ACHIEVEMENT_ID)
				VALUES
					(#arguments.teamID#,#arguments.achID#)
			</cfquery>

			<cfcatch type="database">
				<cfset rStruct.returnMessage = cfcatch.Message>
				<cfset rStruct.returnCode = 1>
			</cfcatch>
		</cftry>

		<cfreturn rStruct>

	</cffunction>


</cfcomponent>








