<?php

namespace App\Nova\Resources;

use App\Models\AnnualReport;
use Laravel\Nova\Fields\File;
use Laravel\Nova\Fields\Image;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

final class AnnualReportResource extends Resource {
    public static $model = AnnualReport::class;
    public static $title = 'title';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            Text::make('Title'),
            File::make('File')->disk('public'),
            Image::make('Image'),
        ];
    }
}
