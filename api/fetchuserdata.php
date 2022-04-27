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

    $query = oci_parse($conn, "SELECT * FROM C##OFAX96.USERS WHERE C##OFAX96.USERS.ID = '$userid'");
    oci_execute($query);

    $row=oci_fetch_array($query);
    $email = $row['email'];
    $password = $row['password'];
    $full_name = $row['full_name'];
    $id = $row['id'];

    $returned["userdata"] = [

            "email"=> "hello@bello.com",
            "password"=> "asd",
            "fullname"=> "Bekre Pál",
            "address"=> "Tacskó utca 3"
    ];

    if(isset($_POST["id"]) && $_POST["id"] !== null){
        $id = $_POST["id"];
    }


    $returned['success'] = true;
    echo json_encode($returned);
}
