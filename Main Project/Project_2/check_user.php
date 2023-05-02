<?php 

   session_start();
   if (isset($_SESSION['username']) && isset($_SESSION['id'])) {

   	if ($_SESSION['role'] == "Doctor"){ 
      	header("Location:./doct_p.php");}

      	if ($_SESSION['role'] == "Receptionist"){ 
      	header("Location:./display_pinfo.php");}

      	if ($_SESSION['role'] == "Pharmacist"){ 
      	header("Location:./pharma.php");}
 }
else{
	header("Location: index.php");
} ?>