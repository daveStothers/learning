<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $id = $_POST['id'];
    $username = $_POST['username'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->changePerson($username,$firstname,$lastname,$id)){
        $response['error']=false;
        $response['message']='Person changed successfully';
    }else{
        $response['error']=true;
        $response['message']='Could not change person';
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
