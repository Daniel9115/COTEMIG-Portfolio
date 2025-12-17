<?php

namespace App\Http\Controllers;

use App\Models\Music;
use Illuminate\Http\Request;

class MusicController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
    $music = \App\Models\Music::all();
    return view('music.index', compact('music'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
    return view('music.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'artist' => 'required|string|max:255',
            'album' => 'nullable|string|max:255',
            'year' => 'nullable|integer|min:1900|max:' . date('Y'),
            'genre' => 'nullable|string|max:255',
        ]);
        \App\Models\Music::create($validated);
        return redirect()->route('music.index')->with('success', 'Music created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Music $music)
    {
    return view('music.show', compact('music'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        $music = Music::findOrFail($id);
        return view('musics.edit', compact('music'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'artist' => 'required|string|max:255',
            'album' => 'required|string|max:255',
            'year' => 'required|integer',
            'genre' => 'required|string|max:255',
        ]);
    
        $music = Music::findOrFail($id);
        $music->update($validated);
    
        return redirect()->route('music.index')->with('success', 'Música atualizada com sucesso!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Music $music)
    {
        $music->delete();
        return redirect()->route('music.index')->with('success', 'Música excluída com sucesso!');
    }
}
