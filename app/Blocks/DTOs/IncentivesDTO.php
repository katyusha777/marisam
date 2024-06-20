<?php

namespace App\Blocks\DTOs;

use App\Blocks\Concerns\BlockContract;
use App\Models\Blocks\Incentive;
use App\Models\Site;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Override;
use Spatie\LaravelData\Data;

final class IncentivesDTO extends Data implements BlockContract {
    public function __construct(
    ) {
    }

    #[Override]
    public static function example(): View {
        return view('block_examples.incentives');
    }

    public static function novaFields(): array {
        return [
        ];
    }

    public function html(): string {
        $blocks = '';

        /** @var Incentive $incentive */
        foreach (Site::getCurrentSite()->incentives as $incentive) {
            $image = Storage::url($incentive->image);
            $blocks .= <<<EOB
 <div>
        <img src="{$image}" alt="" class="h-24 w-auto">
        <h3 class="mt-6 text-sm font-medium text-gray-900">{$incentive->title}</h3>
        <p class="mt-2 text-sm text-gray-500">{$incentive->text}</p>
      </div>
EOB;
        }

        return <<<EOB
<div class="bg-gray-50">
  <div class="mx-auto max-w-2xl px-4 py-24 sm:px-6 sm:py-32 lg:max-w-7xl lg:px-8">
    <div class="grid grid-cols-1 gap-y-12 sm:grid-cols-2 sm:gap-x-6 lg:grid-cols-4 lg:gap-x-8">
      {$blocks}
    </div>
  </div>
</div>
EOB;
    }
}
