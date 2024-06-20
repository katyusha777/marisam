<?php

namespace App\Blocks\DTOs;

use Illuminate\Support\Facades\Storage;
use Spatie\LaravelData\Data;

final class ImageTextGridBlock extends Data
{
public function __construct(
    public readonly string $title,
    public readonly string $text,
    public string $image,
    public string $buttonText,
    public string $buttonLink,
)
{
    $this->image = Storage::url($this->image);
}
}
