<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


if ($_SERVER["REQUEST_METHOD"] == "POST") {
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
    if ($conn != true) {
        $returned['success'] = false;
        echo json_encode($returned);
        return;
    }
    if (!isset($_GET['id'])) {
        $returned['success'] = false;
        $returned['message'] = 'MISSING_PARAM(S)';
        echo json_encode($returned);
        return;
    }

    $userid =  $_GET['id'];

    $query = oci_parse($conn, "SELECT * FROM SERVERS INNER JOIN ORDERS ON SERVERS.ID = ORDERS.SERVER_ID WHERE SERVERS.ID IN (SELECT SERVER_ID FROM ORDERS WHERE USER_ID = 1)");
    oci_execute($query);

    $data = array();

    while ($row = oci_fetch_array($query)) {
        $i = [];
        $i["id"] = $row['ID'];
        $i["capacity"] = $row['CAPACITY'];
        $i["is_available"] = $row['IS_AVAILABLE'];
        $i["name"] = $row['NAME'];
        $i["category_id"] = $row['CATEGORY_ID'];
        $i["hardware_id"] = $row['HARDWARE_ID'];
        $i["is_ordered"] = $row['IS_ORDERED'];
        $i["server_id"] = $row['SERVER_ID'];
        $i["user_id"] = $row['USER_ID'];
        array_push($data, $i);
    }    

    if(isset($_POST["id"]) && $_POST["id"] !== null){
        $id = $_POST["id"];
    }

    $returned['success'] = true;
    $returned['data']= $data;
    oci_close($conn);
    echo json_encode($returned);
}