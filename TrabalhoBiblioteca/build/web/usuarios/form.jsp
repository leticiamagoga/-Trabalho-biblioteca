<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="MODEL.UsuarioMODEL, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cadastro de Usuário</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <jsp:include page="/navbar.jsp"/>

        <div class="container mt-4">

            <%
                UsuarioMODEL usuario = (UsuarioMODEL) request.getAttribute("usuario");
                boolean editando = usuario != null;
                String acaoForm = editando ? "atualizar" : "salvar";
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            %>

            <div class="card shadow-lg p-4 mx-auto" style="max-width:800px;">

                <div class="text-center mb-4">
                    <i class="bi bi-person-circle"
                       style="font-size:65px;color:#111184;"></i>

                    <h3 class="titulo-pagina">
                        <%= editando ? "Atualizar Usuário" : "Cadastrar Usuário"%>
                    </h3>

                    <small class="subtitulo-form">
                        Preencha os dados abaixo.
                    </small>
                </div>

                <% if (request.getAttribute("erro") != null) {%>
                <div class="alert alert-danger">
                    <%= request.getAttribute("erro")%>
                </div>
                <% }%>

                <form method="post"
                      action="${pageContext.request.contextPath}/usuarios">

                    <input type="hidden"
                           name="acao"
                           value="<%= acaoForm%>">

                    <% if (editando) {%>
                    <input type="hidden"
                           name="idUsuario"
                           value="<%= usuario.getId_usuario()%>">
                    <% }%>

                    <div class="row">

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                Nome Completo
                            </label>

                            <input type="text"
                                   name="nome"
                                   class="form-control"
                                   required
                                   maxlength="150"
                                   value="<%= editando ? usuario.getNome() : ""%>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                E-mail
                            </label>

                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   maxlength="100"
                                   value="<%= editando && usuario.getEmail() != null ? usuario.getEmail() : ""%>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                Senha
                            </label>

                            <input type="password"
                                   name="senha"
                                   class="form-control"
                                   required
                                   maxlength="255"
                                   value="<%= editando ? usuario.getSenha() : ""%>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                Data de Nascimento
                            </label>

                            <input type="date"
                                   name="dataNascimento"
                                   class="form-control"
                                   required
                                   value="<%= editando && usuario.getData_nascimento() != null ? sdf.format(usuario.getData_nascimento()) : ""%>">
                        </div>

                        <div class="col-md-12 mb-4">
                            <label class="form-label">
                                Situação
                            </label>

                            <select name="status"
                                    class="form-select"
                                    required>

                                <option value="ativo"
                                        <%= editando && "ativo".equals(usuario.getStatus()) ? "selected" : ""%>>
                                    Ativo
                                </option>

                                <option value="inativo"
                                        <%= editando && "inativo".equals(usuario.getStatus()) ? "selected" : ""%>>
                                    Inativo
                                </option>

                            </select>
                        </div>

                    </div>

                    <div class="text-center">

                        <button type="submit"
                                class="btn btn-primary px-4">

                            <i class="bi bi-check-circle-fill"></i>
                            Salvar
                        </button>

                        <a href="${pageContext.request.contextPath}/usuarios?acao=listar"
                           class="btn btn-secondary px-4">

                            <i class="bi bi-arrow-left-circle"></i>
                            Voltar

                        </a>

                    </div>

                </form>

            </div>

        </div>

    </body>
</html>