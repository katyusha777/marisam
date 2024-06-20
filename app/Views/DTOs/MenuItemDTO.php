<?php

namespace App\Views\DTOs;

use Illuminate\Support\Str;
use Spatie\LaravelData\Data;

final class MenuItemDTO extends Data {
    public readonly string $slug;

    public function __construct(
        public readonly string $title,
        public readonly string $href,
        /** array<MenuItemDTO> */
        public readonly ?array $children = null,
        public readonly bool $active = false,
    ) {
        $this->slug = Str::slug($this->title);
    }
}
