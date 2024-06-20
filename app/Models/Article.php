<?php

namespace App\Models;

use App\Models\Concerns\HasSlug;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Storage;

/**
 * @property string   $title
 * @property string   $slug
 * @property string   $body
 * @property string   $intro
 * @property string   $image_url
 * @property string   $image
 * @property string   $url
 * @property string   $category_id
 * @property Category $category
 */
final class Article extends Model {
    use HasSlug;

    protected $appends = ['url'];

    public static function getBySlug(string $slug): self {
        return self::where('slug', $slug)->first();
    }

    public function getImageUrlAttribute(): string {
        return Storage::url($this->image);
    }

    public function getIntroAttribute(): string {
        return substr($this->body, 0, 160);
    }

    public function category(): BelongsTo {
        return $this->belongsTo(Category::class);
    }

    public function getUrlAttribute(): string {
        return '/articles/'.$this->slug;
    }
}
