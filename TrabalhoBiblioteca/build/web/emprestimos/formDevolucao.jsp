<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="MODEL.EmprestimoMODEL, java.text.SimpleDateFormat, java.time.LocalDate" %>

<!DOCTYPE html>

<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Finalizar Empréstimo</title>

```
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">
```

</head>
<body>

<jsp:include page="/navbar.jsp"/>

<div class="container" style="max-width:650px">

```
<%
    EmprestimoMODEL emp =
        (EmprestimoMODEL) request.getAttribute("emprestimo");

    SimpleDateFormat sdf =
        new SimpleDateFormat("dd/MM/yyyy");
%>

<div class="card p-4">

    <div class="text-center mb-4">

        <h3 class="auth-title">
            <i class="bi bi-arrow-return-left"></i>
            Finalizar Empréstimo
        </h3>

        <p class="text-muted mb-0">
            Confirme os dados abaixo para registrar a devolução.
        </p>

    </div>

    <% if (request.getAttribute("erro") != null) { %>

        <div class="alert alert-danger">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <%= request.getAttribute("erro") %>
        </div>

    <% } %>

    <% if (emp != null) { %>

    <div class="card mb-4 shadow-sm border-0"
         style="background: rgba(255,255,255,.85)">

        <div class="card-body">

            <div class="row">

                <div class="col-md-6 mb-3">
                    <strong>Leitor:</strong><br>
                    <%= emp.getNome_usuario() %>
                </div>

                <div class="col-md-6 mb-3">
                    <strong>Livro:</strong><br>
                    <%= emp.getNome_livro() %>
                </div>

            </div>

            <hr>

            <div class="row">

                <div class="col-md-6">
                    <strong>Data do Empréstimo:</strong><br>
                    <%= sdf.format(emp.getData_emprestimo()) %>
                </div>

                <div class="col-md-6">
                    <strong>Prazo de Devolução:</strong><br>
                    <%= sdf.format(emp.getData_prevista_devolucao()) %>
                </div>

            </div>

        </div>

    </div>

    <form method="post"
          action="${pageContext.request.contextPath}/emprestimos">

        <input type="hidden"
               name="acao"
               value="confirmarDevolucao">

        <input type="hidden"
               name="idEmprestimo"
               value="<%= emp.getId_emprestimo() %>">

        <div class="mb-4">

            <label class="form-label">
                <i class="bi bi-calendar-check-fill"></i>
                Data da Devolução
            </label>

            <input type="date"
                   name="dataRealDevolucao"
                   class="form-control"
                   required
                   value="<%= LocalDate.now() %>">

            <div class="form-text">
                Caso exista atraso, a multa será calculada automaticamente.
            </div>

        </div>

        <div class="d-flex justify-content-end gap-2">

            <a href="${pageContext.request.contextPath}/emprestimos?acao=listar"
               class="btn btn-secondary px-4">

                Cancelar

            </a>

            <button type="submit"
                    class="btn btn-primary px-4">

                <i class="bi bi-check-circle-fill"></i>
                Confirmar Devolução

            </button>

        </div>

    </form>

    <% } %>

</div>
```

</div>

</body>
</html>
