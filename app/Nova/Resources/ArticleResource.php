<?php

namespace App\Nova\Resources;

use App\Models\Article as ArticleModel;
use Laravel\Nova\Fields\BelongsTo;
use Laravel\Nova\Fields\ID;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Markdown;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

final class ArticleResource extends Resource {
    public static $model = ArticleModel::class;
    public static $title = 'title';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            ID::make()->sortable(),
            Text::make('Title'),
            //            Text::make('Slug'),
            Image::make('Image'),
            Markdown::make('Body'),
            BelongsTo::make('Category', 'category', CategoryResource::class)->nullable(),
        ];
    }
}
