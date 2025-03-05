<?php

$servername = "";
$username = "root";
$password = "root";
$dbname = "medicare";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Access key authentication from database
if (!isset($_GET['key'])) {
    die("Access Denied: No key provided");
}

$provided_key = $_GET['key'];
$stmt = $conn->prepare("SELECT id FROM users WHERE access_key = ?");
$stmt->bind_param("s", $provided_key);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    die("Access Denied: Invalid key");
}

$stmt->bind_result($user_id);
$stmt->fetch();
$stmt->close();

// Handle GET request to fetch health monitoring data for the specific user
if ($_SERVER['REQUEST_METHOD'] === 'GET' && !isset($_GET['heartRate_bpm'])) {
    $sql = "SELECT * FROM health_monitoring WHERE user_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    header('Content-Type: application/json');
    echo json_encode($data);
    
    $stmt->close();
}

// Handle GET request to insert health monitoring data through a single URL
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['heartRate_bpm'])) {
    $heartRate = $_GET['heartRate_bpm'] ?? null;
    $oxygenSat = $_GET['oxygenSat_per'] ?? null;
    $bodyTemp = $_GET['bodyTemp_c'] ?? null;
    $assignedProfessional = $_GET['assigned_professional'] ?? null;

    if ($heartRate && $oxygenSat && $bodyTemp && $assignedProfessional) {
        $stmt = $conn->prepare("INSERT INTO health_monitoring (user_id, heartRate_bpm, oxygenSat_per, bodyTemp_c, assigned_professional) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("iidss", $user_id, $heartRate, $oxygenSat, $bodyTemp, $assignedProfessional);
        
        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Data inserted successfully"]);
        } else {
            echo json_encode(["success" => false, "message" => "Error inserting data"]);
        }
        $stmt->close();
    } else {
        echo json_encode(["success" => false, "message" => "Invalid input data"]);
    }
}

$conn->close();
?>
