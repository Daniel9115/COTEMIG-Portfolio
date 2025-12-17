<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Product::create([
            'name' => 'Smartphone X',
            'description' => 'The latest smartphone with incredible features and a powerful camera.',
            'price' => 799.99,
        ]);

        Product::create([
            'name' => 'Bluetooth Headphones',
            'description' => 'Immerse yourself in rich, clear sound with these comfortable headphones.',
            'price' => 129.50,
        ]);

        Product::create([
            'name' => 'Smartwatch Pro',
            'description' => 'Track your fitness, receive notifications, and stay connected on the go.',
            'price' => 249.00,
        ]);

    }
}
