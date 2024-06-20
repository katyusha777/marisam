<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use Illuminate\View\View;
use Laravel\Nova\Fields\KeyValue;
use Laravel\Nova\Fields\Text;
use Override;
use Spatie\LaravelData\Data;

final class DescriptionListDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $title,
        public readonly string $subtitle,
        public readonly array $keyValues
    ) {
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.description-list');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            Text::make('Subtitle'),
            KeyValue::make('Items', 'keyValues'),
        ];
    }

    public function html(): string {
        $keyValueContent = '';

        foreach ($this->keyValues as $k => $v) {
            $keyValueContent .= <<<EOB
<div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
    <dt class="text-sm font-medium leading-6 text-gray-900">{$k}</dt>
    <dd class="mt-1 text-sm leading-6 text-gray-700 sm:col-span-2 sm:mt-0">{$v}</dd>
</div>
EOB;
        }

        return <<<EOB
<div class="mx-auto max-w-7xl px-6 lg:px-8 mt-32">
  <div class="px-4 sm:px-0">
    <h3 class="text-base font-semibold leading-7 text-gray-900">{$this->title}</h3>
    <p class="mt-1 max-w-2xl text-sm leading-6 text-gray-500">{$this->subtitle}</p>
  </div>
  <div class="mt-6 border-t border-gray-100">
    <dl class="divide-y divide-gray-100">
      {$keyValueContent}
    </dl>
  </div>
</div>
EOB;
    }
}
