<cfcomponent accessors="true">

	<!--- *** getCategores() returns full category list --->
	<cffunction name="getCategories" returntype="query">

		<cfquery name="get_categories" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT ID, DESCR
		FROM OGPC_CATEGORIES
		WHERE VALID_FLAG = 'Y'
		</cfquery>

		<cfreturn get_categories>
	</cffunction>


	<!--- *** getAchievements() --->
	<cffunction name="getAchievements">
		<cfargument name="catID" default="0">
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


	<!--- *** getScores([teamId]) no params: full list --->
	<cffunction name="getScores">
		<cfargument name="teamId" default="0">

		<cfquery name="get_scores" datasource="#application.dsn#">
		SELECT TEAM.NAME, ACH.POINT_VALUE, ACH.CATEGORY_ID
			  ,C.DESCR
		FROM OGPC_TEAMS TEAM
			,OGPC_TEAM_ACHIEVEMENTS TA
			,OGPC_ACHIEVEMENTS ACH
			,OGPC_CATEGORIES C
		WHERE TEAM.ID = TA.OGPC_TEAM_ID
		  AND ACH.ID = TA.OGPC_ACHIEVEMENT_ID
		  AND ACH.CATEGORY_ID = C.ID
		ORDER BY TEAM.NAME,C.DESCR
		</cfquery>

		<cfreturn get_scores>
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



</cfcomponent>








