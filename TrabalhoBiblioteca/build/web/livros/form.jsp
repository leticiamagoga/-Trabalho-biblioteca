<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="MODEL.LivroMODEL" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cadastro de Livro</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <jsp:include page="/navbar.jsp"/>

        <div class="container mt-4" style="max-width:700px">

            <%
                LivroMODEL livro = (LivroMODEL) request.getAttribute("livro");
                boolean editando = livro != null;
                String acaoForm = editando ? "atualizar" : "salvar";
            %>

            <div class="card shadow p-4">

                <div class="mb-4 text-center">
                    <h3 class="titulo-pagina">
                        <i class="bi bi-journal-bookmark-fill"></i>
                        <%= editando ? "Atualizar Livro" : "Cadastrar Livro"%>
                    </h3>

                    <small class="subtitulo-form">
                        Gerencie os livros do acervo da biblioteca.
                    </small>
                </div>

                <% if (request.getAttribute("erro") != null) {%>
                <div class="alert alert-danger">
                    <%= request.getAttribute("erro")%>
                </div>
                <% }%>

                <form method="post" action="${pageContext.request.contextPath}/livros">

                    <input type="hidden" name="acao" value="<%= acaoForm%>">

                    <% if (editando) {%>
                    <input type="hidden"
                           name="idLivro"
                           value="<%= livro.getId_livro()%>">
                    <% }%>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-book"></i>
                            Nome do Livro
                        </label>

                        <input type="text"
                               name="nome"
                               class="form-control"
                               required
                               maxlength="200"
                               value="<%= editando ? livro.getNome() : ""%>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-person-fill"></i>
                            Autor
                        </label>

                        <input type="text"
                               name="autor"
                               class="form-control"
                               required
                               maxlength="150"
                               value="<%= editando ? livro.getAutor() : ""%>">
                    </div>

                    <div class="row">

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-box"></i>
                                Quantidade
                            </label>

                            <input type="number"
                                   name="quantidade"
                                   class="form-control"
                                   min="0"
                                   required
                                   value="<%= editando ? livro.getQuantidade() : "0"%>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-calendar-event"></i>
                                Ano Publicação
                            </label>

                            <input type="number"
                                   name="anoPublicacao"
                                   class="form-control"
                                   min="1000"
                                   max="2099"
                                   value="<%= editando && livro.getAno_publicacao() > 0 ? livro.getAno_publicacao() : ""%>">
                        </div>

                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-people-fill"></i>
                            Faixa Etária
                        </label>

                        <select name="faixaEtaria"
                                class="form-select"
                                required>

                            <option value="">Selecione...</option>

                            <% String[] faixas = {"Livre", "10+", "12+", "14+", "16+", "18+"}; %>

                            <% for (String f : faixas) {%>

                            <option value="<%=f%>"
                                    <%= editando && f.equals(livro.getFaixa_etaria()) ? "selected" : ""%>>
                                <%=f%>
                            </option>

                            <% }%>

                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">
                            <i class="bi bi-tags-fill"></i>
                            Categoria
                        </label>

                        <input type="text"
                               name="categoria"
                               class="form-control"
                               maxlength="100"
                               value="<%= editando && livro.getCategoria() != null ? livro.getCategoria() : ""%>">
                    </div>

                    <div class="d-flex justify-content-end gap-2">

                        <a href="${pageContext.request.contextPath}/livros?acao=listar"
                           class="btn btn-outline-secondary">
                            Voltar
                        </a>

                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle-fill"></i>
                            Salvar Livro
                        </button>

                    </div>

                </form>

            </div>

        </div>

    </body>
</html>