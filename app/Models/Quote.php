<?php

namespace App\Models;

use Illuminate\Support\Carbon;

/**
 * App\Models\Quote.
 *
 * @property string      $id
 * @property string      $text
 * @property string      $author_name
 * @property string|null $author_image
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 */
final class Quote extends Model {
}
