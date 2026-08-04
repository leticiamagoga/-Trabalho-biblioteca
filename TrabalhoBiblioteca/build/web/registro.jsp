<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Hub - Cadastro</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="d-flex align-items-center justify-content-center">

    <div class="card card-auth registro-box">

        <h2 class="text-center auth-title">
            Criar Conta
        </h2>

        <p class="text-center registro-subtitle">
            Cadastre-se para utilizar o sistema da biblioteca
        </p>

        <% if (request.getAttribute("erro") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("erro") %>
            </div>
        <% } %>

        <form method="post"
              action="${pageContext.request.contextPath}/registro">

            <div class="mb-3">
                <label class="form-label">
                    Nome Completo
                </label>

                <input type="text"
                       name="nome"
                       class="form-control"
                       maxlength="150"
                       required
                       value="${nome}">
            </div>

            <div class="mb-3">
                <label class="form-label">
                    E-mail
                </label>

                <input type="email"
                       name="email"
                       class="form-control"
                       maxlength="100"
                       required
                       value="${email}">
            </div>

            <div class="mb-3">
                <label class="form-label">
                    Data de Nascimento
                </label>

                <input type="date"
                       name="dataNascimento"
                       class="form-control"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    Senha
                </label>

                <input type="password"
                       name="senha"
                       class="form-control"
                       minlength="4"
                       required>
            </div>

            <div class="mb-4">
                <label class="form-label">
                    Confirmar Senha
                </label>

                <input type="password"
                       name="confirmarSenha"
                       class="form-control"
                       minlength="4"
                       required>
            </div>

            <button type="submit"
                    class="btn btn-primary w-100">
                Criar Conta
            </button>

        </form>

        <hr>

        <p class="text-center mb-0">
            Já possui conta?

            <a href="${pageContext.request.contextPath}/login"
               class="link-registro">
                Fazer Login
            </a>
        </p>

    </div>

</body>
</html>