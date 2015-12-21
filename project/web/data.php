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
		<a id="data_link" href="data.php" class="active" onclick="show_content('data'); update_data_charts(); return false;">Data</a> &middot;
		<a id="analysis_link" href="analytics.php" onclick="show_content('analysis'); return false;">Analytics</a> 
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
	<div id="data">
	
	<h2>Data</h2>
	
	<p>In this section we carry out an initial analysis of past transactions, with the objective of gathering information about the categories, products and customers that tend to generate the highest revenues. The results shown in this page can provide insights to inform the activities of the sales team. This information, together with the recommendation system and customer analysis which we have implemented in the next page, can support the activities of the company's marketing team.</p>
	
	<p> The chart below shows the best selling products ranked according to the revenues they generate. Only the top 10 best selling products are shown.</p>

<?php
    // Total Revenue by product
    
    $query = "SELECT genre_category, COUNT(*) FROM omsong.song_genre_decade WHERE genre_category IS NOT NULL GROUP BY genre_category;";
    $title = "Distribution of songs by classified genre";
    query_and_print_graph($query,$title, "Total");
?>
	
	<p>The chart below shows the results of a similar analysis, this time to rank the customers that contribute the most to total revenues. Only the top 20 customers are shown below.</p>
	
<?php
	// Page body. Write here your queries
	
	$query = "SELECT decade, COUNT(*) FROM omsong.song_genre_decade WHERE decade IS NOT NULL GROUP BY decade;";
	$title = "Distribution of songs by decade;";
	query_and_print_graph($query,$title,"Euros");
?>

	<p>Once we have identified the best selling products and the top customers, we seek to improve our understanding of the relationships between them.</p>
	
	<p> We start from considering associations between product categories as observed in past transactions. Specifically, the chart below shown the links between pairs of categories according to the number of times they are bought together. The thicker the network edge connecting two categories, the more often those two categories are found together in the customers' baskets. The size of the circles is proportional to the total revenues that each product categories generates.</p>
	
	<center><img src="point_map.png" style="width: 80%"></center>

	<p>The information provided in the network graph above could be used to informed marketing campaigns that cover two or more product categories, so that the marketing team could deploy offers for products that belong to categories that "go together".
	
	<p> We then go one layer further to look at the associations between products. The following table shows a ranking of pairs of products that tend to be purchased together. The pairs of products are ranked according to the number of times each pair appears in a transaction. To focus on the most relevant information, we show only the product pairs that appear at least five times. While this information does not, on its own, provide a fully-fledge recommendation system, it can provide insight on customers behaviour that can be used in setting up marketing campaigns.</p>
	
<?php

	// Most sold product pairs
	
	$query = "SELECT country, fifties, sixties, seventies, eighties, nineties, two_thousands, twenty_tens FROM omsong.world_production ORDER BY rank LIMIT 10;";
	query_and_print_table($query, $title);
?>
	<p> In the next tab, we take this analysis further by implementing a product recommendation system and by looking at customers marginal contribution to revenues using a LASSO regression.</p>

  <form name="search" method="POST" action="data.php" align = "center">

    <select name="song_id">
      <option value="">--Select Song--</option>
      <?php
      $sql=mysql_query("SELECT * FROM omsong.song_metadata ORDER BY artist_name;");
      while($row=mysql_fetch_array($sql)) {
        echo '<option value="'.$row['song_id'].'">'.$row['artist_title'].'</option>';
      }
      ?>
    </select>
    <input type="submit" name="submit" value="Apply">
  </form>
  
  <?php
    
    if (isset($_POST['submit'])) {

      $query3="SELECT artist_title FROM omsong.song_metadata WHERE song_id = ";
      $query3 .= "'".$_POST['song_id']."';";
      $sql2=mysql_query($query3);
      $sql3=mysql_fetch_array($sql2);

      $title2 = "Recommended results:";
      $title2 .= " ".$sql3['artist_title'];
      //$title2 .= " ".$_POST['artist_title']."blabla";
      $query2 = "SELECT rank, recom_artist_name, recom_title, recom_release_name FROM omsong.results_recommender WHERE song_id = ";
      $query2 .= "'".$_POST['song_id']."' ORDER BY rank;";

      query_and_print_table($query2,$title2);
      
    } 
  
  ?>

	</div>
	
  </div>

</body>
