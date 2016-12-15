<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>
<cfset rc.jslist = '<script src="includes/enterscore.js"></script>'>
<cfset rc.jslist &= '<link rel="stylesheet" type="text/css" href="includes/jquery.dataTables.min.css"/>'>

<div class="secondary">
<cfloop from="1" to="#rc.categories.recordCount#" index="categoryRow">
	<table id='results#categoryRow#' class="display dataTable">
	<thead>
	<tr>
		<th colspan="3">#rc.categories.DESCR[categoryRow]#</th>
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
	<!--- comments
	<tr>
		<td colspan="3">#rc.COMMENTS#</td>
	</tr>
	 --->
	</tbody>
	</table>
	<script>
		$(document).ready(function(){
	    	$('##results#categoryRow#').DataTable();
		});
	</script>
</cfloop>

</div>
</cfoutput>

