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


	<!--- *** getAchievements() ideally... turn this into ajax pull
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
 --->

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

	<!--- *** getJudgeTeams() returns full team list --->
	<cffunction name="getJudgeTeams">

		<cfquery name="get_judge_teams" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
		SELECT ID,DESCR
		FROM OGPC_JUDGE_TEAMS
		</cfquery>

		<cfreturn get_judge_teams>
	</cffunction>

	<!--- *** getTeams() returns full team list --->
	<cffunction name="getTeams">
		<cfargument name="eventYear" default="#application.eventYear#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">

		<cfquery name="get_teams" datasource="#application.dsn#">
		SELECT T.ID, T.NAME, T.M_H_CODE, S.SCHOOL_NAME
		FROM OGPC_TEAMS T, OGPC_SCHOOLS S
		WHERE T.OGPC_SCHOOL_ID = S.ID
		  AND EVENT_YEAR = '#arguments.eventYear#'
		ORDER BY S.SCHOOL_NAME, T.NAME
		</cfquery>

		<cfreturn get_teams>
	</cffunction>


	<cffunction name="saveScore">

	</cffunction>

</cfcomponent>








