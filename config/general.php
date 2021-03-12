<?php

return [
    // Global settings
    '*' => [
        'cpTrigger'   => 'cp',
        'securityKey' => getenv('SECURITY_KEY'),

        'allowAdminChanges' => false, // Restrict changes to any Settings

        'useEmailAsUsername'   => true,
        'omitScriptNameInUrls' => true,
        'allowUpdates'         => false,
        'enableGql'            => false,

        'limitAutoSlugsToAscii'   => true,
        'convertFilenamesToAscii' => true,

        'cacheDuration'      => 'P30D', // Cache for 30 days
        'softDeleteDuration' => 'P1Y', // Keep soft-deleted items for 1 year

        'userSessionDuration'           => 'P1D', // Stay logged in for 1 day
        'rememberedUserSessionDuration' => 'P1Y', // Stay logged in for 1 year ("Remember Me")
        'verificationCodeDuration'      => 'P2W', // Verification codes expire after 2 weeks

        'defaultSearchTermOptions' => ['subLeft' => true],

        'aliases' => [
            '@web'          => null,
            '@webroot'      => getenv('SITE_BASEPATH'),
            '@baseUrl'      => getenv('SITE_BASEURL'),
            '@basePath'     => getenv('SITE_BASEPATH'),
            '@assetsUrl'    => getenv('SITE_BASEURL').'/assets',
            '@assetsPath'   => getenv('SITE_BASEPATH').'/assets',
            '@resourcesUrl' => getenv('SITE_BASEURL').'/resources',
        ],
    ],
    // Dev environment settings
    'dev' => [
        'devMode'               => true,
        'allowUpdates'          => true,
        'allowAdminChanges'     => true,
        'enableTemplateCaching' => false,
        'testToEmailAddress'    => getenv('TEST_EMAIL'),
    ],
    // Staging environment settings
    'staging' => [
        'devMode' => true,
        'runQueueAutomatically' => false, // Trigger queue via cron job
    ],
    // Production environment settings
    'production' => [
        'runQueueAutomatically' => false, // Trigger queue via cron job
    ],
];
