<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use App\Models\Blocks\TeamMember;
use App\Models\Site;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Override;
use Spatie\LaravelData\Data;
use Naoray\NovaJson\JSON;
use Whitecube\NovaFlexibleContent\Flexible;

final class ImageTextGrid extends Data implements BlockContract {
protected $blocks = [];
    /**
     * @param string $title
     */
    public function __construct(
        public readonly string $title,
        public readonly string $subtitle,
        public readonly array $gridBlocks,
    ) {
        foreach($this->gridBlocks as $block) {
            $this->blocks[] = ImageTextGridBlock::from($block['attributes']);
        }
    }

    public static function from(...$payloads): static
    {
//        dd($payloads);
        return parent::from(...$payloads);
    }


    #[Override]
    public static function example(): View {
        return view('block_examples.image_text_grid');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            Textarea::make('Subtitle'),
            Flexible::make('Grid Blocks', 'gridBlocks')
            ->addLayout('gridBlocks', 'gridBlock', [
                Text::make('Title'),
                Text::make('Text'),
                Text::make('Button text', 'buttonText'),
                Text::make('Button link', 'buttonLink'),
                Image::make('Image'),
            ])

        ];
    }

    public function html(): string {
        $blocks = '';

        foreach ($this->blocks as $block) {
            $blocks .= <<<EOB
<li class="flex flex-col gap-6">
        <img class="aspect-[4/5] w-full mb-4 flex-none rounded-2xl object-cover" src="{$block->image}" alt="">
        <div class="flex-auto">
          <h3 class="text-lg font-semibold leading-8 tracking-tight text-gray-900">{$block->title}</h3>
          <p class="mt-6 text-base leading-7 text-gray-600">{$block->text}</p>
          <a href="{$block->buttonLink}" class="mt-10 mt-4 inline-block rounded-md bg-indigo-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">{$block->buttonText}</a>   </div>
      </li>
EOB;
        }

        return <<<EOB
<div class="bg-white py-24 sm:py-32">
  <div class="mx-auto max-w-7xl px-6 lg:px-8">
    <div class="mx-auto max-w-2xl sm:text-center">
      <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">{$this->title}</h2>
      <p class="mt-6 text-lg leading-8 text-gray-600">{$this->subtitle}</p>
    </div>
    <ul role="list" class="mx-auto mt-20 grid max-w-2xl grid-cols-2 gap-x-6 gap-y-20 sm:grid-cols-4 lg:max-w-4xl lg:gap-x-8 xl:max-w-none">
        {$blocks}
    </ul>
  </div>
</div>

EOB;
    }
}
