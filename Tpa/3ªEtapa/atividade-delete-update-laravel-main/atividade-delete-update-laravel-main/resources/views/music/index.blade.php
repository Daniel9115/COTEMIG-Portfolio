@extends('layouts.app')

@section('content')
<div class="container">
    <h1>Music List</h1>
    <a href="{{ route('music.create') }}" class="btn btn-primary mb-3">Add Music</a>
    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Title</th>
                <th>Artist</th>
                <th>Album</th>
                <th>Year</th>
                <th>Genre</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($music as $item)
                <tr>
                    <td>{{ $item->title }}</td>
                    <td>{{ $item->artist }}</td>
                    <td>{{ $item->album }}</td>
                    <td>{{ $item->year }}</td>
                    <td>{{ $item->genre }}</td>
                    <td>
                        <a href="{{ route('music.show', $item) }}" class="btn btn-info btn-sm">View</a>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
