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
$query = oci_parse($conn, "SELECT USERS.ID ID FROM C##OFAX96.USERS WHERE USERS.EMAIL = '$email' AND USERS.PWD = '$password'");
oci_execute($query);
oci_fetch_all($query,$data);
$rownum = oci_num_rows($query);
$returned['rownum'] = $rownum;
if ($rownum== 1) {
    $returned["success"] = true;
    $returned['id']=$data['ID'][0];
    $returned["email"] = $email;
} else {
    $returned['success'] = false;
}
oci_close($conn);
echo json_encode($returned);
