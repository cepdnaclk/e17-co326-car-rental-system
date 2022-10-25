<?php 
  
// Username is root 
$user = 'root'; 
$password = "";  
// Database name 
$database = 'RENT_A_CAR';
// Server is localhost with 
$servername='localhost'; 


session_start();
$_SESSION["user"] = $user;
$_SESSION["password"] = $password;
$_SESSION["database"] = $database ;
$_SESSION["servername"] = $servername;
?>


<!DOCTYPE HTML>



<html>

<head>
  
  <title>Rental Car</title>
  <link rel="stylesheet" type="text/css" href="style/style.css" title="style" />
</head>

<body>

  
  <div id="main">
    <div id="header">
      <div id="logo">
        <div id="logo_text">
          <h1><a href="index.html"><span class="logo_colour">Rental Car</span></a></h1>
          <h2>Book your Ideal Car From Our Wide Range Of Vehicles</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
          <li class="selected"><a href="index.html">Home</a></li>
          <li><a href="register.html">Register</a></li>
          <li><a href="booking.html">New Booking</a></li>
          <li><a href="packages.php">Check Packages</a></li>
          <li><a href="vehicles.php">Check Vehicles</a></li>
        </ul>
      </div>
    </div>
	
    <div id="site_content">
	
      <div class="sidebar">
        <h3>VEHICLE FLEET</h3>
		<p>We offer a wide range of options from economy to luxury. The fleet consists of cars and vans.</p>
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
        <h1>Welcome to Our Car Rental System</h1>
		<img src="style/frontimage.jpg" width="500" alt="Car Image">
		<h4></h4>
		<h2>PREMIER CAR RENTAL SERVICES</h2>
        <p>With over 30 years of experience in the industry, we strive to offer the highest levels of customer service and a highly
		personalised service to all our customers who are on the lookout for Sri Lanka car rental opportunities. 
		With one of the largest and most modern and varied fleets in Sri Lanka.<br>
        Choose from our extensive fleet of luxury vehicles and make your day a truly unforgettable one.</p>
      </div>
	  
    </div>
	
    <div id="content_footer"></div>
    <div id="footer">
      Copyright &copy; Rent-A-Car (Pvt) Ltd. All Rights Reserved.
    </div>
	
  </div>
  
  
</body>
</html>

