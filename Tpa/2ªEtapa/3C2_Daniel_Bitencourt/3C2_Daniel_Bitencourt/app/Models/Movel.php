<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Movel extends Model
{
    protected $table = 'movels';

    protected $fillable = ['tipo', 'material','descricao'];

}
