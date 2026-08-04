<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>BookHub - Login</title>

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body class="d-flex align-items-center justify-content-center">

        <div class="card card-auth login-box">

            <h2 class="text-center auth-title">
                BookHub
            </h2>

            <p class="text-center login-subtitle">
                Faça login para acessar o sistema
            </p>

            <% if (request.getAttribute("erro") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("erro")%>
            </div>
            <% } %>

            <% if ("registrado".equals(request.getParameter("msg"))) { %>
            <div class="alert alert-success">
                Cadastro realizado com sucesso! Faça login.
            </div>
            <% }%>

            <form method="post"
                  action="${pageContext.request.contextPath}/login">

                <div class="mb-3">
                    <label class="form-label">
                        E-mail
                    </label>

                    <input type="email"
                           name="email"
                           class="form-control"
                           required
                           autofocus>
                </div>

                <div class="mb-4">
                    <label class="form-label">
                        Senha
                    </label>

                    <input type="password"
                           name="senha"
                           class="form-control"
                           required>
                </div>

                <button type="submit"
                        class="btn btn-primary w-100">
                    Entrar
                </button>

            </form>

            <hr>

            <p class="text-center mb-0">
                Não possui conta?

                <a href="${pageContext.request.contextPath}/registro"
                   class="link-registro">
                    Criar conta
                </a>
            </p>

        </div>

    </body>
</html>