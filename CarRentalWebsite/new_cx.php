<?php
 
 session_start();
 $user = $_SESSION["user"] ;
 $password = $_SESSION["password"] ;
 $database = $_SESSION["database"] ;
 $servername = $_SESSION["servername"];
    
 
$mysqli = new mysqli($servername,$user,$password,$database);

if ($mysqli -> connect_errno) {
  echo "Failed to connect to MySQL: " . $mysqli -> connect_error;
  exit();
}

$conn=mysqli_connect($servername,$user,$password,$database);


$nic=$_POST['nic'];
$f_name=$_POST['f_name'];
$m_name=$_POST['m_name'];
$l_name=$_POST['l_name'];
$address=$_POST['address'];
$email=$_POST['email'];
$driving_license=$_POST['driving_license'];


$record = "CALL REGISTER_CUSTOMER('$nic','$f_name','$m_name','$l_name','$address','$email','$driving_license')";

if (mysqli_query($conn, $record)) {
    echo "Registered successfully !";
    header("Location:booking.html");

} else {
    echo "Error: " . $record . " 
    " . mysqli_error($conn);
}
$mysqli -> close();



?> 
