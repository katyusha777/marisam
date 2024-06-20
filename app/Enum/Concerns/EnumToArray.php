<?php

namespace App\Enum\Concerns;

trait EnumToArray {
    public static function asSelectArray(): array {
        return array_combine(
            array_map(fn ($case) => $case->value, self::cases()),
            array_map(fn ($case) => $case->name, self::cases())
        );
    }

    public static function asArray(): array {
        return array_map(fn ($case) => $case->name, self::cases());
    }
}
