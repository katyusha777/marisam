<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use App\Models\Blocks\Testimonial;
use App\Models\Site;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Override;
use Spatie\LaravelData\Data;

final class TestimonialsDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $title,
        public readonly string $content,
    ) {
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.testimonials');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            Textarea::make('Content'),
        ];
    }

    public function html(): string {
        $blocks = '';

        /** @var Testimonial $testimonial */
        foreach (Site::getCurrentSite()->testimonials as $testimonial) {
            $image = Storage::url($testimonial->image);
            $logo  = Storage::url($testimonial->logo);
            $blocks .= <<<EOB
<div class="flex flex-col border-t border-gray-900/10 pt-10 sm:pt-16 lg:border-l lg:border-t-0 lg:pl-8 lg:pt-0 xl:pl-20">
        <img class="h-12 self-start" src="{$logo}" alt="">
        <figure class="mt-10 flex flex-auto flex-col justify-between">
          <blockquote class="text-lg leading-8 text-gray-900">
            <p>{$testimonial->content}</p>
          </blockquote>
          <figcaption class="mt-10 flex items-center gap-x-6">
            <img class="h-14 w-14 rounded-full bg-gray-50" src="{$image}" alt="">
            <div class="text-base">
              <div class="font-semibold text-gray-900">{$testimonial->name}</div>
              <div class="mt-1 text-gray-500">{$testimonial->position}</div>
            </div>
          </figcaption>
        </figure>
      </div>
EOB;
        }

        return <<<EOB
<section class="bg-white py-24 sm:py-32">
  <div class="mx-auto max-w-7xl px-6 lg:px-8">
    <div class="mx-auto grid max-w-2xl grid-cols-1 lg:mx-0 lg:max-w-none lg:grid-cols-2">
      {$blocks}
    </div>
  </div>
</section>
EOB;
    }
}
