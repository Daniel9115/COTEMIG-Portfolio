<header class="music-header">
    <div class="container">
        <div class="music-header-brand">
            <a href="/" class="music-header-logo">
                Música Online
            </a>
        </div>
        <nav class="music-header-nav">

        </nav>
        <div class="music-header-actions">
            <button class="search-button">
                <i class="fas fa-search"></i> Pesquisar
            </button>
            <a href= class="profile-link">
                <i class="fas fa-user-circle"></i> Meu Perfil
            </a>
        </div>
        <button class="music-header-toggler" aria-label="Toggle navigation">
            <span class="toggler-icon"></span>
        </button>
    </div>
</header>

<style>
    /* Estilos básicos para o header */
    .music-header {
        background-color: #282828; /* Cor de fundo escura */
        color: #ffffff; /* Cor do texto */
        padding: 15px 0;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    }

    .music-header .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .music-header-brand .music-header-logo {
        color: #1DB954; /* Verde Spotify-like */
        text-decoration: none;
        font-size: 2em;
        font-weight: bold;
    }

    .music-header-nav ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
    }

    .music-header-nav ul li {
        margin-right: 25px;
    }

    .music-header-nav ul li:last-child {
        margin-right: 0;
    }

    .music-header-nav ul li a {
        color: #ffffff;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .music-header-nav ul li a:hover,
    .music-header-nav ul li a.active {
        color: #1DB954;
    }

    .music-header-actions {
        display: flex;
        align-items: center;
    }

    .music-header-actions .search-button,
    .music-header-actions .profile-link {
        background: none;
        border: none;
        color: #ffffff;
        text-decoration: none;
        font-size: 1em;
        cursor: pointer;
        margin-left: 20px;
        transition: color 0.3s ease;
        display: flex;
        align-items: center;
    }

    .music-header-actions .search-button i,
    .music-header-actions .profile-link i {
        margin-right: 8px;
    }

    .music-header-actions .search-button:hover,
    .music-header-actions .profile-link:hover {
        color: #1DB954;
    }

    /* Ocultar o botão de toggle em telas grandes */
    .music-header-toggler {
        display: none;
    }

    /* Estilos Responsivos */
    @media (max-width: 768px) {
        .music-header .container {
            flex-wrap: wrap;
        }

        .music-header-nav {
            order: 3; /* Coloca a navegação abaixo do logo e ações no mobile */
            flex-basis: 100%; /* Ocupa toda a largura */
            margin-top: 15px;
            display: none; /* Esconde a navegação por padrão no mobile */
        }

        .music-header-nav.active {
            display: block; /* Mostra a navegação quando ativo (via JS) */
        }

        .music-header-nav ul {
            flex-direction: column;
            text-align: center;
        }

        .music-header-nav ul li {
            margin: 10px 0;
        }

        .music-header-toggler {
            display: block; /* Mostra o botão de toggle no mobile */
            background: none;
            border: 1px solid #1DB954;
            color: #1DB954;
            padding: 8px 12px;
            cursor: pointer;
            font-size: 1.2em;
            border-radius: 5px;
        }

        .music-header-actions {
            order: 2; /* Move as ações para o lado do logo */
            margin-left: auto; /* Alinha à direita */
        }
    }
</style>

<script>
    // Exemplo básico de JavaScript para o menu mobile
    document.addEventListener('DOMContentLoaded', function() {
        const toggler = document.querySelector('.music-header-toggler');
        const nav = document.querySelector('.music-header-nav');

        if (toggler && nav) {
            toggler.addEventListener('click', function() {
                nav.classList.toggle('active');
            });
        }
    });
</script>
