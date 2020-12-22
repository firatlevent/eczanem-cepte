<?php

$servername = "localhost";
$username = "dvnqfixl_otomasyon";
$password = "325848900Aa";
$dbname = "dvnqfixl_otomasyon";

$action = $_POST["action"];

$conn = new mysqli($servername, $username, $password, $dbname);
mysqli_set_charset($conn, "utf8");

if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
    return;
}

if ("ILAC_STOK_GETIR" == $action) {
      $db_data = array();
    $sql = "SELECT * FROM ilacStok";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $conn->close();
    return;
}
if ("BUTUN_HASTA_GETIR" == $action) {
      $db_data = array();
    $sql = "SELECT * FROM hasta";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $conn->close();
    return;
}


if ("MUHASEBE_GETIR" == $action) {
      $db_data = array();
    $sql = "SELECT * FROM muhasebe";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $conn->close();
    return;
}
if ("BUTUN_PERSONEL_GETIR" == $action) {
      $db_data = array();
    $sql = "SELECT * FROM personel";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $conn->close();
    return;
}


if ("HASTA_EKLE" == $action) {
    // App will be posting these values to this server
    $ad = $_POST["ad"];
    $soyad = $_POST["soyad"];
    $tc = $_POST["tc"];
    $adress = $_POST["adress"];
    $telefon = $_POST["telefon"];
    $sql = "INSERT INTO hasta (ad,soyad,tc,adress,telefon) VALUES ('$ad', '$soyad', '$tc', '$adress', '$telefon')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}
if ("PERSONEL_EKLE" == $action) {
    // App will be posting these values to this server
    $ad = $_POST["ad"];
    $soyad = $_POST["soyad"];
    $tc = $_POST["tc"];
    $telefon = $_POST["telefon"];
    $adress = $_POST["adress"];
    $maas = $_POST["maas"];
    $sql = "INSERT INTO personel (ad,soyad,tc,telefon,adress,maas) VALUES ('$ad', '$soyad', '$tc', '$telefon', '$adress','$maas')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}
if ("ILAC_KAYIT_EKLE" == $action) {
    // App will be posting these values to this server
    $isim = $_POST["isim"];
    $barkodno = $_POST["barkodno"];
    $alisfiyati = $_POST["alisfiyati"];
    $satisfiyati = $_POST["satisfiyati"];
    $adet = $_POST["adet"];
    $sql = "INSERT INTO ilacStok (isim,barkodno,alisfiyati,satisfiyati,adet) VALUES ('$isim', '$barkodno', '$alisfiyati', '$satisfiyati', '$adet')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}