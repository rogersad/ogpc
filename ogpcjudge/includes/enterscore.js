

// moved ajax load to select.change only necessary first time.
$( "#categoryID" ).change(function() {
  loadAchList($('#categoryID option:selected').val());
});

// clik function for submit
$('#btnSubmit').click(function(){
	confirmscore();
});

//add warning if team + category already scored (change func for both teamID,categoryID):
/* */
$("#teamID").change(function() {
	var teamId = $("#teamID option:selected").val();
	var catId = $("#categoryID option:selected").val();
	
	if(teamId > 0 && catId > 0) {
		$.post("index.cfm?action=ajax.getScoresJSON",{teamID: teamId, categoryID:catId}).done(function(rdata) {
			showScoringError(rdata);
		});
	}
});

$("#categoryID").change(function() {
	var teamId = $("#teamID option:selected").val();
	var catId = $("#categoryID option:selected").val();
	
	if(teamId > 0 && catId > 0) {
		$.post("index.cfm?action=ajax.getScoresJSON",{teamID: teamId, categoryID:catId}).done(function(rdata) {
			showScoringError(rdata);
		});
	}
});

//DATA will be number of rows in achievements table for selected team + category
function showScoringError(rdata){
	var rowCount = rdata.DATA;  

	if(rowCount > 0){
		var warningText = 'WARNING! This team has already been scored for this category.<br />';
		/*
		warningText += '<div id="update" class="form-group"><label class="inline">';
		warningText += '<input id="reloadPrior" type="button" class="btn btn-default"';
		warningText += 'onClick="copyTC();submitUpdate();" value="Update Existing Score" /></label></div>';
		*/	
		$("#warning").html(warningText);
		$("#warning").addClass('show');
	}
	else { // all good, hide.
		$("#warning").removeClass('show');
	}
}


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
	
	//for reset
	if(checkId == 0){ 
		$('div').removeClass('checkSelected');
	}
	else if ($("#"+checkboxId).prop('checked')) {
		$("#"+dNum).addClass('checkSelected');
	}
	else{
		$("#"+dNum).removeClass('checkSelected');
	}
	
}

//created separate function. needed elsewhere also
function teamNotZero(){
	var team = $('#teamID option:selected').val();
	if (team <= 0){
		alert("Team must be selected.");
		return false;
	}
	else return true;
}

// for main enter score page
function confirmscore(){
	var theMessage = 'Confirm achievements for \n\n';
	theMessage += $('#teamID option:selected').text();
	
	if (teamNotZero()){
		if(confirm(theMessage)){
			$('#frmAchievements').submit();
		}
	}
		
}

// for update prior score (called from enterscore)
function copyTC(){
	$('#updateTeamID').val($('#teamID option:selected').val());
	$('#updateCatID').val($('#categoryID option:selected').val());
}

function submitUpdate(){
	$('#frmUpdate').submit();
}



