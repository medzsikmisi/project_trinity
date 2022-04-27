<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
$returned = [];
$tns = "
(DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SID = orania2)
    )
  )";
// Connect to database
$conn = oci_connect("C##OFAX96", "C##OFAX96", $tns);
//On error, send back an error
if ($conn === false) {
    $returned['success'] = false;
    echo json_encode($returned);
    return;
}

$email = empty($_GET['email']) ? '' : $_GET['email'];
$password = empty($_GET['password']) ? '' : $_GET['password'];

if (empty($email) || empty($password)) {
    $returned['success'] = false;
    echo json_encode($returned);
    oci_close($conn);
    return;
}
$query = oci_parse($conn, "SELECT count(C##OFAX96.USERS.EMAIL) COUNT FROM C##OFAX96.USERS WHERE C##OFAX96.USERS.EMAIL = '$email' AND C##OFAX96.USERS.PWD = '$password'");
oci_execute($query);
$data = oci_fetch_assoc($query);
$counter = $data["COUNT"];
if ($counter == 1) {
    $returned["success"] = true;
    $returned["email"] = $email;
} else {
    $returned['success'] = false;
}
oci_close($conn);
echo json_encode($returned);
