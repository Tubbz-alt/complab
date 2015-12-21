<?php ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
	<title>music_app</title>    
	<link rel="stylesheet" type="text/css" href="style.css" />
</head>

<body>
	<!-- <div id="header"><h1>Product recommendation and customer analysis</h1></div> -->
	<div id="header"><h1>Understanding the evolution of Music</h1></div>

	<div id="menu">
		<a id="home_link" href="index.php" onclick="show_content('home'); return false;">Home</a> &middot;
		<a id="data_link" href="data.php" onclick="show_content('data'); update_data_charts(); return false;">Data</a> &middot;
		<a id="analysis_link" href="analytics.php" class="active" onclick="show_content('analysis'); return false;">Analytics</a> 
	</div>

	<div id="main">

<?php

	include 'functions.php';
	$GLOBALS['graphid'] = 0;

	// Load libraries
	document_header();

	// Create connection
	$link = connect_to_db();
?>

	<div id="analysis">
	<h2>Analysis</h2>
	
	<p>Below we show the top 20 product recommendation rules identified by the <b>Apriori algorithm</b>. The table can be read as follows: for each rule, the left-hand side shows a potential basket that the customer has put together, while the right-hand side shows the additional product that could be purchased to "complete that basket".</p>

	<p>For example, the first rule indicates that a customer that has already added dried applies and sild (herring) to her basket, would be recommended gorgonzola cheese <em>(note: it sounds disgusting but the customer is always right!)</em> The recommendations are based on the analysis of historical transaction already stored in the database.</p>
			
<?php

	$query = "SELECT * FROM ecommerce.apriori";
	$title = "Recommendation rules";
	query_and_print_table($query,$title);
	echo "";
?>

	<p>We build a log-log linear regression model of the revenues per product using the quantity purchased by the different customers as explanatory factors. We consider each different product as a new observation of the revenue generated. Other explanatory factors have been considered such as the price of the product, the quantity per product, the average expenses, or the mean product price. However, the quantity of each product purchased by the different customers gave the best interpretability of the results and provides the best matching to the recommendation system. Since most of the customers only bought a small fraction of the products our data matrix is sparse. We use the Lasso regression since it is optimal for sparse data, but also because it allows us to focus on the most relevant customers.</p>

	<p>The table below shows the coefficients of the LASSO Regression. We have used the results of this regression to rank customers according to their <b>percentage monetary contribution</b> to total revenues from buying an additional 1% of products. We believe that this analysis would help the sales team in two aspects:</p>

		<ul style="list-style-type:circle">

  			<li> Identify the most promising customers for their marketing activities to target. The customers with larger percentage monetary contribution are the most susceptible to increase their expenses either by increasing the quantity of the products they usually have in the basket or by purchasing products they have not tried yet. <a href="http://80y.mjt.lu/nl/80y/s6gjl.html#" target="_blank">(...and they may be amenable to suggestions like these...)</a></li>

			<li> Relax the potentially over-estimation of certain clients. For example, the client SAVEA is the client that generated more revenue for the firm <em>(see plot "Customers by Revenue")</em> up to now. However, according to the results of the LASSO analysis, it is not the client that will increase the most the firm's marginal revenue when buying "an average product". We strongly suggest doing this exercise (the LASSO Regression) before every new marketing campaign, to update the ranking of the "most interesting revenue generating customers"</li>
		
		</ul>

<?php

	$query = "SELECT * FROM ecommerce.top_customers";
	$title = "Top customers by marginal revenue contribution";
	query_and_print_table($query,$title);
	echo "";
?>

		</div>
<?php
	// Close connection
	mysql_close($link);
?>

  </div>

</body>
