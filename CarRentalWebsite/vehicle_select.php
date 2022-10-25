<?php 
  
  session_start();
  $user = $_SESSION["user"] ;
  $password = $_SESSION["password"] ;
  $database = $_SESSION["database"] ;
  $servername = $_SESSION["servername"];
  $date1 = $_SESSION["end_date"] ;
  $date2 = $_SESSION["start_date"];

    
$mysqli = new mysqli($servername, $user, $password, $database); 
  
// Checking for connections 
if ($mysqli->connect_error) { 
    die('Connect Error (' .  
    $mysqli->connect_errno . ') '.  
    $mysqli->connect_error); 
} 


$sql = "SELECT id, name, category, max_passengers FROM VEHICLE WHERE availability=TRUE AND id NOT IN(select vehicleID from BOOKING where return_date >= '$date2'  )  ";

$result = $mysqli->query($sql); 
$mysqli->close();  
?> 


<!DOCTYPE HTML>
<html>
<style>
.btn {
  background-color: #555;
  color: white;
  padding: 8px 16px;
  border: none;
  cursor: pointer;
  border-radius: 5px;
  text-align: center;
}

.btn:hover {
  background-color: black;
}

</style>
<head>
  <title>Vehicles</title>
  <link rel="stylesheet" type="text/css" href="style/style.css" title="style" />
</head>

<body>
  <div id="main">
    <div id="header">
      <div id="logo">
        <div id="logo_text">
          <h1><a href="index.html"><span class="logo_colour">Vehicle Fleet</span></a></h1>
          <h2>Choose From Our Wide Range Of Vehicles</h2>
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
        <h1>Vehicles</h1>
		<table style="font-size: large"> 
         
            <!-- PHP CODE TO FETCH DATA FROM ROWS--> 
            <?php   
                while($rows=$result->fetch_assoc()) { 
					$id = $rows['id'];
					$imgurl = "vehicleimgs/{$id}.jpg";
			?>
			
            <tr> 
                <td rowspan="4"><img src="<?= $imgurl; ?>" width="300" /></td> 
                <td><?php echo 'Name: '.$rows['name'];?></td> 
			</tr>
			<tr>
                <td><?php echo 'Vehicle Category: '.$rows['category'];?></td> 
			</tr>
			<tr>
                <td><?php echo 'Max Passengers: '.$rows['max_passengers'];?></td> 
            </tr> 
      <tr>
            <td><?php echo"<form method = 'post'><input type = 'hidden' name= 'id' value ='{$id}'/><input type = 'submit' name= 'action' value ='book'/></form> "; ?></td>
      </tr>      
            <?php 

                } $result->free(); 
             ?> 
        </table> 
      
        <?php 

            if(ISSET($_POST['action'])){
                $book = $_POST['action'];
                if($book=='book'){
                    $vehicle_id =  $_POST['id'];
                    session_start();
                    $_SESSION["vehicle_id"]=$vehicle_id;
                    header("Location: cxvalidationform.html");


                }
                //echo "$_POST['id']";
            }
        ?>

      </div>
    </div>
	
    <div id="content_footer"></div>
    <div id="footer">
      Copyright &copy; Rent-A-Car (Pvt) Ltd. All Rights Reserved.
    </div>
	
  </div>
  
  
</body>
</html>

