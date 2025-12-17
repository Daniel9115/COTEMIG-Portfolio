@extends('layouts.app')

@section('content')
<div class="container">
    <h1>Add Music</h1>
    <form action="{{ route('music.store') }}" method="POST">
        @csrf
        @include('music._form')
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
@endsection
