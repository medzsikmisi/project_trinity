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
//IDAIG MIDENKEPP KELL
// ---------------------------------------


$query = oci_parse($conn, "SELECT * FROM SERVERS");
oci_execute($query);
$data = array();
while ($row = oci_fetch_assoc($query)) {
    $new_server = [];
    $new_server['id'] = $row['ID'];
    $new_server['price'] = $row['PRICE'];
    $new_server['capacity'] = $row['CAPACITY'];
    $new_server['is_available'] = $row['IS_AVAILABLE']==='0';
    array_push($data, $new_server);
}
$returned['success'] = true;
$returned['data']= $data;
oci_close($conn);
echo json_encode($returned);
