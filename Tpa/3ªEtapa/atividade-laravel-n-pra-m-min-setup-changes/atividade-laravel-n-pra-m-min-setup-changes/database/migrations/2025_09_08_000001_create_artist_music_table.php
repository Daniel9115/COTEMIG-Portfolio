<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('artist_music', function (Blueprint $table) {
            $table->foreignId('artist_id')->constrained('artists')->onDelete('cascade');
            $table->foreignId('music_id')->constrained('musics')->onDelete('cascade');
            $table->primary(['artist_id', 'music_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('artist_music');
    }
};