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

$domainname = empty($_GET['name']) ? '' : $_GET['name'];

if (empty($domainname) ) {
    $returned['success'] = false;
    $returned['message'] = 'missing_params';
    echo json_encode($returned);
    oci_close($conn);
    return;
}
$query = oci_parse($conn, "SELECT count(C##OFAX96.DOMAINS.NAME) COUNT FROM C##OFAX96.DOMAINS WHERE C##OFAX96.DOMAINS.NAME = '$domainname'");
oci_execute($query);
$data = oci_fetch_assoc($query);
if ($data !== false) {
    $returned["success"] = true;
    $counter = $data["COUNT"];
    $returned['available'] = $counter === '0';
} else {
    $returned['success'] = false;
    $returned['message'] = 'QUERY_ERROR';
}
oci_close($conn);
echo json_encode($returned);
