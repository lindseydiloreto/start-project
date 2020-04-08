<?php

use modules\businesslogic\BusinessLogic;

return [
    'modules' => [
        'business-logic' => BusinessLogic::class,
    ],
    'bootstrap' => [
        'business-logic',
    ],
];
