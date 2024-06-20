<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use Illuminate\View\View;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Override;
use Spatie\LaravelData\Data;

final class ContentDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $heading,
        public readonly string $subheading,
        public readonly string $content,
    ) {
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.content');
    }

    public static function novaFields(): array {
        return [
            Text::make('Heading'),
            Text::make('Subheading'),
            Textarea::make('Content'),
        ];
    }

    public function html(): string {
        return <<<EOB
<div class="bg-white px-6 py-32 lg:px-8">
    <div class="mx-auto max-w-3xl text-base leading-7 text-gray-700">
        <p class="text-base font-semibold leading-7 text-indigo-600">{$this->subheading}</p>
        <h1 class="mt-2 text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">{$this->heading}</h1>
        <p class="mt-6 text-xl leading-8">{$this->content}</p>
    </div>
</div>
EOB;
    }
}
