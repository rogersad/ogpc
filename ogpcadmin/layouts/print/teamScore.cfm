<cfparam name="rc.pageTitle" default="OGPC">
<cfparam name="rc.jslist" default=''>

<cfcontent type="application/pdf">
<cfdocument format="PDF" fontembed="yes" bookmark="no" localurl="yes" >

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<cfoutput>
    <title>#rc.pageTitle#</title> <!--- set in /views/pagename.cfm --->
	</cfoutput>

	<style>
	body {
	    margin: 0;
	    padding 0 !important;
	    min-width: 768px;
	    font-size:8pt;
	    font-family:Verdana, Geneva, Arial, Helvetica, sans-serif;
	}
	h1, h2 {
	    font-size:10pt;
	}

	h3, h4 {
	    font-size:9pt;
	}

	.container {
	    width: auto;
	    min-width: 750px;
	}

	tr{
	    border-bottom:1px solid #ccc;
	}
	</style>
</head>

<body>
	<cfoutput>
		#body#   <!--- /views/pagename.cfm --->
	</cfoutput>
</body>
</html>
</cfdocument>
