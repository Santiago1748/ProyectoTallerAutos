<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidad.Rol" %>
<%@ page import="entidad.Usuario" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modificar datos del Empleado</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;600;700&family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
</head>
<body>

<div class="shell">
<main style="grid-column: 1 / -1;">
    <div style="max-width:900px; margin:0 auto 20px auto;">
  <div style="display:flex; justify-content:flex-end; margin-bottom:12px;">
    <a href="UsuarioServlet?tipo=lis" class="btn btn-sm">Ver listado</a>
  </div>
  <h1 style="font-size:20px; text-align:center; margin:0;">Modificar datos del empleado</h1>
  <p style="text-align:center; margin-top:6px; color:#9a9691; font-size:12.5px;">Actualiza los datos de la cuenta</p>
</div>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        String tipoMsg = (mensaje != null && mensaje.contains("correctamente")) ? "ok" : "error";
        Usuario usuarioData = (Usuario) request.getAttribute("usuarioData");
    %>
    <% if(mensaje != null){ %>
      <div class="toast <%= tipoMsg %>"><%= mensaje %></div>
    <% } %>

    <div class="card" style="max-width:900px; margin-left:auto; margin-right:auto;">
      <h2>Datos del empleado</h2>
      <form action="UsuarioServlet?tipo=grabaredit" method="POST" novalidate>

        <input type="hidden" name="id" value="<%= usuarioData.getId() %>">

        <div class="grid cols-2">

          <label class="field">
            <span>Código</span>
            <input type="text" id="txtCod" name="txtCod" required
                   value="<%= usuarioData.getCodigo() %>">
          </label>

          <label class="field">
            <span>Usuario</span>
            <input type="text" id="txtUsuario" name="txtUsuario" required
                   value="<%= usuarioData.getUsuario() %>">
          </label>

          <label class="field">
            <span>Contraseña</span>
            <input type="password" id="txtPassword" name="txtPassword"
                   placeholder="Dejar en blanco para no cambiarla">
          </label>

          <label class="field">
            <span>Cargo</span>
            <select id="rol" name="rol" required>
              <option value="">Seleccione un rol / cargo</option>
              <%
                  List<Rol> listaRoles = (List<Rol>) request.getAttribute("listadoRoles");
                  if (listaRoles != null) {
                      for (Rol r : listaRoles) {
                          boolean seleccionado = (r.getId() == usuarioData.getId_rol());
              %>
                      <option value="<%= r.getId() %>" <%= seleccionado ? "selected" : "" %>>
                          <%= r.getNombre() %>
                      </option>
              <%
                      }
                  }
              %>
            </select>
          </label>

          <label class="field">
            <span>¿Es empleado?</span>
            <select id="cboEmpleado" name="cboEmpleado" required>
              <option value="true" <%= usuarioData.isEmpleado() ? "selected" : "" %>>Sí</option>
              <option value="false" <%= !usuarioData.isEmpleado() ? "selected" : "" %>>No</option>
            </select>
          </label>

          <label class="field">
            <span>Estado</span>
            <select id="cboEstado" name="cboEstado" required>
              <option value="true" <%= usuarioData.isEstado() ? "selected" : "" %>>Activo</option>
              <option value="false" <%= !usuarioData.isEstado() ? "selected" : "" %>>Inactivo</option>
            </select>
          </label>

          <label class="field">
            <span>Apellidos</span>
            <input type="text" id="txtApellidos" name="txtApellidos" required
                   value="<%= usuarioData.getApellidos() %>">
          </label>

          <label class="field">
            <span>Nombres</span>
            <input type="text" id="txtNombres" name="txtNombres" required
                   value="<%= usuarioData.getNombres() %>">
          </label>

          <label class="field">
            <span>Fecha de nacimiento</span>
            <input type="date" id="txtFechaNac" name="txtFechaNac" required
                   value="<%= usuarioData.getFecha_nac() != null ? usuarioData.getFecha_nac().toString() : "" %>">
          </label>

          <label class="field">
            <span>Celular</span>
            <input type="text" id="txtCelular" name="txtCelular"
                   value="<%= usuarioData.getCelular() != null ? usuarioData.getCelular() : "" %>">
          </label>

          <label class="field">
            <span>Correo electrónico</span>
            <input type="email" id="txtCorreo" name="txtCorreo" required
                   value="<%= usuarioData.getCorreo() != null ? usuarioData.getCorreo() : "" %>">
          </label>

          <label class="field">
            <span>Salario</span>
            <input type="number" step="0.01" id="txtSalario" name="txtSalario" required
                   value="<%= usuarioData.getSalario() %>">
          </label>

          <div class="field full">
            <button type="submit" class="btn btn-amber">Grabar cambios</button>
          </div>

        </div>
      </form>
    </div>
</main>
</div>

</body>
</html>