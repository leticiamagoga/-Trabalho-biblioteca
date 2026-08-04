<%@ page contentType="text/html;charset=UTF-8" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4">
    <div class="container">

        <!-- Logo -->
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2"
           href="${pageContext.request.contextPath}/livros?acao=listar">

            <i class="bi bi-journal-bookmark-fill fs-4"></i>
            <span> Book Hub </span>
        </a>

        <!-- Botão Mobile -->
        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#menuNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu -->
        <div class="collapse navbar-collapse" id="menuNavbar">

            <ul class="navbar-nav mx-auto gap-2">

                <li class="nav-item">
                    <a class="nav-link nav-custom"
                       href="${pageContext.request.contextPath}/livros?acao=listar">
                        <i class="bi bi-book-half"></i>
                        Livros
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link nav-custom"
                       href="${pageContext.request.contextPath}/usuarios?acao=listar">
                        <i class="bi bi-people-fill"></i>
                        Usuários
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link nav-custom"
                       href="${pageContext.request.contextPath}/emprestimos?acao=listar">
                        <i class="bi bi-arrow-left-right"></i>
                        Empréstimos
                    </a>
                </li>

            </ul>

            <!-- Sair -->
            <div class="d-flex">
                <a href="${pageContext.request.contextPath}/logout"
                   class="btn btn-outline-light btn-sm px-3">
                    <i class="bi bi-box-arrow-right"></i>
                    Sair
                </a>
            </div>

        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>