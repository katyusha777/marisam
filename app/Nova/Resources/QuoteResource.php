<?php

namespace App\Nova\Resources;

use App\Models\Quote;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Laravel\Nova\Http\Requests\NovaRequest;

final class QuoteResource extends Resource {
    public static $model = Quote::class;
    public static $title = 'author_name';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            Text::make('Author Name'),
            Textarea::make('Text'),
            Image::make('Author Image'),
        ];
    }
}
