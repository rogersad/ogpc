
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

// moved ajax load to select.change
$( "#categoryID" ).change(function() {
  loadAchList($('#categoryID option:selected').val());
});

// clik function for submit
$('#btnSubmit').click(function(){
	confirmscore();
});

// AJAX load of achievemetns when getQ button is clicked.
function loadAchList(achId){
	alert(achId);
	$.post("index.cfm?action=ajax.getAchievementsJSON",{id: achId}).done(function( retArray ) {
		//alert(retArray);
		buildDiv(retArray);
	});	
}

// builds the page div with achievements
/**/
function buildDiv(achArray){
	var resultRow = achArray.DATA;  
	var radioActive = false;
	
	// clear div:
	$('#achList').html('');


}
function zzz(){	
	
	
	// ID,CATEGORY_ID,CHALLENGE_FLAG,DESCR,DISPLAY_ORDER_NUM,POINT_VALUE
	// rowdex is outside rows
	for(rowdex=0;rowdex<resultRow.length;rowdex++){
		if(rawData[6] =='Y'){
			//create radio set
			radioActive = true;
			startAchDiv(rawData);
			createAchRadio(rawData);
		}
		else if (rawData[7] > 0){
			createAchRadio(rawData);
		}
		else {
			if(radioActive){
				closeAchDiv();
				radioActive = false;
			}
			createAchCheckbox(resultRow[rowdex]);
		}
			
	}
}

function startAchDiv(rawData){
	var achievementID = rawData[0];
	
	theHtml ='<div class="checkbox scoring" id="';
	theHtml += 'd' + achievementID + '">';
	$('#achList').append(theHtml);
}

function closeAchDiv(){
	$('#achList').append('</div>');
}

function createAchCheckbox(rawData){
	
	// ***THESE MAY CHANGE...
	var achievementID = rawData[0];
	var achievementDescr = rawData[3];
	var theHtml = '';
	
	startAchDiv(rawData);
	
	theHtml += '<label><input type="checkbox" class="cbox" id="c' + achievementID;
	theHtml += '" onClick="highlight('+ achievementID + ')" name="score" value="';
	theHtml += achievementID + '">' + achievementDescr + '</label></div>';
	
	$('#achList').append(theHtml);
}

function createAchRadio(rawData){
	
	// ***THESE MAY CHANGE...
	var achievementID = rawData[0];
	var achievementDescr = rawData[3];
	var theHtml = '';
	
	startAchDiv(rawData);
	
	theHtml += '<label><input type="radio" class="cbox" id="c' + achievementID;
	theHtml += '" onClick="highlight('+ achievementID + ')";
	//radio differs here:
	theHtml +=  'name="score' + achievementID +" value="';
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



