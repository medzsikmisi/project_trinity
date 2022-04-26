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
    // Connect to database
    $conn = oci_connect("C##OFAX96", "C##OFAX96", $tns);
    //On error, send back an error
    if ($conn === false) {
        $returned['success'] = false;
        echo json_encode($returned);
        return;
    }
    $email = $_POST['email'];
    $password = $_POST['password'];

    if (empty($email) || empty($password)) {
        $returned['success'] = false;
        echo json_encode($returned);
        return;
    }

    $returned['success'] = true;
    $query = oci_parse($conn, "select email from users where email =$email and password = $password");
    oci_execute($query);
    $counter = 0;
    while ($row = oci_fetch_array($query)) {
        if ($row[0] === $email) $counter++;
    }
    if (counter === 1) {
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
        echo 'successful connection';
    }


}