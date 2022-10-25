

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
 
//$date1=new DateTime($_POST['end_date']);
$date1=date('Y-m-d', strtotime($_POST['end_date']));
//$date2=new DateTime($_POST['start_date']);
$date2=date('Y-m-d', strtotime($_POST['start_date']));
//$difference = $date1->diff($date2); 


$sql = "SELECT id from VEHICLE where id IN(select vehicleID from BOOKING where (return_date < '$date2' OR booked_date >'$date1') AND id=vehicleID)  ";


/*if(mysqli_num_rows($result)>0){
    while($row = mysqli_fetch_assoc($result)){
        //print_r($row);
        array_push($datarr,$row);
    }
}*/
//print_r($datarr);
//print_r(array_slice($datarr,1,null,true));

session_start();
$_SESSION["end_date"] = $date1;
$_SESSION["start_date"] = $date2;

/*foreach($datarr[0] as $data){
    echo $data['text'];
}*/    //return $datarr;

header("Location: vehicle_select.php");


//echo "select valid end date ";

 
 $mysqli -> close();
 
 

 ?> 
 