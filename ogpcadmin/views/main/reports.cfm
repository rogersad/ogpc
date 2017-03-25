
<cfoutput>

<cfset rc.pageTitle = 'Team Achievement Results'>
<cfset rc.jslist = '<script language="javascript" src="includes/jquery.dataTables.min.js"></script>'>
<cfset rc.jslist &= '<script language="javascript" src="includes/reports.js"></script>'>
<cfset rc.jslist &= '<link rel="stylesheet" type="text/css" href="includes/jquery.dataTables.min.css"/>'>

<div class="secondary">
<h3>High School</h3>
<table class="table" Id="scoreTable">
	<thead>
		<tr>
			<th>ID, Team</th>
			<!--- <th>M/H</th> --->
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
		<cfif rc.grid[curGrid].MH EQ 'H'>
			<!--- row total:--->
			<cfset tempTotal = 0>
			<!--- if incomplete score, highlihgt row: --->
			<tr>

			<!--- id,name this one should always be here. --->
			<cfif StructKeyExists(rc.grid[curGrid],'teamId') AND StructKeyExists(rc.grid[curGrid],'Name')>
				<td>#rc.grid[curGrid].TEAMID#, #rc.grid[curGrid].NAME#</td>
			<cfelse>
				<td>&nbsp;</td>
			</cfif>

			<!--- m/h this one should always be here.
			<cfif StructKeyExists(rc.grid[curGrid],'mh')>
				<td>#rc.grid[curGrid].MH#</td>
			<cfelse>
				<td></td>
			</cfif>
			--->
			<!--- cat1 (programming) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat1')>
				<cfset tempTotal += rc.grid[curGrid].cat1>
				<cfset tempTotal += rc.grid[curGrid].cat1Bonus>
				<td class="right">#rc.grid[curGrid].cat1#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat2 (theme) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat2')>
				<cfset tempTotal += rc.grid[curGrid].cat2>
				<cfset tempTotal += rc.grid[curGrid].cat2Bonus>
				<td class="right">#rc.grid[curGrid].cat2#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat3 (theme) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat3')>
				<cfset tempTotal += rc.grid[curGrid].cat3>
				<cfset tempTotal += rc.grid[curGrid].cat3Bonus>
				<td class="right">#rc.grid[curGrid].cat3#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat4 (art) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat4')>
				<cfset tempTotal += rc.grid[curGrid].cat4>
				<cfset tempTotal += rc.grid[curGrid].cat4Bonus>
				<td class="right">#rc.grid[curGrid].cat4#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat5 (professional) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat5')>
				<cfset tempTotal += rc.grid[curGrid].cat5>
				<cfset tempTotal += rc.grid[curGrid].cat5Bonus>
				<td class="right">#rc.grid[curGrid].cat5#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- total --->
				<td class="right">#tempTotal#</td>

			</tr>
		</cfif>
	</cfloop>
	</tbody>
</table>


<br /><br />
<h3>Middle School</h3>

<table class="table" Id="scoreTableM">
	<thead>
		<tr>
			<th>ID, Team</th>
			<!--- <th>M/H</th> --->
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
		<cfif rc.grid[curGrid].MH EQ 'M'>
			<!--- row total:--->
			<cfset tempTotal = 0>
			<!--- if incomplete score, highlihgt row: --->
			<tr>

			<!--- id,name this one should always be here. --->
			<cfif StructKeyExists(rc.grid[curGrid],'teamId') AND StructKeyExists(rc.grid[curGrid],'Name')>
				<td>#rc.grid[curGrid].TEAMID#, #rc.grid[curGrid].NAME#</td>
			<cfelse>
				<td>&nbsp;</td>
			</cfif>

			<!--- m/h this one should always be here.
			<cfif StructKeyExists(rc.grid[curGrid],'mh')>
				<td>#rc.grid[curGrid].MH#</td>
			<cfelse>
				<td></td>
			</cfif>
			--->
			<!--- cat1 (programming) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat1')>
				<cfset tempTotal += rc.grid[curGrid].cat1>
				<cfset tempTotal += rc.grid[curGrid].cat1Bonus>
				<td class="right">#rc.grid[curGrid].cat1#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat2 (theme) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat2')>
				<cfset tempTotal += rc.grid[curGrid].cat2>
				<cfset tempTotal += rc.grid[curGrid].cat2Bonus>
				<td class="right">#rc.grid[curGrid].cat2#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat3 (theme) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat3')>
				<cfset tempTotal += rc.grid[curGrid].cat3>
				<cfset tempTotal += rc.grid[curGrid].cat3Bonus>
				<td class="right">#rc.grid[curGrid].cat3#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat4 (art) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat4')>
				<cfset tempTotal += rc.grid[curGrid].cat4>
				<cfset tempTotal += rc.grid[curGrid].cat4Bonus>
				<td class="right">#rc.grid[curGrid].cat4#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- cat5 (professional) --->
			<cfif StructKeyExists(rc.grid[curGrid],'cat5')>
				<cfset tempTotal += rc.grid[curGrid].cat5>
				<cfset tempTotal += rc.grid[curGrid].cat5Bonus>
				<td class="right">#rc.grid[curGrid].cat5#</td>
			<cfelse>
				<td class="incomplete"></td>
			</cfif>

			<!--- total --->
				<td class="right">#tempTotal#</td>

			</tr>
		</cfif>
	</cfloop>
	</tbody>
</table>
<br /><br />
</div>
</cfoutput>

<!--- <cfdump var="#rc#"> --->
