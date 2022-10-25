


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

 $sql = "SELECT nic FROM CUSTOMER ";
 
if ($result = $mysqli -> query($sql)) {
    while ($obj = $result -> fetch_object()) {
        if($obj==$_POST['nic']) {
            $_SESSION['nic']=$obj;
            header("Location: bookbutton.html");
        }
        
         
    }

} 

echo "Register first";

 
   $result -> free_result();

    
 $mysqli -> close();
 
 
 
 ?> 
 