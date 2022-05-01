<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $returned = [

    ];
    $tns = "
(DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SID = orania2)
    )
  )";

    $conn = oci_connect("C##OFAX96", "C##OFAX96", $tns);
    if ($conn === false) {
        $returned['success'] = false;
        echo json_encode($returned);
        return;
    }

    $server_name = $_GET['name'];

    $query = oci_parse($conn, 
        "insert into domains (name)
        values ($name)"
    );

    if ($query === false) {
        $returned['success'] = false;
        $returned['message'] = 'can not insert into domains';
    } else {
        $returned['success'] = true;
        $returned['message'] = 'inserted into domains';
    }

    echo json_encode($returned);
    oci_close($conn);
}


?>