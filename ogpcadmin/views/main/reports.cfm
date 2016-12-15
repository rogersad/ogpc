<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>

<div class="secondary">
<cfloop from="1" to="#rc.categories.recordCount#" index="categoryRow">
	<table id='results#categoryRow#' class="table dataTable">
	<thead>
	<tr>
		<th colspan="3"><h4>#Ucase(rc.categories.DESCR[categoryRow])#</h4></th>
	</tr>
	<tr>
		<th>RESULT</th>
		<th>POINTS</th>
		<th>ACHIEVEMENT</th>
	</tr>
	</thead>
	<tbody>
	<!--- ID POINT_VALUE CATEGORY_ID EARNED_ACHIEVEMENT RC.COMMENTS[CATEGORY_ID]--->
	<!--- <cfloop from="1" to="#rc.results[rc.categories.DESCR].recordCount#" index="resultsRow"> --->
	<cfloop from="1" to="#rc.results[rc.categories.DESCR].recordCount#" index="resultRow">
		<tr>
			<td>#rc.results[rc.categories.DESCR[categoryRow]].EARNED_ACHIEVEMENT[resultRow]#</td>
			<td>#rc.results[rc.categories.DESCR[categoryRow]].POINT_VALUE[resultRow]#</td>
			<td>#rc.results[rc.categories.DESCR[categoryRow]].DESCR[resultRow]#</td>
		</tr>
	</cfloop>
	<!--- comments --->
	<cfif rc.COMMENTS[categoryRow].COMMENT_TXT NEQ ''>
		<tr>
			<td colspan="3">#rc.COMMENTS[categoryRow].COMMENT_TXT#</td>
		</tr>
	</cfif>

	</tbody>
	</table>
	<hr />
</cfloop>


</div>
</cfoutput>

