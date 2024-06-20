<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use App\Models\Blocks\TeamMember;
use App\Models\Site;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Override;
use Spatie\LaravelData\Data;

final class TeamDTO extends Data implements BlockContract {
    public function __construct(
        public readonly string $title,
        public readonly string $content,
    ) {
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.team');
    }

    public static function novaFields(): array {
        return [
            Text::make('Title'),
            Textarea::make('Content'),
        ];
    }

    public function html(): string {
        $blocks = '';

        /** @var TeamMember $teamMember */
        foreach (Site::getCurrentSite()->teamMembers as $teamMember) {
            $image = Storage::url($teamMember->image);
            $blocks .= <<<EOB
 <li>
        <img class="aspect-[3/2] w-full rounded-2xl object-cover" src="{$image}" alt="">
        <h3 class="mt-6 text-lg font-semibold leading-8 tracking-tight text-gray-900">{$teamMember->name}</h3>
        <p class="text-base leading-7 text-gray-600">{$teamMember->position}</p>
      </li>
EOB;
        }

        return <<<EOB
<div class="bg-white py-24 sm:py-32">
  <div class="mx-auto max-w-7xl px-6 lg:px-8">
    <div class="mx-auto max-w-2xl lg:mx-0">
      <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">{$this->title}</h2>
      <p class="mt-6 text-lg leading-8 text-gray-600">{$this->content}</p>
    </div>
    <ul role="list" class="mx-auto mt-20 grid max-w-2xl grid-cols-1 gap-x-8 gap-y-16 sm:grid-cols-2 lg:mx-0 lg:max-w-none lg:grid-cols-3">
     {$blocks}
    </ul>
  </div>
</div>
EOB;
    }
}
