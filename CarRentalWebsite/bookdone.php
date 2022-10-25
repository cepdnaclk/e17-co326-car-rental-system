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

  $start_date=$_SESSION["start_date"];
  $end_date=$_SESSION["end_date"];
  $nic = $_SESSION["nic"];
  $vehilce_id = $_SESSION["vehicle_id"];


  $date1 = str_replace('-', '', $start_date );
  $date2 = str_replace('-', '', $end_date );

  //echo "$date2";

  $conn=mysqli_connect($servername,$user,$password,$database);


 $sql = "CALL MAKE_BOOKING( '$vehilce_id','$nic', '$date1', '$date2')";;
  
 
 if (mysqli_query($conn, $sql)) {
    echo "Booking Done successfully !";
    //header("Location:index.html");

} else {
    echo "Error: " . $sql . " 
    " . mysqli_error($conn);

} 
 $mysqli -> close();
 
 
 
 ?> 
 