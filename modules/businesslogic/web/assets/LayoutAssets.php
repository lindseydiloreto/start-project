<?php
namespace modules\businesslogic\web\assets;

use craft\web\AssetBundle;

class LayoutAssets extends AssetBundle
{

    /**
     * @inheritDoc
     */
    public function init()
    {
        parent::init();

        $this->css = [
            'https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css',
            '/resources/css/styles.css',
        ];

        $this->js = [
            'https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js',
//            '/resources/js/manifest.js',
//            '/resources/js/vendor.js',
//            '/resources/js/scripts.js',
        ];
    }

}
