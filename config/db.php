<?php

return [
    'server'   => getenv('DB_HOSTNAME'),
    'database' => getenv('DB_DATABASE'),
    'user'     => getenv('DB_USERNAME'),
    'password' => getenv('DB_PASSWORD'),
];
