<?php

namespace App\Nova\Resources\SiteResources;

use App\Blocks\Blocks;
use App\Models\Page as PageModel;
use Jangvel\NovaGutenberg\NovaGutenberg;
use Laravel\Nova\Fields\BelongsTo;
use Laravel\Nova\Fields\Boolean;
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
            Text::make('Slug'),
            BelongsTo::make('Parent', 'parent', self::class)->nullable(),
            Image::make('Header image'),
            NovaGutenberg::make('Body'),
            Boolean::make('Is Frontpage', 'is_frontpage'),
            Boolean::make('Is Main CTA Page', 'is_cta_page'),
            Blocks::renderNovaBlocksFlexible(),
        ];
    }
}
