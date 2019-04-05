<?php

error_reporting(E_ALL);
ini_set('display_errors', true);

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');

$db = json_decode(file_get_contents('db.json'));

$action = filter_input(INPUT_GET, 'action');
$page = filter_input(INPUT_GET, 'page');
$title = filter_input(INPUT_GET, 'title');
$id = filter_input(INPUT_GET, 'id');
$method = filter_input(INPUT_SERVER, 'REQUEST_METHOD');

function save($database, $newRow) {
    $database[] = $newRow;
    return file_put_contents('db.json', json_encode($database, JSON_PRETTY_PRINT));
}

function response($data, $code = 200)
{
    header('Content-Type: application/json');
    http_response_code($code);
    echo json_encode($data, JSON_PRETTY_PRINT);
    exit();
}

if($method==='OPTIONS'){
    response(['request' => 'accepted']);
}

if ($page === 'images' && empty($id) && $method === 'GET' && $action != 'post') {
    response($db);
} elseif ($page === 'images' && !empty($id) && $method === 'GET') {
    if(is_array($db) && !empty($db)){
        foreach($db as &$row) {
            if($row->id === $id){
                response($row);
            }
        }
    }
    response(['error' => 'not-found'], 404);
} elseif ($page === 'images' && !empty($title) && ($method == 'POST' || $action=="post")) {

    $data = file_get_contents('php://input');

    $data = json_decode($data);

    $data->raw = base64_decode(str_replace('data:'.$data->filetype.';base64,', '', $data->value));




    if($data->raw === null || $data->filename === null) {
        response(['error' => 'bad-request'], 400);
    }
    $dir = './img/'.uniqid();
    mkdir($dir);

    $path = $dir . '/' . $data->filename;

    $row = [
        'id' => uniqid(),
        'title' => $title,
        'filename' => $data->filename,
        'path' => $path,
        'date' => date('Y-m-d H:i:s')
    ];

    if(strpos($data->filetype, 'image')===false) {
        $row['flag'] = '${CEH_ThisIsNotAnImage}';
    }

    file_put_contents($path, ($data->raw));

    save($db, $row);

    response($row);
} else {
    response(['error' => 'not-found'], 404);
}


?>
