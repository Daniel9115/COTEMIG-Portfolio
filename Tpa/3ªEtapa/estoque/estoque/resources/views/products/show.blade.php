<x-app-layout>
    <x-slot name="header">
        <div class="flex justify-between items-center">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ __('Detalhes do Produto') }}
            </h2>
            <div class="space-x-2">
                <a href="{{ route('products.edit', $product) }}" 
                   class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-2 px-4 rounded">
                    Editar
                </a>
                <a href="{{ route('products.index') }}" 
                   class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded">
                    Voltar
                </a>
            </div>
        </div>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Informações do Produto</h3>
                            
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700">Nome</label>
                                <p class="mt-1 text-sm text-gray-900">{{ $product->nome }}</p>
                            </div>

                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700">Descrição</label>
                                <p class="mt-1 text-sm text-gray-900">{{ $product->descricao }}</p>
                            </div>
                        </div>

                        <div>
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Estoque e Preço</h3>
                            
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700">Quantidade em Estoque</label>
                                <p class="mt-1 text-sm text-gray-900">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                        {{ $product->quantidade > 10 ? 'bg-green-100 text-green-800' : ($product->quantidade > 0 ? 'bg-yellow-100 text-yellow-800' : 'bg-red-100 text-red-800') }}">
                                        {{ $product->quantidade }} unidades
                                    </span>
                                </p>
                            </div>

                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700">Preço Unitário</label>
                                <p class="mt-1 text-lg font-semibold text-gray-900">
                                    R$ {{ number_format($product->preco, 2, ',', '.') }}
                                </p>
                            </div>

                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700">Valor Total em Estoque</label>
                                <p class="mt-1 text-lg font-semibold text-green-600">
                                    R$ {{ number_format($product->preco * $product->quantidade, 2, ',', '.') }}
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="mt-6 pt-6 border-t border-gray-200">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 text-sm text-gray-500">
                            <div>
                                <strong>Criado em:</strong> {{ $product->created_at->format('d/m/Y H:i') }}
                            </div>
                            <div>
                                <strong>Última atualização:</strong> {{ $product->updated_at->format('d/m/Y H:i') }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>