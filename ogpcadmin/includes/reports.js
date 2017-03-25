$(document).ready(function(){
    $('#scoreTable').DataTable({
    	"iDisplayLength": 50
         ,"paging": false
         ,"aoColumns":[
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
/* */
$(document).ready(function(){
    $('#scoreTableM').DataTable({
        "iDisplayLength": 50
        ,"paging": false
        ,"aoColumns":[
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

$(".incomplete").css("background-color","#ffcccc").css("border","1px #ffdddd solid");
//$("#scoreTable td:even").css("background-color","#ffffcc");
$(".right").css("text-align","right");
