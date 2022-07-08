<?php
$con = mysqli_connect("swisscom-rds.cgpyqwbr4qvn.ap-southeast-1.rds.amazonaws.com","admin","Password1","mydb");
$response = array();
if($con){
    $sql = "select * from DATA";
    $result = mysqli_query($con,$sql);
    if($result){
        $i=0;
        while($row = mysqli_fetch_assoc($result)){
            $response[$i]['id'] = $row[id];
            $response[$i]['name'] = $row[name];
            $response[$i]['age'] = $row[age];
            $response[$i]['email'] = $row[email];
            $i++;
        }
        echo json_encode($response,JSON_PRETTY_PRINT);
    }
}
else{
    echo "Database connection failed";
}
?>