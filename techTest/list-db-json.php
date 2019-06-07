<--?php

// Create connection

$hostname = "stotherd.com.mysql";
$username = "stotherd_com";
$password = "i38n4Nvf";
$db = "stotherd_com";

$con=mysqli_connect($hostname,$username,$password,$db);

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM `bug_tracker`";

// Check if there are results
if ($result = mysqli_query($con, $sql))
{
 // If so, then create a results array and a temporary one
 // to hold the data
 $response['result'] = array();

 // Loop through each row in the result set
 while($row = $result->fetch_assoc()){
    //creating a temporary array
    $temp = array();

    //inserting the team in the temporary array
    $temp['id'] = $row['id'];
    $temp['title'] = $row['title'];

    //inserting the temporary array inside response
    array_push($response['result'],$temp);
}


 // Finally, encode the array to JSON and output the results
 echo json_encode($response);
}

// Close connections
mysqli_close($con);
?>
