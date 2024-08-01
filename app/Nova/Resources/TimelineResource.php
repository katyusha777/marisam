<?php

namespace App\Nova\Resources;

use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Number;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Fields\Textarea;
use Laravel\Nova\Http\Requests\NovaRequest;

final class TimelineResource extends Resource {
    public static $model = \App\Models\Timeline::class;
    public static $title = 'title';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            Text::make('Title'),
            Number::make('Year'),
            Textarea::make('Text'),
            Image::make('Image'),
        ];
    }
}
