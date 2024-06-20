<?php

namespace App\Models\Concerns;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

/**
 * @property string $slug
 *
 * @mixin BelongsToSite
 * @mixin Model
 */
trait HasSlug {
    public static function bootHasSlug(): void {
        static::creating(function ($model) {
            if (! $model->slug) {
                $slug = Str::slug($model->name);
                if (static::where('slug', $slug)->where('site_id', $model->site_id)->first()) {
                    $slug = $slug.'-'.Str::random(6);
                }

                $model->slug = $slug;
            }
        });
    }
}
