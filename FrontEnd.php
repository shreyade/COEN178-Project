
<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

    // Get the movie name
    // is this color variable necessary?
     $color = $_POST['color'];

     $orderId = $_POST['orderId'];

     $itemId = $_POST['itemId'];

     $customerId = $_POST['customerId'];

     $dateOrdered = $_POST['dateOrdered'];

     $noOfItems = $_POST['quantity'];

     $shippedDate = $_POST['shippedDate'];


     if (!empty($orderId)){
		$orderId = prepareInput($orderId);
     }
     if (!empty($itemId)){
		$itemId = prepareInput($itemId);
     }

     if (!empty($customerId)){
		$customerId = prepareInput($customerId);
     }

     if (!empty($dateOrdered)){
		$dateOrdered = prepareInput($dateOrdered);
     }

     if (!empty($quantity)){
		$quantity = prepareInput($quantity);
     }

     if(!empty($shippedDate)) {
         $shippedDate = prepareInput($shippedDate);
     }


	 
	// Call the function to insert the values into the table
	insertDataIntoDB($orderId,$itemId,$customerId, $dateOrdered, $quantity, $shippedDate);
}

function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function insertDataIntoDB($orderId,$itemId,$customerId, $dateOrdered, $quantity, $shippedDate){
	//connect to your database. Type in sd username, password and the DB path
	$conn = oci_connect('sde', '00001239507', '//dbserver.engr.scu.edu/db11g');
	
	if (!$conn) {
		$e = oci_error();
		trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
	} 
	if(!$conn) {
	     print "<br> connection failed:";
        exit;
	}
    
    
    how do we call the plsql procedures in the plsql procedure? 
    // Calling the PLSQL procedure, insertDataIntoDB
	$sql = oci_parse($conn, 'begin insertDataIntoDB(:orderId, :itemId, :customerId, 
					:dateOrdered, :quantity, :shippedDate); end;');	

	oci_bind_by_name($sql, ':orderId', $orderId);
	oci_bind_by_name($sql, ':itemId', $itemId);
	oci_bind_by_name($sql, ':customerId', $customerId);
	oci_bind_by_name($sql, ':dateOrdered', $dateOrdered);
	oci_bind_by_name($sql, ':quantity', $quantity);
	oci_bind_by_name($sql, ':shippedDate', $shippedDate);
	
    

	// Execute the query
	$res = oci_execute($sql);
	
	if ($res){
		echo '<br><br> <p style="color:green;font-size:20px">';
		echo "Item inserted </p>";
	}
	else{
		$e = oci_error($query);
        	echo $e['message'];
	}
	oci_free_statement($sql);
	OCILogoff($conn);
}
?>
