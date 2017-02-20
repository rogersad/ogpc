<cfcomponent accessors="true">

	<!--- *** BonusCalc(count) --->
	<!--- first Challenge is worth 4 points. The second is worth 3, then 2, then 1, then 1. --->

	<cffunction name="BonusCalc" access="public" returntype="numeric">
		<cfargument name="calc_value" required="Yes" type="numeric">
		<cfset rValue = 0>
		<cfswitch expression="#arguments.calc_value#">
			<cfcase value="5">
				<cfset rValue = 11>
			</cfcase>
			<cfcase value="4">
				<cfset rValue = 10>
			</cfcase>
			<cfcase value="3">
				<cfset rValue = 9>
			</cfcase>
			<cfcase value="2">
				<cfset rValue = 7>
			</cfcase>
			<cfcase value="1">
				<cfset rValue = 4>
			</cfcase>
		</cfswitch>
		<cfreturn rValue>
	</cffunction>

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
		SELECT ACH.ID,ACH.POINT_VALUE,ACH.CATEGORY_ID, ACH.DESCR
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

	<!--- *** getReport()  --->

	<cffunction name="getReport">
		<cfquery name="get_report" datasource="#application.dsn#">
		SELECT T.ID TEAM_ID, T.NAME, T.M_H_CODE
				,S.SCHOOL_NAME
				,ACH.ID ACHIEVEMENT_ID, ACH.POINT_VALUE
				,TA.OGPC_ACHIEVEMENT_ID TA_ACH_ID
				,C.DESCR CATEGORY_DESCR, C.ID CATEGORY_ID
		FROM OGPC_TEAMS T, OGPC_SCHOOLS S
		     ,OGPC_TEAM_ACHIEVEMENTS TA
		     ,OGPC_ACHIEVEMENTS ACH
		     ,OGPC_CATEGORIES C
		WHERE T.OGPC_SCHOOL_ID = S.ID
		  AND TA.OGPC_ACHIEVEMENT_ID = ACH.ID
		  AND T.ID = TA.OGPC_TEAM_ID
		  AND C.ID = ACH.CATEGORY_ID
		ORDER BY S.SCHOOL_NAME, T.NAME, C.DESCR
		</cfquery>
		<cfreturn get_report>
	</cffunction>

	<!--- getTMSRecord() calls TMS api --->

	<cffunction name="getTMSRecord">
		<!--- http://tms.ogpc.info/api/Entries/season/year/2017 --->
		<cfset var jsonRecord = ''>
		<cfhttp url="http://tms.ogpc.info/api/Entries/season/year/2017"
			method="get"
			result="tmsJSON" />
		<!--- Convert JSON to array of structs --->
		<cfset jsonRecord = deserializeJSON(tmsJSON.fileContent) />
		<cfreturn jsonRecord>
	</cffunction>

	<!--- loadSchools(RawJSON) loads JSON from TMS into School Table --->

	<cffunction name="insertSchools">
		<cfargument name='tmsId' required="true">
		<cfargument name='tmsName' required="true">

		<cfquery name="insert_school" datasource="#application.dsn#">
			INSERT INTO OGPC_SCHOOLS (SCHOOL_NAME,TMS_ID)
			VALUES ('#arguments.tmsName#','#arguments.tmsId#')
		</cfquery>

	</cffunction>

	<!--- loadTeams(RawJSON) loads JSON from TMS into Team Table --->

	<cffunction name="insertTeams">
		<cfargument name='tmsId' required="true">
		<cfargument name='tmsName' required="true">
		<!--- Need to get this: --->
		<!--- teams: schoolID (FK), TeamID, TeamName, TeamMemberCount --->

		<cfquery name="insert_school" datasource="#application.dsn#">
			INSERT INTO OGPC_TEAMS (NAME,TMS_ID,OGPC_SCHOOL_ID,M_H_CODE,MEMBERS_NUM,EVENT_YEAR)
			VALUES ('#arguments.tmsName#','#arguments.tmsId#')
		</cfquery>
	</cffunction>


</cfcomponent>
