<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $id = $_POST['id'];
    $title = $_POST['title'];
    $fullDescription = $_POST['fullDescription'];
    $assignee = $_POST['assignee'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->changeBug($title,$fullDescription,$assignee,$id)){
        $response['error']=false;
        $response['message']='Person changed successfully';
    }else{
        $response['error']=true;
        $response['message']='Could not change bug';
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
