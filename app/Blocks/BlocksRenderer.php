<?php

namespace App\Blocks;

use App\Models\Page;
use phpDocumentor\Reflection\Types\ClassString;
use Spatie\LaravelData\Data;

abstract class BlocksRenderer {
    public static function renderBlocks(Page $page, bool $demo = false): string {
        $blocks = '';

        foreach ($page->blocks as $block) {
            /** @var ClassString<Data> $class */
            $class = $block['layout'];
            $data  = $block['attributes'];

            if ($demo) {
                $blocks .= $class::example();
            } else {
                $dto = $class::from($data);
                $blocks .= $dto->html();
            }
        }

        return $blocks;
    }
}
