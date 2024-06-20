<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Laravel\Nova\Auth\Impersonatable;
use Laravel\Sanctum\HasApiTokens;

/**
 * @property bool   $is_admin
 * @property string $site_id
 * @property Site   $site
 */
final class User extends Authenticatable {
    use HasApiTokens;
    use HasFactory;
    use Impersonatable;
    use Notifiable;

    public $incrementing = false;
    protected $keyType   = 'string';

    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password'          => 'hashed',
    ];

    public static function booted(): void {
        parent::booted();

        self::creating(function ($model) {
            $model->id = Str::uuid();
        });
    }

    public function canImpersonate(): bool {
        return $this->is_admin;
    }

    public function canBeImpersonated(): bool {
        return (bool) $this->site_id;
    }

    public static function isAdmin(): bool {
        return self::me()?->is_admin ?? false;
    }

    public static function getCurrentSite(): ?Site {
        return self::me()?->site;
    }

    public static function getSiteId(): ?string {
        return self::me()?->site_id;
    }

    public static function me(): ?self {
        return Auth::user();
    }

    public function site(): BelongsTo {
        return $this->belongsTo(Site::class);
    }
}
