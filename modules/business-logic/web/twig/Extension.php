<?php
namespace modules\businesslogic\web\twig;

use modules\businesslogic\web\assets\LayoutAssets;
use Twig\Extension\AbstractExtension;
use Twig\Extension\GlobalsInterface;

class Extension extends AbstractExtension implements GlobalsInterface
{

    /**
     * @inheritDoc
     */
    public function getGlobals(): array
    {
        // Initialize globals
        $globals = [];

        $globals['LayoutAssets'] = LayoutAssets::class;

        $globals['baseUrl']      = getenv('CONFIG_SITEURL');
        $globals['assetsUrl']    = getenv('CONFIG_SITEURL').'/assets';
        $globals['resourcesUrl'] = getenv('CONFIG_SITEURL').'/resources';

        return $globals;
    }

}
