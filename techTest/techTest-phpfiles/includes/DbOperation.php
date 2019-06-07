<?php

class DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Config.php';
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    //Function to create a new bug
    public function createBug($title, $description, $status, $person)
    {
        $person_id = (int)$person;

        $stmt = $this->conn->prepare("INSERT INTO bugs(title, fullDescription, assignee) values(?, ?, ?)");
        $stmt->bind_param("ssi", $title, $description, $person_id);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    public function closeBug($id)
    {
        $person_id = (int)$person;
        $stmt = $this->conn->prepare("UPDATE bugs SET open=false WHERE id=?");
        $stmt->bind_param("i", $id);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    public function reopenBug($id)
    {
        $person_id = (int)$person;
        $stmt = $this->conn->prepare("UPDATE bugs SET open=true WHERE id=?");
        $stmt->bind_param("i", $id);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    //this method will return all the teams in the database
    public function getAllBugs(){
       $stmt = $this->conn->prepare("SELECT * FROM bugs");
       $stmt->execute();
       $result = $stmt->get_result();
       return $result;
    }

    //this method will return all the teams in the database
    public function getAllPeople(){
       $stmt = $this->conn->prepare("SELECT * FROM people");
       $stmt->execute();
       $result = $stmt->get_result();
       return $result;
    }

    //Function to create a new person
    public function createPerson($username, $firstname, $lastname)
    {
        $stmt = $this->conn->prepare("INSERT INTO people(username, firstName, lastName) values(?, ?, ?)");
        $stmt->bind_param("sss", $username, $firstname, $lastname);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    //Function to create a new person
    public function changePerson($username, $firstname, $lastname, $id)
    {
        $stmt = $this->conn->prepare("UPDATE people SET username=?, firstName=?, lastName=? WHERE id=?");
        $stmt->bind_param("sssi", $username, $firstname, $lastname, $id);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    //Function to create a new person
    public function changeBug($title, $fullDescription, $assignee, $id)
    {
        $stmt = $this->conn->prepare("UPDATE bugs SET title=?, fullDescription=?, assignee=? WHERE id=?");
        $stmt->bind_param("sssi", $title, $fullDescription, $assignee, $id);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

}
