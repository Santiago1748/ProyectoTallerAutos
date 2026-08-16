<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidad.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalle del Empleado</title>
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
  		<h1 style="font-size:20px; text-align:center; margin:0;">Detalle del Empleado</h1>
  		<p style="text-align:center; margin-top:6px; color:#9a9691; font-size:12.5px;">Información registrada en el sistema</p>
	</div>

    <%
        Usuario u = (Usuario) request.getAttribute("usuarioData");
        if (u != null) {
    %>

     <div class="card" style="max-width:900px; margin-left:auto; margin-right:auto;">
      <h2>Datos del empleado</h2>
      <div class="grid cols-2">

          <div class="field">
            <span>Código</span>
            <span class="mono"><%= u.getCodigo() %></span>
          </div>

          <div class="field">
            <span>Usuario</span>
            <span><%= u.getUsuario() %></span>
          </div>

          <div class="field">
            <span>Cargo</span>
            <span><%= u.getNombre_rol() %></span>
          </div>

          <div class="field">
            <span>Estado</span>
            <span><%= u.isEstado() ? "Activo" : "Inactivo" %></span>
          </div>

          <div class="field">
            <span>Apellidos</span>
            <span><%= u.getApellidos() %></span>
          </div>

          <div class="field">
            <span>Nombres</span>
            <span><%= u.getNombres() %></span>
          </div>

          <div class="field">
            <span>Fecha de nacimiento</span>
            <span><%= u.getFecha_nac() %></span>
          </div>

          <div class="field">
            <span>Celular</span>
            <span><%= u.getCelular() %></span>
          </div>

          <div class="field">
            <span>Correo electrónico</span>
            <span><%= u.getCorreo() %></span>
          </div>

          <div class="field">
            <span>Salario</span>
            <span>S/ <%= u.getSalario() %></span>
          </div>

          <div class="field full">
            <a href="UsuarioServlet?tipo=edit&id=<%= u.getId() %>" class="btn btn-amber">Editar datos</a>
          </div>
          
          
          

      </div>
    </div>

    <%
        } else {
    %>
    <div class="card">
        <p class="empty">No se encontró información del empleado.</p>
    </div>
    <%
        }
    %>

</main>
</div>

</body>
</html>