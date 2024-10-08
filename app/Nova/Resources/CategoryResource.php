<?php

namespace App\Nova\Resources;

use App\Models\Category as CategoryModel;
use Laravel\Nova\Fields\HasMany;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

final class CategoryResource extends Resource {
    public static $model = CategoryModel::class;
    public static $title = 'title';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            Text::make('Title'),
            Text::make('Slug'),
            HasMany::make('Articles', 'articles', ArticleResource::class),
        ];
    }
}
