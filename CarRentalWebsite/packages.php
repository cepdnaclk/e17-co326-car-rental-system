<?php 
  
  session_start();
  $user = $_SESSION["user"] ;
  $password = $_SESSION["password"] ;
  $database = $_SESSION["database"] ;
  $servername = $_SESSION["servername"];
    
$mysqli = new mysqli($servername, $user, $password, $database); 
  
// Checking for connections 
if ($mysqli->connect_error) { 
    die('Connect Error (' .  
    $mysqli->connect_errno . ') '.  
    $mysqli->connect_error); 
} 
  
// SQL query to select data from database 
$sql = "SELECT * FROM PACKAGE"; 
$result = $mysqli->query($sql); 
$mysqli->close();  
?> 


<!DOCTYPE HTML>
<html>

<head>
  <title>Packages</title>
  <link rel="stylesheet" type="text/css" href="style/style.css" title="style" />
</head>

<body>
  <div id="main">
    <div id="header">
      <div id="logo">
        <div id="logo_text">
          <h1><a href="index.html"><span class="logo_colour">Packages</span></a></h1>
          <h2>We Offer the Best Packages for Best Prices</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
          <li><a href="index.html">Home</a></li>
          <li><a href="register.html">Register</a></li>
          <li><a href="booking.html">New Booking</a></li>
          <li class="selected"><a href="packages.php">Check Packages</a></li>
          <li><a href="vehicles.php">Check Vehicles</a></li>
        </ul>
      </div>
    </div>
    <div id="content_header"></div>
    <div id="site_content">
	
      <div class="sidebar">
        <h4>Need Help?</h4>
        <h5>Contact Us</h5>
        <p>Rent-A-Car (Pvt) Ltd,<br> 181, Mahara, Kadawatha,<br>Sri Lanka.</p>
		<p> Hotlines: <br>
			+94 11 5 655 655 <br>
			+94 777 363 363 </p>

		<p> Fax: +94 11 5 402 578 </p>
		<p> Email: info@rentacar.com</p>
    </div>
	
      <div id="content">
        <table> 
            <tr> 
                <th>Package</th> 
                <th>Vehicle Category</th> 
                <th>Key Money</th> 
                <th>Daily Rent</th> 
				<th>Max Kms Per Day</th>
				<th>Charge Per Extra Km</th> 				
            </tr> 
            <!-- PHP CODE TO FETCH DATA FROM ROWS--> 
            <?php   
                while($rows=$result->fetch_assoc()) 
                { 
             ?> 
            <tr> 
                <!--FETCHING DATA FROM EACH  
                    ROW OF EVERY COLUMN--> 
                <td><?php echo $rows['pack_name'];?></td> 
                <td><?php echo $rows['vehicle_category'];?></td> 
                <td><?php echo $rows['key_money'];?></td> 
                <td><?php echo $rows['rent'];?></td> 
				<td><?php echo $rows['max_kms'];?></td> 
				<td><?php echo $rows['charge_per_extra_km'];?></td> 
            </tr> 
            <?php 
                } 
             ?> 
        </table> 
	  
    </div>
	
    <div id="content_footer"></div>
    <div id="footer">
      Copyright &copy; Rent-A-Car (Pvt) Ltd. All Rights Reserved.
    </div>
	
  </div>
  
  
</body>
</html>
