<cfparam name="rc.pageTitle" default="OGPC">
<cfparam name="rc.jslist" default="">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<cfoutput>
    <title>#rc.pageTitle#</title> <!--- set in /views/pagename.cfm --->
	</cfoutput>
    <!--- Bootstrap core CSS --->
    <link href="includes/dist/css/bootstrap.css" rel="stylesheet"><!---  --->
	<!--- code removed. less than IE 9 NOT SUPPORTED.	--->
	<!--- custom styles comes last, for adding or overriding anything else --->
	<link rel="stylesheet" type="text/css" href="includes/ogpcstyle.css"/>
</head>
<!--- navbar --->
<div class="navbar navbar-default" role="navigation" style="margin-bottom:0px;">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.cfm">Home</a>
		</div> <!--- navbar header --->

		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<cfoutput>
				<li><a href="#BuildURL('main.enterscore')#">Score Achievements</a></li>
				<!--- <li>Menu item2</li> --->
				<!--- <li>Menu item3</li> --->
				</cfoutput>
			</ul>
		</div>	 <!--- navbar collapse --->
	</div> <!--- container fluid --->
</div><!--- navbar default --->
<body>
	<div class="container-fluid">
	<!--- framework stuff. just output the body variable: --->
	<cfoutput>
		#body#   <!--- /views/pagename.cfm --->
	</cfoutput>
	</div>
</body>
<head>
	<!--- Bootstrap core JavaScript
    ================================================== --->
    <script language="javascript" src="includes/dist/js/jquery-1.10.2.min.js"></script>
    <script language="javascript" src="includes/dist/js/bootstrap.min.js"></script>
    <script language="javascript" src="includes/dist/js/jquery-ui.min.js"></script>
	<!--- any custom js for a page, full tag like above. set in /views/pagename.cfm --->
	<cfoutput>#rc.jslist#</cfoutput>
</head>
</html>

