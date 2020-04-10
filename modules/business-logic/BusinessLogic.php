<?php
namespace modules\businesslogic;

use Craft;
use craft\elements\Category;
use craft\elements\Entry;
use craft\elements\User;
use craft\events\RegisterElementSourcesEvent;
use craft\web\twig\variables\CraftVariable;
use modules\businesslogic\services\Example;
use modules\businesslogic\variables\BusinessLogicVariable;
use modules\businesslogic\web\twig\Extension;
use yii\base\Event;
use yii\base\Module;

class BusinessLogic extends Module
{

    /**
     * @var Module Self-referential module property.
     */
    public static $instance;

    /**
     * Initializes the module.
     */
    public function init()
    {
        // Set instance of this module
        self::$instance = $this;

        // Set alias for this module
        Craft::setAlias('@businesslogic', __DIR__);

        // Run parent init
        parent::init();

        // Adjust controller namespace for console requests
        if (Craft::$app->getRequest()->getIsConsoleRequest()) {
            $this->controllerNamespace = 'businesslogic\\console\\controllers';
        }

        // Configure everything
        $this->_registerServices();
        $this->_registerVariables();
//        $this->_registerTemplateHooks();
        $this->_registerTwigExtension();

        $this->_modifyEntrySources();
//        $this->_removeRedactorLinks();
        $this->_showTotals();
    }

    /**
     * Register services.
     */
    private function _registerServices()
    {
        $this->setComponents([
            'example' => Example::class,
        ]);
    }

    /**
     * Register variables.
     */
    private function _registerVariables()
    {
        Event::on(
            CraftVariable::class,
            CraftVariable::EVENT_INIT,
            static function (Event $event) {
                $variable = $event->sender;
                $variable->set('businessLogic', BusinessLogicVariable::class);
            }
        );
    }

//    /**
//     * Initialize template hooks.
//     */
//    private function _registerTemplateHooks()
//    {
//        $view = Craft::$app->getView();
//        $view->hook('my-hook', [Hooks::class, 'myHook']);
//    }

    /**
     * Register Twig extension.
     */
    private function _registerTwigExtension()
    {
        Craft::$app->getView()->registerTwigExtension(new Extension());
    }

    // ================================================================================ //

    /**
     * Modify entry sources
     */
    private function _modifyEntrySources()
    {
        Event::on(
            Entry::class,
            Entry::EVENT_REGISTER_SOURCES,
            static function(RegisterElementSourcesEvent $event) {
                if ($event->context === 'index') {

                    // Remove "All Entries"
                    foreach ($event->sources as $i => $source) {
                        if (array_key_exists('key', $source) && ('*' == $source['key'])) {
                            unset($event->sources[$i]);
                        }
                    }

                }
            }
        );
    }

//    /**
//     * Remove "Link to..." Redactor links.
//     */
//    private function _removeRedactorLinks()
//    {
//        Event::on(
//            RedactorField::class,
//            RedactorField::EVENT_REGISTER_LINK_OPTIONS,
//            static function(RegisterLinkOptionsEvent $event) {
//
//                // Only apply to a specific Redactor config
//                if ('Message.json' == $event->sender->redactorConfig) {
//
//                    // Remove Craft's injected links
//                    $event->linkOptions = [];
//
//                }
//
//            }
//        );
//    }

    /**
     * Display element totals
     */
    private function _showTotals()
    {

        // Show entry totals
        Event::on(
            Entry::class,
            Entry::EVENT_REGISTER_SOURCES,
            static function(RegisterElementSourcesEvent $event) {
                if ($event->context === 'index') {
                    foreach ($event->sources as $i => &$source) {

                        // If heading, skip
                        if (array_key_exists('heading', $source)) {
                            continue;
                        }

                        // If somehow criteria is missing, skip
                        if (!array_key_exists('criteria', $source)) {
                            continue;
                        }

                        // Get all matches, regardless of status
                        $criteria = $source['criteria'];
                        $criteria['status'] = null;

                        // Get total based on criteria
                        $query = Entry::find();
                        Craft::configure($query, $criteria);
                        $total = $query->count();

                        // If no total, continue
                        if (0 == $total) {
                            continue;
                        }

                        // Set badge
                        $source['badgeCount'] = $total;
                    }
                }
            }
        );

        // Show category totals
        Event::on(
            Category::class,
            Category::EVENT_REGISTER_SOURCES,
            static function(RegisterElementSourcesEvent $event) {
                if ($event->context === 'index') {
                    foreach ($event->sources as $i => &$source) {

                        // If heading, skip
                        if (array_key_exists('heading', $source)) {
                            continue;
                        }

                        // If somehow criteria is missing, skip
                        if (!array_key_exists('criteria', $source)) {
                            continue;
                        }

                        // Get all matches, regardless of status
                        $source['criteria']['status'] = null;

                        // Get total based on criteria
                        $query = Category::find();
                        Craft::configure($query, $source['criteria']);
                        $total = $query->count();

                        // If no total, continue
                        if (0 == $total) {
                            continue;
                        }

                        // Set badge
                        $source['badgeCount'] = $total;
                    }
                }
            }
        );

        // Show user totals
        Event::on(
            User::class,
            User::EVENT_REGISTER_SOURCES,
            static function(RegisterElementSourcesEvent $event) {
                if ($event->context === 'index') {
                    foreach ($event->sources as $i => &$source) {

                        // If heading, skip
                        if (array_key_exists('heading', $source)) {
                            continue;
                        }

                        // If somehow criteria is missing, skip
                        if (!array_key_exists('criteria', $source)) {
                            continue;
                        }

                        // Get all matches, regardless of status
                        $source['criteria']['status'] = null;

                        // Get total based on criteria
                        $query = User::find();
                        Craft::configure($query, $source['criteria']);
                        $total = $query->count();

                        // If no total, continue
                        if (0 == $total) {
                            continue;
                        }

                        // Set badge
                        $source['badgeCount'] = $total;
                    }
                }
            }
        );
    }

}
