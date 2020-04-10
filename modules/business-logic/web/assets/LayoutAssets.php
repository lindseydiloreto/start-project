<?php
namespace modules\businesslogic\web\assets;

use craft\web\AssetBundle;
use misterbk\mix\Mix;

class LayoutAssets extends AssetBundle
{

    /**
     * @inheritDoc
     */
    public function init()
    {
        parent::init();

        $mix = Mix::$plugin->mix;
        $siteUrl = getenv('CONFIG_SITEURL');

        $this->css = [
            'https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css',
            $siteUrl.$mix->version('css/styles.css'),
        ];

        $this->js = [
            'https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js',
//            $siteUrl.$mix->version('js/manifest.js'),
//            $siteUrl.$mix->version('js/vendor.js'),
//            $siteUrl.$mix->version('js/scripts.js'),
        ];
    }

}
