<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $title = $_POST['title'];
    $description = $_POST['description'];
    $status = $_POST['status'];
    $person = $_POST['person'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->createBug($title,$description,$status,$person)){
        $response['error']=false;
        $response['message']='Bug added successfully';
    }else{
        $response['error']=true;
        $response['message']='Could not add bug';
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
