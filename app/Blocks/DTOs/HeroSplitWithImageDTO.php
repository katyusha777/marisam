<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Text;
use Override;
use Spatie\LaravelData\Data;

final class HeroSplitWithImageDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $title,
        public readonly string $subtitle,
        public string $image,
        public readonly string $buttonText,
        public readonly string $buttonUrl,
    ) {
        $this->image = Storage::url($this->image);
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.hero_split_with_image');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            Text::make('Subtitle'),
            Image::make('Image'),
            Text::make('Button Text', 'buttonText'),
            Text::make('Button URL', 'buttonUrl'),
        ];
    }

    public function html(): string {
        return <<<EOB
<div class="relative bg-white">
  <div class="mx-auto max-w-7xl lg:grid lg:grid-cols-12 lg:gap-x-8 lg:px-8">
    <div class="px-6 pb-24 pt-10 sm:pb-32 lg:col-span-7 lg:px-0 lg:pb-56 lg:pt-48 xl:col-span-6">
      <div class="mx-auto max-w-2xl lg:mx-0">
        <h1 class="mt-24 text-4xl font-bold tracking-tight text-gray-900 sm:mt-10 sm:text-6xl">{$this->title}</h1>
        <p class="mt-6 text-lg leading-8 text-gray-600">{$this->subtitle}</p>
        <div class="mt-10 flex items-center gap-x-6">
          <a href="{$this->buttonUrl}" class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">{$this->buttonText}</a>
        </div>
      </div>
    </div>
    <div class="relative lg:col-span-5 lg:-mr-8 xl:absolute xl:inset-0 xl:left-1/2 xl:mr-0">
      <img class="aspect-[3/2] w-full bg-gray-50 object-cover lg:absolute lg:inset-0 lg:aspect-auto lg:h-full" src="{$this->image}" alt="">
    </div>
  </div>
</div>

EOB;
    }
}
