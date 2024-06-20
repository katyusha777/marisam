<?php

namespace App\Models\Concerns;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

/**
 * @property string $slug
 *
 * @mixin Model
 */
trait HasSlug {
    public static function bootHasSlug(): void {
        static::creating(function ($model) {
            if (! $model->slug) {
                $slug = Str::slug($model->title);

                $model->slug = $slug;
            }
        });
    }
}
