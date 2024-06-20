<?php

namespace App\Blocks\Concerns;

use Illuminate\View\View;
use Laravel\Nova\Fields\Field;

interface BlockContract {
    public function html(): string;

    public static function example(): View;

    /**
     * @return array<Field>
     */
    public static function novaFields(): array;
}
