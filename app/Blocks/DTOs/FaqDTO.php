<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use Illuminate\View\View;
use Laravel\Nova\Fields\KeyValue;
use Laravel\Nova\Fields\Text;
use Override;
use Spatie\LaravelData\Data;

final class FaqDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $title,
        public readonly array $keyValues
    ) {
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.faq');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            KeyValue::make('Items', 'keyValues'),
        ];
    }

    public function html(): string {
        $keyValueContent = '';

        foreach ($this->keyValues as $k => $v) {
            $keyValueContent .= <<<EOB
<div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                <dt class="text-base font-semibold leading-7 text-gray-900 lg:col-span-5">{$k}</dt>
                <dd class="mt-4 lg:col-span-7 lg:mt-0">
                    <p class="text-base leading-7 text-gray-600">{$v}</p>
                </dd>
            </div>
EOB;
        }

        return <<<EOB
<div class="bg-white">
    <div class="mx-auto max-w-7xl divide-y divide-gray-900/10 px-6 py-24 sm:py-32 lg:px-8 lg:py-40">
        <h2 class="text-2xl font-bold leading-10 tracking-tight text-gray-900">{$this->title}</h2>
        <dl class="mt-10 space-y-8 divide-y divide-gray-900/10">
            {$keyValueContent}
        </dl>
    </div>
</div>

EOB;
    }
}
