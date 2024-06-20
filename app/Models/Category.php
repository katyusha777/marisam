<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * @property string              $title
 * @property string              $slug
 * @property Collection<Article> $articles
 */
final class Category extends Model {
    public function articles(): HasMany {
        return $this->hasMany(Article::class);
    }
}
