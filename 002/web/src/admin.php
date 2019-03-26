<!-- include config file -->
<?php

include 'config.php';

$connected = false;
$admin = null;
$flag = '${CEH_Step1_SQLi}';

if (isset($_SESSION['pvexconn'])) {
    try {
        $getAdmin = $DB_CONN->prepare("SELECT * FROM admin WHERE id = " . $_SESSION['pvexconn']);
        $ok = $getAdmin->execute();
        $admin = $getAdmin->fetch(PDO::FETCH_OBJ);

        if (isset($admin->id)) {
            $_SESSION['pvexconn'] = $admin->id;
            $connected = true;
        }

    } catch (PDOException $e) {
        echo $e->getMessage();
    }
}

if (isset($_POST['username']) && isset($_POST['passwd']) && !isset($_SESSION['pvexconn'])) {

    //sleep(1);
    $username = "'" . $_POST['username'] . "'";
    $password = "'" . md5('abc' . $_POST['passwd']) . "'";

    try {
        $getAdmin = $DB_CONN->prepare("SELECT * FROM admin WHERE username = " . $username . " AND password = " . $password);
        $ok = $getAdmin->execute();

        $admin = $getAdmin->fetch(PDO::FETCH_OBJ);

        if (isset($admin->id)) {
            $_SESSION['pvexconn'] = $admin->id;
            $connected = true;
        }

    } catch (PDOException $e) {
        echo $e->getMessage();
    }

}

if ($connected === true) {
    $servers = $DB_CONN->query("SELECT id, name FROM servers;")->fetchAll(PDO::FETCH_OBJ);

}
?>
<!-- end include config file -->



<h1>PVEX</h1>
<h2>Admin</h2>

<?php

if ($connected) {

    ?>

<p>Bienvenue <?=$admin->name?></p>
<p>Flag: <?=$flag?></p>

<table border="1">
<tr>
            <th>Name</th>
            <th>Action</th>
        </tr>
    <?php

    foreach ($servers as $server) {

        ?>

        <tr>
            <td><?=$server->name?></td>
            <td><a href="admin.php?server=<?= $server->id ?>">voir</a></td>
        </tr>

    <?php

    }

    ?>
</table>

<br/>
<?php


if(isset($_GET['server'])) {


    $serverS = $DB_CONN->query("SELECT * FROM servers WHERE id = ".$_GET['server'])->fetch(PDO::FETCH_OBJ);

    echo $serverS->name." : ";
    echo $serverS->status;

}

?>

<?php

} else {

    ?>

<form action="admin.php" method="post">

    <input type="text" name="username" placeholder="username">
    <input type="password" name="passwd" placeholder="password">
    <button type="submit">sign in</button>

</form>

<?php

}

?>



