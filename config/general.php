<?php

return [
    // Global settings
    '*' => [
        'cpTrigger'   => 'cp',
        'siteUrl'     => getenv('CONFIG_SITEURL'),
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
            '@webroot'      => getenv('CONFIG_SITEPATH'),
            '@baseUrl'      => getenv('CONFIG_SITEURL'),
            '@basePath'     => getenv('CONFIG_SITEPATH'),
            '@assetsUrl'    => getenv('CONFIG_SITEURL').'/assets',
            '@assetsPath'   => getenv('CONFIG_SITEPATH').'/assets',
            '@resourcesUrl' => getenv('CONFIG_SITEURL').'/resources',
        ],
    ],
    // Dev environment settings
    'dev' => [
        'devMode'               => true,
        'allowUpdates'          => true,
        'allowAdminChanges'     => true,
        'enableTemplateCaching' => false,
        'testToEmailAddress'    => getenv('CONFIG_TESTTOEMAILADDRESS'),
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
