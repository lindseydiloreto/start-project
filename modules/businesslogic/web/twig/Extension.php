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

        $globals['baseUrl']      = getenv('SITE_BASEURL');
        $globals['assetsUrl']    = getenv('SITE_BASEURL').'/assets';
        $globals['resourcesUrl'] = getenv('SITE_BASEURL').'/resources';

        return $globals;
    }

}
