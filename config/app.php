<?php

use modules\businesslogic\BusinessLogic;

return [
    'modules' => [
        'businesslogic' => BusinessLogic::class,
    ],
    'bootstrap' => [
        'businesslogic',
    ],
    'components' => [
        // Throw hard errors on deprecation warnings
        'deprecator' => ['throwExceptions' => YII_DEBUG]
    ]
];
