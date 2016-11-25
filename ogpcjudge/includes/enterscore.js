
//locks team name selection:
/* no longer used
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
*/

//click function for get achievements (getQ)
$('#getQ').click(function(){
	loadAchList($('#categoryID option:selected').val());
});

// clik function for submit
$('#btnSubmit').click(function(){
	confirmscore();
});

// AJAX load of achievemetns when getQ button is clicked.
function loadAchList(achId){
	$.post("index.cfm?action=ajax.getAchievementsJSON",{id: achId}).done(function( retArray ) {
		buildDiv(retArray);
	});	
}

// builds the page div with achievements
function buildDiv(achArray){
	var resultRow = achArray.DATA;  
	
	// clear div:
	$('#achList').html('');

	// ID,CATEGORY_ID,CHALLENGE_FLAG,DESCR,DISPLAY_ORDER_NUM,POINT_VALUE
	// rowdex is outside rows
	for(rowdex=0;rowdex<resultRow.length;rowdex++){
			createAchCheckbox(resultRow[rowdex]);
	}
}

function createAchCheckbox(rawData){
	
	// ***THESE MAY CHANGE...
	var achievementID = rawData[0];
	var achievementDescr = rawData[3];
	var theHtml = '';
	
	theHtml ='<div class="checkbox scoring" id="';
	theHtml += 'd' + achievementID + '">';
	theHtml += '<label><input type="checkbox" class="cbox" id="c' + achievementID;
	theHtml += '" onClick="highlight('+ achievementID + ')" name="score" value="';
	theHtml += achievementID + '">' + achievementDescr + '</label></div>';
	
	$('#achList').append(theHtml);
}

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


function confirmscore(){
	var theMessage = 'Do you confirm these achievements?';
	
	if(confirm(theMessage)){
		$('#frmAchievements').submit();
	}
		
}







