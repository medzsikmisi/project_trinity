<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
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
    if (!isset($_GET['server_id'], $_GET['user_id'])) {
        $returned['success'] = false;
        $returned['message'] = 'MISSING_PARAM(S)';
        echo json_encode($returned);
        oci_close($conn);
        return;
    }

    $userid = $_GET['user_id'];
    $serverid = $_GET['server_id'];
    $query = oci_parse($conn, "insert into owned_servers (user_id,server_id) values ($userid,$serverid)");
    oci_execute($query);
    if ($query === false) {
        $returned['success'] = false;
        $returned['message'] = 'owned error';
        echo json_encode($returned);
        oci_close($conn);
        return;
    }

    $query = oci_parse($conn, "update servers set is_available = 0 where id = '$serverid'");
    oci_execute($query);
    if ($query === false) {
        $returned['success'] = false;
        $returned['message'] = 'update error';
        oci_close($conn);
        echo json_encode($returned);
        return;
    }
    $query = oci_parse($conn, "insert into orders (user_id,server_id,is_ordered) values ('$userid','$serverid',1)");
    oci_execute($query);
    if ($query === false) {
        $returned['success'] = false;
        $returned['message'] = 'orders error';
        oci_close($conn);
        json_encode($returned);
        return;
    }


    $returned['success'] = true;
    oci_close($conn);
    echo json_encode($returned);
}
