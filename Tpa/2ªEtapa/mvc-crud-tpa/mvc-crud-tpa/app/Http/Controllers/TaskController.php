<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index()
    {
        $tasks = Task::all();
        return view('tasks.index', compact('tasks'));
    }

    public function create()
    {
        return view('tasks.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|max:255',
            'description' => 'nullable',
            'status' => 'required|in:pendente,em progresso,concluída',
        ]);

        Task::create($validated);

        return redirect('/tasks')->with('success', 'Tarefa criada com sucesso!');
    }

    public function show(Task $task) {}
    public function edit(Task $task) {}
    public function update(Request $request, Task $task) {}
    public function destroy(Task $task) {}
}
