<?php

return [
    // Global settings
    '*' => [
        'securityKey' => getenv('SECURITY_KEY'),
        'siteUrl' => getenv('CONFIG_SITEURL'),
        'cpTrigger' => 'cp',
        'omitScriptNameInUrls' => true,
        'allowUpdates' => false,
        'sendPoweredByHeader' => false,
        'cacheDuration' => 2592000, // Cache for 30 days
        'userSessionDuration' => 'P1D',
        'rememberedUserSessionDuration' => 'P1Y',
        'verificationCodeDuration' => 'P2W',
        'useEmailAsUsername' => true,
        'defaultSearchTermOptions' => ['subLeft' => true],
        'convertFilenamesToAscii' => true,
        'limitAutoSlugsToAscii' => true,
        'aliases' => [
            '@web' => null,
            '@webroot' => null,
            '@baseUrl' => getenv('CONFIG_SITEURL'),
            '@basePath' => getenv('CONFIG_SITEPATH'),
            '@assetsUrl' => getenv('CONFIG_SITEURL').'/assets',
            '@assetsPath' => getenv('CONFIG_SITEPATH').'/assets',
            '@resourcesUrl' => getenv('CONFIG_SITEURL').'/resources',
        ],
    ],
    // Dev environment settings
    'dev' => [
        'devMode' => true,
        'allowUpdates' => true,
        'enableTemplateCaching' => false,
        'testToEmailAddress' => getenv('CONFIG_TESTTOEMAILADDRESS'),
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
