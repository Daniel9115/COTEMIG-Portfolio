<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Task;
use App\Models\User;
use Illuminate\Support\Facades\Http;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $tasks = Task::all();
        return view('tasks.index', compact('tasks'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $quote = null;
        
        try {
            $response = Http::timeout(10)->get('https://api.quotable.io/random', [
                'tags' => 'wisdom',
            ]);
            
            if ($response->successful()) {
                $quoteData = $response->json();
                $quote = [
                    'content' => $quoteData['content'],
                    'author' => $quoteData['author'],
                ];
            }
        } catch (\Exception $e) {
            $quote = [
                'content' => 'A persistência é o caminho do êxito.',
                'author' => 'Charles Chaplin'
            ];
        }
        
        return view('tasks.create', compact('quote'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'title' => [
                'required',
                'string',
                'max:255',
                function ($attribute, $value, $fail) {
                    if (strlen(trim($value)) < 3) {
                        $fail('O título deve ter pelo menos 3 caracteres.');
                    }
                }
            ],
            'description' => 'nullable|string|max:1000',
        ]);

        $request->user()->tasks()->create($validatedData);

        return redirect()->route('tasks.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Task $task)
    {
        if (auth()->id() !== $task->user_id) {
            return redirect()->back()->with('error', 'Você não tem permissão para excluir esta tarefa!');
        }

        $task->delete();

        return redirect()->back();
    }

    /**
     * Display tasks for a specific user.
     */
    public function userTasks(User $user)
    {
        $tasks = $user->tasks()->latest()->get();
        
        return view('tasks.user-index', [
            'tasks' => $tasks,
            'user' => $user
        ]);
    }
}
