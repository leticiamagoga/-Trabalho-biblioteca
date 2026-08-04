<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, MODEL.UsuarioMODEL, MODEL.LivroMODEL, java.time.LocalDate" %>

<!DOCTYPE html>

<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registrar Empréstimo</title>

        ```
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css">

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        ```

    </head>
    <body>

        <jsp:include page="/navbar.jsp"/>

        <div class="container" style="max-width:700px">

            ```
            <div class="card p-4">

                <div class="text-center mb-4">
                    <h3 class="titulo-pagina">
                        <i class="bi bi-journal-arrow-up"></i>
                        Registrar Empréstimo
                    </h3>
                    
                    <small class="subtitulo-form">
                        Selecione o leitor e o livro desejado.
                    </small>
                </div>

                <% if (request.getAttribute("erro") != null) {%>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <%= request.getAttribute("erro")%>
                </div>
                <% } %>

                <form method="post"
                      action="${pageContext.request.contextPath}/emprestimos">

                    <input type="hidden"
                           name="acao"
                           value="salvar">

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-person-fill"></i>
                            Usuário
                        </label>

                        <select name="idUsuario"
                                class="form-select"
                                required>

                            <option value="">
                                Selecione um usuário...
                            </option>

                            <%
                                List<UsuarioMODEL> usuarios
                                        = (List<UsuarioMODEL>) request.getAttribute("usuarios");

                                if (usuarios != null) {
                                    for (UsuarioMODEL u : usuarios) {
                                        if ("ativo".equals(u.getStatus())) {
                            %>

                            <option value="<%= u.getId_usuario()%>">
                                <%= u.getNome()%>
                            </option>

                            <%
                                        }
                                    }
                                }
                            %>

                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-book-fill"></i>
                            Livro
                        </label>

                        <select name="idLivro"
                                class="form-select"
                                required>

                            <option value="">
                                Selecione um livro...
                            </option>

                            <%
                                List<LivroMODEL> livros
                                        = (List<LivroMODEL>) request.getAttribute("livros");

                                if (livros != null) {
                                    for (LivroMODEL l : livros) {
                                        if (l.getQuantidade() > 0) {
                            %>

                            <option value="<%= l.getId_livro()%>">
                                <%= l.getNome()%>
                                - Estoque: <%= l.getQuantidade()%>
                            </option>

                            <%
                                        }
                                    }
                                }
                            %>

                        </select>
                    </div>

                    <div class="row">

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-calendar-event"></i>
                                Data do Empréstimo
                            </label>

                            <input type="date"
                                   name="dataEmprestimo"
                                   class="form-control"
                                   required
                                   value="<%= LocalDate.now()%>">
                        </div>

                        <div class="col-md-6 mb-4">
                            <label class="form-label">
                                <i class="bi bi-calendar-check"></i>
                                Data Prevista
                            </label>

                            <input type="date"
                                   name="dataPrevistaDevolucao"
                                   class="form-control"
                                   required
                                   value="<%= LocalDate.now().plusDays(14)%>">
                        </div>

                    </div>

                    <div class="d-flex justify-content-end gap-2">

                        <a href="${pageContext.request.contextPath}/emprestimos?acao=listar"
                           class="btn btn-secondary">

                            Cancelar

                        </a>

                        <button type="submit"
                                class="btn btn-primary">

                            Registrar Empréstimo

                        </button>

                    </div>

                </form>

            </div>
            ```

        </div>

    </body>
</html>
