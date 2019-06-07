<?php

//including the file dboperation
require_once '../includes/DbOperation.php';

//creating a response array to store data
$response = array();

//creating a key in the response array to insert values
//this key will store an array iteself
$response['bugs'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the bugs using the function we created
$bugs = $db->getAllBugs();

//looping through all the bugs.
while($bug = $bugs->fetch_assoc()){
    //creating a temporary array
    $temp = array();

    //inserting the bug in the temporary array
    $temp['id'] = $bug['id'];
    $temp['title']=$bug['title'];
    $temp['fullDescription']=$bug['fullDescription'];
    $temp['open']=$bug['open'];
    $temp['assignee']=$bug['assignee'];
    $temp['timestamp']=$bug['timestamp'];


    //inserting the temporary array inside response
    array_push($response['bugs'],$temp);
}

//displaying the array in json format
echo json_encode($response);
