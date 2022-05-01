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
    if (!isset($_GET['email'], $_GET['password'], $_GET['full_name'], $_GET['zip_code'], $_GET['city'], $_GET['street_and_number'], $_GET['country'])) {
        $returned['success'] = false;
        $returned['message'] = 'MISSING_PARAM(S)';
        echo json_encode($returned);
        return;
    }
    $conn = oci_connect("C##OFAX96", "C##OFAX96", $tns);
    if ($conn === false) {
        $returned['success'] = false;
        echo json_encode($returned);
        return;
    }


    $email = $_GET['email'];
    $password = $_GET['password'];
    $full_name = $_GET['full_name'];
    $zipcode = $_GET['zip_code'];
    $city = $_GET['city'];
    $street_and_number = $_GET['street_and_number'];
    $country = $_GET['country'];
    //----
    $query = oci_parse($conn, "insert into adresses (zip_code, city, street_and_number, country, alias) values ($zipcode, $city, $street_and_number, $country, 'Main address')");

    if ($query === false) {
        $returned['success'] = false;
        $returned['message'] = 'can not instert into adresses';
        echo json_encode($returned);
        oci_close($conn);
        return;
    }
    //----
    $statement = oci_parse($conn, "INSERT INTO USERS(EMAIL, PWD, FULL_NAME) VALUES ('$email','$password','$full_name')");
    $result = oci_execute($statement);
    if ($result !== false) {
        $returned['success'] = true;
    } else {
        $returned['success'] = false;
        $returned['message'] = 'INSERTING_ERROR';
    }

    oci_close($conn);
    echo json_encode($returned);
}
