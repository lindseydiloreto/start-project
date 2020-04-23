<?php
namespace modules\businesslogic\controllers;

use Craft;
use craft\web\Controller;

class ExampleController extends Controller
{

    /**
     * See also:
     * https://docs.craftcms.com/api/v3/craft-web-controller.html#allowanonymous
     */
    // protected $allowAnonymous = true;

    /**
     * For a normal form submission, send it here.
     *
     * HOW TO USE IT
     * The HTML form in your template should include this hidden field:
     *
     *     <input type="hidden" name="action" value="business-logic/example/example-form-submit">
     *
     * The action path follows this format:
     *
     *     business-logic/<CONTROLLER HANDLE>/<FUNCTION HANDLE>
     *
     * In this case, the handles should be kebab-cased, and omit "Controller" and "action" (respectively).
     *
     */
    public function actionExampleFormSubmit()
    {
        $this->requirePostRequest();
        $request = Craft::$app->getRequest();
        $lorem = $request->getBodyParam('lorem');
        $ipsum = $request->getBodyParam('ipsum');
        // ... whatever you want to do with the submitted data...
        $this->redirect('thank/you/page');
    }

    /**
     * When you need AJAX, this is how to do it.
     *
     * HOW TO USE IT
     * In your front-end JavaScript, POST your AJAX call like this:
     *
     *     // example uses jQuery
     *     $.post('actions/business-logic/example/example-ajax' ...
     *
     * Or if your module is doing something within the control panel,
     * you've got a built-in function available which Craft provides:
     *
     *     Craft.postActionRequest('business-logic/example/example-ajax' ...
     *
     */
    public function actionExampleAjax()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $request = Craft::$app->getRequest();
        $lorem = $request->getBodyParam('lorem');
        $ipsum = $request->getBodyParam('ipsum');
        // ... whatever your AJAX does...
        $response = ['response' => 'Round trip via AJAX!'];
        return $this->asJson($response);
    }

    /**
     * Routing lets you set extra variables when you load a Twig template.
     *
     * HOW TO USE IT
     * Put this in your config/routes.php file:
     *
     *     'your/route' => 'business-logic/example/example-route'
     *
     * Optionally, you can specify dynamic parameters as part of the route:
     *
     *     'your/route/<lorem:\d+>/<ipsum:\d+>' => 'business-logic/example/example-route'
     *
     * If you specify dynamic parameters, pass those values directly into your function.
     * The variable names must match the specified tokens.
     *
     *     actionExampleRoute($lorem, $ipsum)
     *
     */
    public function actionExampleRoute()
    {
        // ... whatever your route accomplishes...
        $twigVariable = 'I added this with a route!';
        return $this->renderTemplate('your/destination/template', [
            'twigVariable' => $twigVariable
        ]);
    }

}
