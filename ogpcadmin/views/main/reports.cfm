<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>

<div class="secondary">

<table class="table" Id="scoreTable">
	<thead>
		<tr>
			<th>ID,Team</th>
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
<!--- --->
	<cfloop from="1" to="#ArrayLen(rc.grid)#" index="curGrid">
		<cfif Len(curGrid) LT 7>
			<cfset rowClass = 'red'> <cfelse> <cfset rowClass = ''>
		</cfif>
		<tr class='rowClass'>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</cfloop>
	</tbody>
</table>

<!--- --->
<script>
$(document).ready(function(){
    $('##scoreTable').DataTable();
});
</script>


<cfdump var="#rc#">



</div>
</cfoutput>
