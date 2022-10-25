___
# DATABASE MANAGEMENT SYSTEM FOR A CAR RENTAL COMPANY
___

You can find the Models of our database design in 'Models' folder.

Please Follow the following steps

## INTERFACES

### Company Interface

1. Open the 'sql' folder. You will find 'script.sql' file.
2. Start mysql server and login to the server in cmd prompt.
3. Select All(ctrl+a) from the 'script.sql' file and paste in cmd prompt.
4. Open the folder 'Rent A Car System'. You will find a 'RentAcar' application.
5. Open the application and login to the system.
   Username - user
   password - user
   NOTE - *we have used default port 3308. If your machines port is different, you can change the system's port using the link in the login interface.


NOTE: * We have included some vehicles, renters and packages for testing purposes.
      * You can view, update, add data. When you add vehicles also add an image named by the id of the vehicle to the 'vehicleimgs' folder
	in 'CarRentalWebsite' folder.
      * Transactions are completed bookings. Therefore make sure the booked, return dates are compatible with today's date.



### Customer Interface

1. Copy the 'CarRentalWebsite' folder to the 'xampp/htdocs' folder.
2. Make sure to complete step 1,2,3 in steps for 'company interface' given above.
3. Start the Apache server
4. Open any web browser and type 'localhost/CarRentalWebsite'
NOTE - * We have used 'localhost' as username and '' as password. You may change it accordingly as given below.
       STEPS- Open the 'index.php' file in 'CarRentalWebsite' folder.
              Then change the values of $user, $password , $database , $servername according to your MySQL server.
                   Eg:-  $user = 'root'; 
                         $password = "";  
                         $database = 'RENT_A_CAR';
                         $servername='localhost'; 
	Then save the file. 


## Team
-  E/17/252, Kenath Perera, [email](mailto:e17252@eng.pdn.ac.lk)
-  E/17/044, Deanna Coralage, [email](mailto:e17044@eng.pdn.ac.lk)
-  E/17/242, Ruchika Perera, [email](mailto:e17242@eng.pdn.ac.lk)
