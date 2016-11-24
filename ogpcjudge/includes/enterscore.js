
//locks team name selection:
function lock(){
	if ($('#locked').val() == 'true'){
		if (confirm('Unlock team list?')){
			$('#locked').val('false');
			$('#lockTeam').val('Lock').removeClass('locked').addClass('notlocked');
			$('#teamID :not(:selected)').attr('disabled',false);
		}
	}
	else {//lock the team list:
		$('#locked').val('true');
		$('#lockTeam').val('Locked').removeClass('notlocked').addClass('locked');
		$('#teamID :not(:selected)').attr('disabled','disabled');
	}
}


//click function for get achievements (getQ)
$('#getQ').click(function(){
	loadAchList($('#categoryID option:selected').val());
});

// AJAX load of achievemetns when getQ button is clicked.
function loadAchList(achId){
	//alert(id);
	$.post("index.cfm?action=ajax.getAchievementsJSON",{id: achId}).done(function( retArray ) {
		//alert( retArray.DATA );
		//alert(retArray.COLUMNS);
		buildDiv(retArray);
	});	
}

// builds the page div with achievements
function buildDiv(achArray){
	var resultRow = achArray.DATA;  //item display is rows[index][currentColumn]
	var valueCount = resultRow[0].length;
	var rMessage = '';
	//alert(resultRow);				  // all rows
	//alert(resultRow.length);        //number of questions 
	
	// ID,CATEGORY_ID,CHALLENGE_FLAG,DESCR,DISPLAY_ORDER_NUM,POINT_VALUE
	// rowdex is outside rows
	for(rowdex=0;rowdex<resultRow.length;rowdex++){
		//actual values:
		//for(value=0;value<valueCount;value++){
			//test script: row,col,value\n:
			//rMessage += rowdex + ',' + value + ',' + resultRow[rowdex][value] + '\n';
			//alert(resultRow[rowdex]);
			createAchCheckbox(resultRow[rowdex]);
		//}
		
	}
	//alert(rMessage);
}

function createAchCheckbox(rawData){
	
	var achievementID = rawData[0];
	var achievementValue = rawData[5];
	var achievementDescr = rawData[3];
	
	var theHtml ='<div class="checkbox scoring" id="';
	theHtml += 'd' + achievementID + '">';
	theHtml += '<label><input type="checkbox" id="c' + achievementID;
	theHtml += '" onClick="highlight('+ achievementID + ')" name="score" value="';
	theHtml += achievementValue + '">' + achievementDescr + '</label></div>';
	
	alert(theHtml);
	
	$('#achList').append(theHtml);
}


/*  CFLOOP VERSION:
 * 	<cfloop query="rc.achprofessional">
			d#rc.achprofessional.ID#">
			<label>
			&nbsp;
			<input type="checkbox" id="pf#rc.achprofessional.ID#" onClick="highlight(this.id)"
				name="score<!--- pf#rc.achprofessional.ID# --->" value="#rc.achprofessional.ID#">
			#DESCR#
			</label>
			</div>
		</cfloop>

 */

/* 20161123 skip this. now uses ajax. loads only one at a time.
//for category change shows/hides achievements divs
function showQ(){
	var tempName = $("#categoryID>option:selected").text();

	//hide all 'achievements' class:
	$('.achievements').hide();

	//use left 4 chars of select
	switch (tempName.substring(0,4)){
		case 'Prog':
     	   $('#programming').show();
        break;
		case 'Prof':
			$('#professional').show();
        break;
		case 'Art ':
 	       $('#assets').show();
        break;
		case 'Them':
 	       $('#theme').show();
        break;
		case 'Game':
	        $('#design').show();
        break;
	}

}
*/

function highlight(checkId){
	//checkboxes cant be styled. highlight the wrapper div:
	var dNum = "d" + checkId; //changed to send id only, div id = d+ID
	var checkboxId = "c" + checkId;
	
	if($("#"+checkboxId).prop('checked')) {
		$("#"+dNum).addClass('checkSelected');
	}
	else{
		$("#"+dNum).removeClass('checkSelected');
	}
}









