<?php

return [
    // Global settings
    '*' => [
        'cpTrigger'   => 'cp',
        'siteUrl'     => getenv('CONFIG_SITEURL'),
        'securityKey' => getenv('SECURITY_KEY'),

        'useEmailAsUsername'   => true,
        'omitScriptNameInUrls' => true,
        'allowUpdates'         => false,
        'enableGql'            => false,

        'limitAutoSlugsToAscii'   => true,
        'convertFilenamesToAscii' => true,

        'cacheDuration'      => 'P30D', // Cache for 30 days
        'softDeleteDuration' => 'P6M',  // Keep soft-deleted items for 6 months

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
        'enableTemplateCaching' => false,
        'testToEmailAddress'    => getenv('CONFIG_TESTTOEMAILADDRESS'),
    ],
    // Staging environment settings
    'staging' => [
        'devMode' => true,
    ],
    // Production environment settings
    'production' => [
        // Disable project config changes on production
        'allowAdminChanges' => false,
    ],
];
