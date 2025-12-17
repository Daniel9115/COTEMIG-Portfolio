<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Tarefas de ') . $user->name }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    @if($tasks->count() > 0)
                        <div class="grid gap-4">
                            @foreach($tasks as $task)
                                <div class="border rounded-lg p-4">
                                    <h3 class="font-semibold text-lg">{{ $task->title }}</h3>
                                    <p class="text-gray-600 mt-2">{{ $task->description }}</p>
                                    <small class="text-gray-500">
                                        Criada em: {{ $task->created_at->format('d/m/Y H:i') }}
                                    </small>
                                </div>
                            @endforeach
                        </div>
                    @else
                        <div class="text-center py-8">
                            <p class="text-gray-500">Nenhuma tarefa encontrada</p>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</x-app-layout>