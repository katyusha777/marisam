<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Override;
use Spatie\LaravelData\Data;

final class CtaWithImageTilesDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $title,
        public readonly string $content,
        public readonly string $buttonText,
        public readonly string $buttonUrl,
        public string $image_1,
        public string $image_2,
        public string $image_3,
        public string $image_4,
    ) {
        $this->image_1 = Storage::url($this->image_1);
        $this->image_2 = Storage::url($this->image_2);
        $this->image_3 = Storage::url($this->image_3);
        $this->image_4 = Storage::url($this->image_4);
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.cta_with_image_tiles');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            Textarea::make('Content'),
            Text::make('Button Text', 'buttonText'),
            Text::make('Button URL', 'buttonUrl'),
            Image::make('Image 1', 'image_1'),
            Image::make('Image 2', 'image_2'),
            Image::make('Image 3', 'image_3'),
            Image::make('Image 4', 'image_4'),
        ];
    }

    public function html(): string {
        return <<<EOB
<div class="overflow-hidden bg-white py-32">
  <div class="mx-auto max-w-7xl px-6 lg:flex lg:px-8">
    <div class="mx-auto grid max-w-2xl grid-cols-1 gap-x-12 gap-y-16 lg:mx-0 lg:min-w-full lg:max-w-none lg:flex-none lg:gap-y-8">
      <div class="lg:col-end-1 lg:w-full lg:max-w-lg lg:pb-8">
        <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">{$this->title}</h2>
        <p class="mt-6 text-xl leading-8 text-gray-600">{$this->content}</p>
        <div class="mt-10 flex">
          <a href="{$this->buttonUrl}" class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">{$this->buttonText} <span aria-hidden="true">&rarr;</span></a>
        </div>
      </div>
      <div class="flex flex-wrap items-start justify-end gap-6 sm:gap-8 lg:contents">
        <div class="w-0 flex-auto lg:ml-auto lg:w-auto lg:flex-none lg:self-end">
          <img src="{$this->image_1}" alt="" class="aspect-[7/5] w-[37rem] max-w-none rounded-2xl bg-gray-50 object-cover">
        </div>
        <div class="contents lg:col-span-2 lg:col-end-2 lg:ml-auto lg:flex lg:w-[37rem] lg:items-start lg:justify-end lg:gap-x-8">
          <div class="order-first flex w-64 flex-none justify-end self-end lg:w-auto">
            <img src="{$this->image_2}" alt="" class="aspect-[4/3] w-[24rem] max-w-none flex-none rounded-2xl bg-gray-50 object-cover">
          </div>
          <div class="flex w-96 flex-auto justify-end lg:w-auto lg:flex-none">
            <img src="{$this->image_3}" alt="" class="aspect-[7/5] w-[37rem] max-w-none flex-none rounded-2xl bg-gray-50 object-cover">
          </div>
          <div class="hidden sm:block sm:w-0 sm:flex-auto lg:w-auto lg:flex-none">
            <img src="{$this->image_4}" alt="" class="aspect-[4/3] w-[24rem] max-w-none rounded-2xl bg-gray-50 object-cover">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

EOB;
    }
}
