<?php

namespace App\Nova\Resources;

use App\Models\Faq;
use Laravel\Nova\Fields\Markdown;
use Laravel\Nova\Fields\Select;
use Laravel\Nova\Fields\Text;
use Laravel\Nova\Http\Requests\NovaRequest;

class FaqResource extends Resource {
    public static $model = Faq::class;
    public static $title = 'question';
    public static $group = 'Content';

    public function fields(NovaRequest $request): array {
        return [
            Text::make('Question'),
            Markdown::make('Answer'),
            Select::make('Type')->options(['faq' => 'FAQ', 'map' => 'Map']),
        ];
    }
}
