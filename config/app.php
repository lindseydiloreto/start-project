<?php

use modules\businesslogic\BusinessLogic;

return [
    '*' => [
        'modules' => [
            'businesslogic' => BusinessLogic::class,
        ],
        'bootstrap' => [
            'businesslogic',
        ],
    ],
    'dev' => [
        'components' => [
            'deprecator' => [
                'throwExceptions' => true,
            ]
        ]
    ]
];
