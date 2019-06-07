<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<?php

$hostname = "stotherd.com.mysql";
$username = "stotherd_com";
$password = "i38n4Nvf";
$db = "stotherd_com";

$dbconnect=mysqli_connect($hostname,$username,$password,$db);

if ($dbconnect->connect_error) {
  die("Database connection failed: " . $dbconnect->connect_error);
}

?>

<table border="1" align="center">
<tr>
  <td>bug id</td>
  <td>Full title</td>
  <td>Description</td>
  <td>Timestamp</td>
</tr>

<?php

$query = mysqli_query($dbconnect, "SELECT * FROM `bug_tracker`")
   or die (mysqli_error($dbconnect));

while ($row = mysqli_fetch_array($query)) {
  echo
   "<tr>
    <td>{$row['bug_id']}</td>
    <td>{$row['title']}</td>
    <td>{$row['full_description']}</td>
    <td>{$row['timestamp']}</td>
   </tr>\n";

}

?>
</table>
</body>
</html>
