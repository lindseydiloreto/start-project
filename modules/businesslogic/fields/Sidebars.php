<?php
namespace modules\businesslogic\fields;

use Craft;
use craft\base\ElementInterface;
use craft\base\Field;
use craft\base\PreviewableFieldInterface;
use craft\elements\Entry;
use yii\db\Schema;

class Sidebars extends Field implements PreviewableFieldInterface
{

    /**
     * @inheritDoc
     */
    public static function displayName(): string
    {
        return 'Sidebars';
    }

    /**
     * @inheritDoc
     */
    public function getContentColumnType(): string
    {
        return Schema::TYPE_TEXT;
    }

    /**
     * @inheritDoc
     */
    public function getTableAttributeHtml($value, ElementInterface $element): string
    {
        // If no value, display nothing
        if (!$value) {
            return '';
        }

        // Cache array of sidebars, indexed by IDs
        $sidebars = Craft::$app->getCache()->getOrSet(
            'sidebars',
            function() {
                return Entry::find()
                    ->select(['elements.id','title'])
                    ->section('sidebars')
                    ->pairs();
            },
            30 // Just long enough to load the whole page
        );

        // Return sidebar title, or fallback to nothing
        return ($sidebars[$value] ?? '');
    }

    /**
     * @inheritDoc
     */
    public function getInputHtml($value, ElementInterface $element = null): string
    {
        // Get all sidebars
        $entries = Entry::find()
            ->select(['elements.id','title'])
            ->section('sidebars')
            ->all();

        // Initialize options array
        $options = ['' => 'None'];

        // Append each sidebar to the options array
        foreach ($entries as $entry) {
            $options[$entry->id] = $entry->title;
        }

        // Render table
        return Craft::$app->getView()->renderTemplate('business-logic/sidebars', [
            'name' => $this->handle,
            'rows' => $value,
            'options' => $options,
        ]);
    }

}
