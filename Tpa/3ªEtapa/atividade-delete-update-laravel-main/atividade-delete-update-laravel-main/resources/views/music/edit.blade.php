@extends('layouts.app')

@section('content')
<div class="container">
    <h1>Edit Music</h1>
    <form action="{{ route('music.update', $music) }}" method="POST">
        @csrf
        @method('PUT')
        @include('music._form')
        <button type="submit" class="btn btn-primary">Update Music</button>
        <a href="{{ route('music.index') }}" class="btn btn-secondary">Cancel</a>
    </form>
</div>
@endsection