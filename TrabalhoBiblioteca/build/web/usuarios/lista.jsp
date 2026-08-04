<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, MODEL.UsuarioMODEL, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Gerenciamento de Usuários</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <jsp:include page="/navbar.jsp"/>

        <div class="container mt-4">

            <%
                List<UsuarioMODEL> usuarios
                        = (List<UsuarioMODEL>) request.getAttribute("usuarios");
            %>

            <div class="d-flex justify-content-between align-items-center mb-3">

                <div>
                    <h3 class="titulo-pagina mb-0">
                        <i class="bi bi-people-fill"></i>
                        Gerenciamento de Usuários
                    </h3>

                    <small class="subtitulo-pagina">
                        Total de registros:
                        <strong>
                            <%= usuarios != null ? usuarios.size() : 0%>
                        </strong>
                    </small>
                </div>

                <a href="${pageContext.request.contextPath}/usuarios?acao=novo"
                   class="btn btn-success">

                    <i class="bi bi-person-plus-fill"></i>
                    Cadastrar Usuário

                </a>

            </div>

            <% String msg = request.getParameter("msg"); %>

            <% if ("cadastrado".equals(msg)) { %>
            <div class="alert alert-success">
                Usuário cadastrado com sucesso!
            </div>
            <% } %>

            <% if ("atualizado".equals(msg)) { %>
            <div class="alert alert-success">
                Usuário atualizado com sucesso!
            </div>
            <% } %>

            <% if ("excluido".equals(msg)) { %>
            <div class="alert alert-warning">
                Usuário removido.
            </div>
            <% } %>

            <div class="card shadow-sm p-3">

                <div class="table-responsive">

                    <table class="table table-hover align-middle">

                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nome</th>
                                <th>E-mail</th>
                                <th>Nascimento</th>
                                <th>Situação</th>
                                <th>Ações</th>
                            </tr>
                        </thead>

                        <tbody>

                            <%
                                SimpleDateFormat sdf
                                        = new SimpleDateFormat("dd/MM/yyyy");

                                if (usuarios != null && !usuarios.isEmpty()) {

                                    for (UsuarioMODEL u : usuarios) {
                            %>

                            <tr>

                                <td><%= u.getId_usuario()%></td>

                                <td>
                                    <strong><%= u.getNome()%></strong>
                                </td>

                                <td>
                                    <%= u.getEmail() != null
                                    ? u.getEmail()
                                    : "-"%>
                                </td>

                                <td>
                                    <%= u.getData_nascimento() != null
                                    ? sdf.format(u.getData_nascimento())
                                    : "-"%>
                                </td>

                                <td>

                                    <% if ("ativo".equals(u.getStatus())) { %>

                                    <span class="badge bg-primary">
                                        Ativo
                                    </span>

                                    <% } else { %>

                                    <span class="badge bg-dark">
                                        Inativo
                                    </span>

                                    <% }%>

                                </td>

                                <td>

                                    <a href="${pageContext.request.contextPath}/usuarios?acao=editar&id=<%= u.getId_usuario()%>"
                                       class="btn btn-warning btn-sm">

                                        <i class="bi bi-pencil-fill"></i>

                                    </a>

                                    <a href="${pageContext.request.contextPath}/usuarios?acao=excluir&id=<%= u.getId_usuario()%>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Deseja realmente excluir este usuário?')">

                                        <i class="bi bi-trash-fill"></i>

                                    </a>

                                </td>

                            </tr>

                            <%
                                }
                            } else {
                            %>

                            <tr>

                                <td colspan="6"
                                    class="text-center text-muted py-4">

                                    Nenhum usuário encontrado.

                                </td>

                            </tr>

                            <%
                                }
                            %>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </body>
</html>