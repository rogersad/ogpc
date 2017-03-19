<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>
<cfset rc.jslist = '<script src="includes/jquery.dataTables.min.js" />'>
<cfset rc.jslist &= '<link rel="stylesheet" type="text/css" href="includes/jquery.dataTables.min.css"/>'>


<div class="secondary">

<table class="table" Id="scoreTable">
	<thead>
		<tr>
			<th>ID, Team</th>
			<th>M/H</th>
			<th>Programming</th>
			<th>Game Design</th>
			<th>Theme & Story</th>
			<th>Art & Assets</th>
			<th>Professionalism</th>
			<th>Total</th>
		</tr>
	</thead>
	<tbody>

	<cfloop from="1" to="#ArrayLen(rc.grid)#" index="curGrid">
		<!--- row total:--->
		<cfset tempTotal = 0>
		<!--- if incomplete score, highlihgt row: --->
		<cfif Len(curGrid) LT 8>
			<cfset rowClass = 'red'> <cfelse> <cfset rowClass = ''>
		</cfif>

		<tr class='#rowClass#'>

		<!--- id,name this one should always be here. --->
		<cfif StructKeyExists(rc.grid[curGrid],'teamId') AND StructKeyExists(rc.grid[curGrid],'Name')>
			<td>#rc.grid[curGrid].TEAMID#, #rc.grid[curGrid].NAME#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- m/h this one should always be here. --->
		<cfif StructKeyExists(rc.grid[curGrid],'mh')>
			<td>#rc.grid[curGrid].MH#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- cat1 (programming) --->
		<cfif StructKeyExists(rc.grid[curGrid],'cat1')>
			<cfset tempTotal += rc.grid[curGrid].cat1>
			<td class="right">#rc.grid[curGrid].cat1#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- cat2 (theme) --->
		<cfif StructKeyExists(rc.grid[curGrid],'cat2')>
			<cfset tempTotal += rc.grid[curGrid].cat2>
			<td class="right">#rc.grid[curGrid].cat2#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- cat3 (theme) --->
		<cfif StructKeyExists(rc.grid[curGrid],'cat3')>
			<cfset tempTotal += rc.grid[curGrid].cat3>
			<td class="right">#rc.grid[curGrid].cat3#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- cat4 (art) --->
		<cfif StructKeyExists(rc.grid[curGrid],'cat4')>
			<cfset tempTotal += rc.grid[curGrid].cat4>
			<td class="right">#rc.grid[curGrid].cat4#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- cat5 (professional) --->
		<cfif StructKeyExists(rc.grid[curGrid],'cat5')>
			<cfset tempTotal += rc.grid[curGrid].cat5>
			<td class="right">#rc.grid[curGrid].cat5#</td>
		<cfelse>
			<td></td>
		</cfif>

		<!--- total --->
			<td class="right">#tempTotal#</td>

		</tr>

	</cfloop>
	</tbody>
</table>

<!--- --->
<script>
$("tr:odd").css("background-color","##dddddd");

$(document).ready(function(){
    $('##scoreTable').DataTable({
        "aoColumns":[
        	{bSortable:true},
        	{bSortable:true},
        	{bSortable:true},
        	{bSortable:true},
        	{bSortable:true},
        	{bSortable:true},
        	{bSortable:true},
        	{bSortable:true}
        ]
    });
});
</script>


<cfdump var="#rc#">



</div>
</cfoutput>
