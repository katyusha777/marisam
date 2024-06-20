<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use VanOns\Laraberg\Traits\RendersContent;

/**
 * @property string  $title
 * @property string  $slug
 * @property string  $body
 * @property string  $header_image
 * @property bool    $is_cta_page
 * @property ?string $parent_id
 * @property string  $url
 * @property object  $blocks
 * @property bool    $is_frontpage
 * @property Page[]  $children
 */
final class Page extends Model {
    use RendersContent;
    protected $contentColumn = 'body';

    protected $appends = ['url'];
    protected $casts   = [
        'blocks' => 'json',
    ];

    public static function getBySlug(string $slug): self {
        return self::where('slug', $slug)->first();
    }

    public function parent(): BelongsTo {
        return $this->belongsTo(self::class, 'parent_id');
    }

    public function children(): HasMany {
        return $this->hasMany(self::class, 'parent_id');
    }

    public function getUrlAttribute(): string {
        return '/'.$this->slug;
    }
}
