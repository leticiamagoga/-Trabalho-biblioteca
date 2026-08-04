<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, MODEL.LivroMODEL" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Acervo de Livros</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <jsp:include page="/navbar.jsp"/>

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-4">

                <div>
                    <h3 class="titulo-pagina mb-0">
                        <i class="bi bi-journal-richtext"></i>
                        Acervo de Livros
                    </h3>

                    <small class="subtitulo-pagina">
                        Livros cadastrados no sistema.
                    </small>
                </div>

                <a href="${pageContext.request.contextPath}/livros?acao=novo"
                   class="btn btn-success">

                    <i class="bi bi-plus-circle-fill"></i>
                    Novo Livro

                </a>

            </div>

            <% String msg = request.getParameter("msg"); %>

            <% if ("cadastrado".equals(msg)) { %>
            <div class="alert alert-success">
                Livro cadastrado com sucesso!
            </div>
            <% } %>

            <% if ("atualizado".equals(msg)) { %>
            <div class="alert alert-success">
                Livro atualizado com sucesso!
            </div>
            <% } %>

            <% if ("excluido".equals(msg)) { %>
            <div class="alert alert-warning">
                Livro removido do sistema.
            </div>
            <% } %>

            <div class="table-responsive">

                <table class="table table-bordered table-hover align-middle">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Autor</th>
                            <th>Categoria</th>
                            <th>Faixa Etária</th>
                            <th>Ano</th>
                            <th>Disponibilidade</th>
                            <th>Ações</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            List<LivroMODEL> livros
                                    = (List<LivroMODEL>) request.getAttribute("livros");

                            if (livros != null && !livros.isEmpty()) {

                                for (LivroMODEL l : livros) {
                        %>

                        <tr>

                            <td><%= l.getId_livro()%></td>

                            <td><strong><%= l.getNome()%></strong></td>

                            <td><%= l.getAutor()%></td>

                            <td>
                                <%= l.getCategoria() != null
                                        ? l.getCategoria() : "-"%>
                            </td>

                            <td><%= l.getFaixa_etaria()%></td>

                            <td>
                                <%= l.getAno_publicacao() > 0
                                        ? l.getAno_publicacao() : "-"%>
                            </td>

                            <td>

                                <% if (l.getQuantidade() > 0) {%>

                                <span class="badge bg-primary">
                                    Disponível (<%= l.getQuantidade()%>)
                                </span>

                                <% } else { %>

                                <span class="badge bg-danger">
                                    Indisponível
                                </span>

                                <% }%>

                            </td>

                            <td>

                                <div class="d-flex justify-content-center gap-2">

                                    <a href="${pageContext.request.contextPath}/livros?acao=editar&id=<%= l.getId_livro()%>"
                                       class="btn btn-sm btn-warning">

                                        <i class="bi bi-pencil-square"></i>

                                    </a>

                                    <a href="${pageContext.request.contextPath}/livros?acao=excluir&id=<%= l.getId_livro()%>"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Deseja excluir este livro?')">

                                        <i class="bi bi-trash-fill"></i>

                                    </a>

                                </div>

                            </td>

                        </tr>

                        <%
                            }
                        } else {
                        %>

                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">
                                Nenhum livro cadastrado.
                            </td>
                        </tr>

                        <% }%>

                    </tbody>

                </table>

            </div>

        </div>

    </body>
</html>