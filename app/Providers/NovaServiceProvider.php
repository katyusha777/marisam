<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Laravel\Nova\Actions\ActionEvent;
use Laravel\Nova\Nova;
use Laravel\Nova\NovaApplicationServiceProvider;

class NovaServiceProvider extends NovaApplicationServiceProvider {
    /**
     * Bootstrap any application services.
     */
    public function boot() {
        parent::boot();
        ActionEvent::saving(fn ($actionEvent) => false);
    }

    /**
     * Get the tools that should be listed in the Nova sidebar.
     *
     * @return array
     */
    public function tools() {
        return [];
    }

    /**
     * Register any application services.
     */
    public function register() {
    }

    /**
     * Register the Nova routes.
     */
    protected function routes() {
        Nova::routes()
            ->withAuthenticationRoutes()
            ->withPasswordResetRoutes()
            ->register();
    }

    /**
     * Register the Nova gate.
     *
     * This gate determines who can access Nova in non-local environments.
     */
    protected function gate() {
        Gate::define('viewNova', function ($user) {
            return in_array($user->email, [
            ]);
        });
    }

    /**
     * Get the dashboards that should be listed in the Nova sidebar.
     *
     * @return array
     */
    protected function dashboards() {
        return [
            new \App\Nova\Dashboards\Main(),
        ];
    }
}