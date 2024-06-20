<?php

namespace App\Enum;

use App\Enum\Concerns\EnumToArray;

enum ThemeEnum: string {
    use EnumToArray;

    case Spotlight = 'spotlight';
    case Salient   = 'salient';
}
