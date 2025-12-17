@extends('layouts.app')

@section('content')
<div class="container">
    <h1>Music Details</h1>
    <ul class="list-group">
        <li class="list-group-item"><strong>Title:</strong> {{ $music->title }}</li>
        <li class="list-group-item"><strong>Artist:</strong> {{ $music->artist }}</li>
        <li class="list-group-item"><strong>Album:</strong> {{ $music->album }}</li>
        <li class="list-group-item"><strong>Year:</strong> {{ $music->year }}</li>
        <li class="list-group-item"><strong>Genre:</strong> {{ $music->genre }}</li>
    </ul>
    <a href="{{ route('music.index') }}" class="btn btn-secondary mt-3">Back to List</a>
</div>
@endsection
