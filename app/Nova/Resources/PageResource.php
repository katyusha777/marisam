<?php

namespace App\Nova\Resources;

use App\Models\Page as PageModel;
use Laravel\Nova\Fields\BelongsTo;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Markdown;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

final class PageResource extends Resource {
    public static $model = PageModel::class;
    public static $title = 'title';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            ID::make()->sortable(),
            Text::make('Title'),
            BelongsTo::make('Parent', 'parent', self::class)->nullable(),
            Image::make('Header image'),
            Markdown::make('Body'),
        ];
    }
}
