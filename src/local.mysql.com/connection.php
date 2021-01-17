<?php

try {
    $dbh = new PDO('mysql:host=database;dbname=test', 'root', 'root');
    echo 'Connection success';
} catch (PDOException $e) {
    print "Error : " . $e->getMessage() . "<br/>";
    die();
}