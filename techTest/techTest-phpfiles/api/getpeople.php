<?php

//including the file dboperation
require_once '../includes/DbOperation.php';

//creating a response array to store data
$response = array();

//creating a key in the response array to insert values
//this key will store an array iteself
$response['people'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the people using the function we created
$people = $db->getAllPeople();

//looping through all the people.
while($person = $people->fetch_assoc()){
    //creating a temporary array
    $temp = array();

    //inserting the person in the temporary array
    $temp['id'] = $person['id'];
    $temp['firstName']=$person['firstName'];
    $temp['lastName']=$person['lastName'];
    $temp['username']=$person['username'];
    //inserting the temporary array inside response
    array_push($response['people'],$temp);
}

//displaying the array in json format
echo json_encode($response);
