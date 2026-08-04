<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, MODEL.EmprestimoMODEL, java.text.SimpleDateFormat" %>

<!DOCTYPE html>

<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Controle de Empréstimos</title>

        ```
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css?v=2">
        ```

    </head>
    <body>

        <jsp:include page="/navbar.jsp"/>

        <div class="container my-4">

            ```
            <div class="d-flex justify-content-between align-items-center mb-4">

                <div>
                    <h3 class="titulo-pagina mb-0">
                        <i class="bi bi-journal-bookmark-fill"></i>
                        Controle de Empréstimos
                    </h3>

                    <small class="subtitulo-pagina">
                        Histórico completo das movimentações da biblioteca
                    </small>
                </div>

                <a href="${pageContext.request.contextPath}/emprestimos?acao=novo"
                   class="btn btn-success">

                    <i class="bi bi-plus-circle-fill"></i>
                    Novo Registro

                </a>

            </div>

            <% String msg = request.getParameter("msg"); %>

            <% if ("cadastrado".equals(msg)) { %>
            <div class="alert alert-success">
                Empréstimo registrado com sucesso!
            </div>
            <% } %>

            <% if ("devolvido".equals(msg)) { %>
            <div class="alert alert-success">
                Livro devolvido com sucesso!
            </div>
            <% } %>

            <% if ("excluido".equals(msg)) { %>
            <div class="alert alert-warning">
                Registro removido.
            </div>
            <% } %>

            <% if (request.getAttribute("erro") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("erro")%>
            </div>
            <% } %>

            <div class="table-responsive">

                <table class="table table-bordered table-hover align-middle">

                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Leitor</th>
                            <th>Livro</th>
                            <th>Retirada</th>
                            <th>Prazo</th>
                            <th>Devolução</th>
                            <th>Multa</th>
                            <th>Situação</th>
                            <th>Ações</th>
                            <th>Remover</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            List<EmprestimoMODEL> emprestimos
                                    = (List<EmprestimoMODEL>) request.getAttribute("emprestimos");

                            SimpleDateFormat sdf
                                    = new SimpleDateFormat("dd/MM/yyyy");

                            if (emprestimos != null && !emprestimos.isEmpty()) {

                                for (EmprestimoMODEL e : emprestimos) {
                        %>

                        <tr>

                            <td><%= e.getId_emprestimo()%></td>

                            <td>
                                <strong><%= e.getNome_usuario()%></strong>
                            </td>

                            <td><%= e.getNome_livro()%></td>

                            <td>
                                <%= e.getData_emprestimo() != null
                                        ? sdf.format(e.getData_emprestimo())
                                        : "-"%>
                            </td>

                            <td>
                                <%= e.getData_prevista_devolucao() != null
                                        ? sdf.format(e.getData_prevista_devolucao())
                                        : "-"%>
                            </td>

                            <td>
                                <%= e.getData_real_devolucao() != null
                                        ? sdf.format(e.getData_real_devolucao())
                                        : "-"%>
                            </td>

                            <td>

                                <% if (e.getMulta() != null && e.getMulta().doubleValue() > 0) {%>

                                <span class="fw-bold text-danger">
                                    R$ <%= String.format("%.2f", e.getMulta())%>
                                </span>

                                <% } else { %>

                                <span class="text-success">
                                    Sem multa
                                </span>

                                <% } %>

                            </td>

                            <td>

                                <%
                                    String badge = "bg-secondary";

                                    if ("Emprestado".equals(e.getStatus()))
                                        badge = "bg-primary";

                                    else if ("Devolvido".equals(e.getStatus()))
                                        badge = "bg-success";

                                    else if ("Atrasado".equals(e.getStatus()))
                                        badge = "bg-danger";
                                %>

                                <span class="badge <%= badge%> px-3 py-2">
                                    <%= e.getStatus()%>
                                </span>

                            </td>

                            <td>

                                <% if ("Emprestado".equals(e.getStatus())) {%>

                                <a href="${pageContext.request.contextPath}/emprestimos?acao=devolver&id=<%= e.getId_emprestimo()%>"
                                   class="btn btn-sm btn-primary">

                                    <i class="bi bi-arrow-return-left"></i>
                                    Devolver

                                </a>

                                <% } else { %>

                                <button class="btn btn-sm btn-secondary" disabled>
                                    Finalizado
                                </button>

                                <% }%>

                            </td>

                            <td>

                                <a href="${pageContext.request.contextPath}/emprestimos?acao=excluir&id=<%= e.getId_emprestimo()%>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Deseja realmente excluir este registro?')">

                                    <i class="bi bi-trash-fill"></i>

                                </a>

                            </td>

                        </tr>

                        <%
                            }
                        } else {
                        %>

                        <tr>
                            <td colspan="10"
                                class="text-center text-muted py-4">

                                Nenhum empréstimo registrado.

                            </td>
                        </tr>

                        <% }%>

                    </tbody>

                </table>

            </div>
            ```

        </div>

    </body>
</html>
