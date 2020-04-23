<?php
namespace modules\businesslogic\variables;

class BusinessLogicVariable
{

    /**
     * HOW TO USE IT
     * From any Twig template, call it like this:
     *
     *     {{ craft.businessLogic.exampleVariable }}
     *
     * Or, if your variable requires input from Twig:
     *
     *     {{ craft.businessLogic.exampleVariable(twigValue) }}
     *
     */
    public function exampleVariable($optional = null)
    {
        return "And away we go to the Twig template...";
    }

}
