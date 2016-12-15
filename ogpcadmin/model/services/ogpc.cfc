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


	<!--- *** getComments(TeamID,CategoryID) returns any judge comments --->
	<cffunction name="getComments" returntype="query">
		<cfargument name="teamId" required="true">
		<cfargument name="catId" required="true">

		<cfquery name="get_comments" datasource="#application.dsn#">
		SELECT ID, OGPC_CATEGORY_ID, COMMENT_TXT
		FROM OGPC_TEAM_CATEGORY_COMMENT CC
		WHERE CC.OGPC_TEAM_ID = #arguments.teamId#
		  AND CC.OGPC_CATEGORY_ID = #arguments.catId#
		</cfquery>

		<cfreturn get_comments>
	</cffunction>


	<!--- *** getTeamAchievements(TeamID,CategoryID) --->
	<cffunction name="getTeamAchievements">
		<cfargument name="teamId" required="true">
		<cfargument name="catId" required="true">

		<cfquery name="get_scores" datasource="#application.dsn#">
		SELECT ACH.ID,ACH.POINT_VALUE,ACH.CATEGORY_ID
		      ,IF( (SELECT TA.OGPC_ACHIEVEMENT_ID
		            FROM OGPC_TEAM_ACHIEVEMENTS TA
		            WHERE TA.OGPC_ACHIEVEMENT_ID = ACH.ID
		              AND TA.OGPC_TEAM_ID = #arguments.teamId#
		            ) IS NOT NULL, 'X','')
		       EARNED_ACHIEVEMENT
		FROM OGPC_ACHIEVEMENTS ACH
		WHERE ACH.CATEGORY_ID = #arguments.catId#
		ORDER BY ACH.ID ASC
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








