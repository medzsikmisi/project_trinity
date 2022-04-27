<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");



    $returned = [
    ];
    $returned['post']=json_encode($_POST);
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

    $email = empty($_POST['email']) ? '' : $_POST['email'];
    $password = empty($_POST['password']) ? '' : $_POST['password'];

    if (empty($email) || empty($password)) {
        $returned['success_FAZSOM'] = false;
        echo json_encode($returned);
        return;
    }
    $query = oci_parse($conn, "SELECT count(C##OFAX96.USERS.EMAIL) COUNT FROM C##OFAX96.USERS WHERE C##OFAX96.USERS.EMAIL = 'almafa123@alma.fa' AND C##OFAX96.USERS.PWD = 'valami'");
    oci_execute($query);
    $data = oci_fetch_assoc($query);
    $counter = $data["COUNT"];
    $returned["rownum"]=$counter;
    if ($counter ==1) {
        $returned["success"] = true;
        $returned["email"] = $email;
    } else {
        $returned['success'] = false;
    }
    echo json_encode($returned);
} else {
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
        echo 'connection error';
    } else {
        echo 'successfullkllllll connection';
    }


}