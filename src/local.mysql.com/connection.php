<?php

try {
    $dbh = new PDO('mysql:host=database;dbname=swiftoms', 'root', 'root');
    echo 'Connection success';
} catch (PDOException $e) {
    print "Error : " . $e->getMessage() . "<br/>";
    die();
}
