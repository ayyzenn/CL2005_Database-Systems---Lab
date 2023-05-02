<!DOCTYPE html>
<html lang="en">
<head>
	<title>Doctor</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>


<div class="head">
	<img src="./images/hospital_logo.jpg" alt="Logo" width="200" height="200" style="display:inline;">
	<h1 style="display:inline;">Centeral Hospital</h1>

</div>

<h1 align = "center">Doctor's Name</h1>

<div class="container">
	<h2>Select Appointment</h2>

	<?php
    $username = 'root';
    $password = '';
    try {
        $conn = new PDO("mysql:host=localhost;dbname=HOSPITAL", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }


    ?>

    <form method = "post" name = "App">
        <div class="form-group">
            <label for="usr">Appointment Num:</label>
            <select class="form-control" name="sel1" method = "post">
            <option></option>
            <?php
                $query1 = $conn->query('SELECT * FROM APPOINTMENT where FLAG_DONE = 0;');
                $apps = $query1->fetchAll(PDO::FETCH_OBJ);
                foreach($apps as $opts)
                {
            ?>
            <option value = <?php echo $opts->APP_ID;?> ><?php echo $opts->APP_ID;}?></option>
        </select>
            <input type="submit" class="btn btn-info" value="Search">
        </div>
    </form>

    <?php
        $opr =  $_POST['sel1'];
        if($opr != "")
        {
            $query_fetchpat = $conn->query
            ("select APP_ID,P.P_FNAME,P.P_LNAME,P.P_GENDER,P.DOB 
            from APPOINTMENT A, PATIENT P where P.PATIENT_ID = A.PATIENT_ID and APP_ID = $opr;");
            $result = $query_fetchpat->fetchAll(PDO::FETCH_OBJ);
            $birthDate = date("d-m-Y",strtotime( $result[0]->DOB ));
            $currentDate = date("d-m-Y");
            $age = date_diff(date_create($birthDate), date_create($currentDate));
    ?>

    <div class = "container">
    <table class="table table-bordered" id="tab1">
	<thead>
		<tr>
            <th>Appointment Number</th>
            <th>Patient's FNAME</th>
            <th>Patient's LNAME</th>
            <th>GENDER</th>
            <th>AGE</th>
		</tr>
	</thead>
	<tbody>
        <tr>
            <td><?php echo $result[0]->APP_ID ?></td>
            <td><?php echo $result[0]->P_FNAME ?></td>
            <td><?php echo $result[0]->P_LNAME ?></td>
            <td><?php echo $result[0]->P_GENDER ?></td>
            <td><?php echo $age->format("%y") ?></td>
		</tr>
	</tbody>
	</table>
    </div>

    <?php
        }
        else
        {
            echo "<h1>No Appointment Selected</h1>";
        }
    ?>

<!-- <div style="overflow-y: scroll; height:150px;"> -->
<div class="container mt-3">
    <form method = "post">
        <label for="usr">Assign Medicines:</label>
        <?php
            $query2 = $conn->query('SELECT * FROM MEDICINE;');
            $meds = $query2->fetchAll(PDO::FETCH_OBJ);
        ?>
        <div style="overflow-y: scroll; height:150px;">
        <input type="hidden" name="myvalue" value="<?= $result[0]->APP_ID ?>" />
        <?php
            foreach($meds as $opts)
            {
        ?>
        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="check1" name="meds_assigned[]" value=<?php echo $opts->MED_ID;?>>
            <label class="form-check-label" for="check1"><?php echo $opts->MED_NAME." ".$opts->MED_DOSE;?></label>
        </div>
        <?php } ?>
        </div>
        <input type="checkbox" class="form-check-input" id="check1" name="bed_assigned" value="assign_bed">
            <label class="form-check-label" for="check1">Assign Bed</label>
        <!-- <input type="checkbox" class="form-check-input" id="check1" name="another_app" value="another_app">
            <label class="form-check-label" for="check1">Add Another Appointment</label> -->
        <br>
        <button type="submit" class="btn btn-primary mt-3">Submit</button>
    </form>
</div>
<!-- </div> -->


<?php

    $app_num = $_POST['myvalue'];
    $app_num = (int)$app_num;
    $meds_ass = $_POST['meds_assigned'];
    if(isset($_POST['meds_assigned']))
    {
        $max_bill = $conn->query("Select max(BILL_ID) as max from BILL;");
        $row = $max_bill->fetchAll(PDO::FETCH_OBJ);
        $max_bill = $row[0]->max+1;
        $query_bill = "INSERT INTO BILL VALUES ($max_bill,$app_num,NULL,0);";
        $conn->query($query_bill);
        foreach($meds_ass as $arr)
        {
            $query_bill = "INSERT into MEDICINES value ($max_bill,$arr,1,(select MED_PRICE from MEDICINE where MED_ID = $arr)*1);";
            $conn->query($query_bill);
        }
        $query_bill = "UPDATE BILL Set GRAND_TOTAL = (select sum(TOTAL_PRICE) from MEDICINES where BILL_ID = $max_bill) where BILL_ID = $max_bill;";
        $conn->query($query_bill);
        $query_bill = "UPDATE APPOINTMENT Set FLAG_DONE = 1 where APP_ID = $app_num";
        $conn->query($query_bill);
        $query_bill = "UPDATE APPOINTMENT Set APP_DATE = (SELECT CURDATE()) where APP_ID = $app_num";
        $conn->query($query_bill);
        $query_bill = "UPDATE APPOINTMENT Set APP_TIME = (SELECT CURTIME()) where APP_ID = $app_num";
        $conn->query($query_bill);
    }
    if($_POST['bed_assigned'] != "")
    {
        echo "";
        $conn->query("CALL ASSIGN_BED($app_num , @out);");
        $w_num = $conn->query("SELECT @out;");
        $w_num = $w_num->fetchAll(PDO::FETCH_OBJ);
        print_r($w_num);
    }
?>


</body>
</html>

