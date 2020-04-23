<?php
namespace modules\businesslogic\services;

use craft\base\Component;

class Example extends Component
{

    /**
     * HOW TO USE IT
     * From any other plugin or module file, call it like this:
     *
     *     BusinessLogic::$instance->example->exampleService()
     *
     */
    public function exampleService()
    {
        return "I've got your data right here!";
    }

}
