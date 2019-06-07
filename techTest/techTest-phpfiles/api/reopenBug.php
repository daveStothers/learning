<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $id = $_POST['id'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->reopenBug($id)){
        $response['error']=false;
        $response['message']='Bug closed successfully';
    }else{
        $response['error']=true;
        $response['message']='Could not add bug';
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
