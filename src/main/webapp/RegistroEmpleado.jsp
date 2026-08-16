<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidad.Rol" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Empleado</title>
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
  <h1 style="font-size:20px; text-align:center; margin:0;">Registro de Nuevo Empleado</h1>
  <p style="text-align:center; margin-top:6px; color:#9a9691; font-size:12.5px;">Crea una nueva cuenta de acceso al sistema</p>
</div>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        String tipoMsg = (mensaje != null && mensaje.contains("correctamente")) ? "ok" : "error";
    %>
    <% if(mensaje != null){ %>
      <div class="toast <%= tipoMsg %>"><%= mensaje %></div>
    <% } %>

     <div class="card" style="max-width:900px; margin-left:auto; margin-right:auto;">
      <h2>Datos del empleado</h2>
      <form action="UsuarioServlet?tipo=regis" method="POST" novalidate>
        <div class="grid cols-2">

          <label class="field">
            <span>Código</span>
            <input type="text" id="txtCod" name="txtCod" required placeholder="Ej: U001">
          </label>

          <label class="field">
            <span>Usuario</span>
            <input type="text" id="txtUsuario" name="txtUsuario" required placeholder="Nombre de usuario">
            
          </label>

          <label class="field">
            <span>Contraseña</span>
            <input type="password" id="txtPassword" name="txtPassword" required placeholder="••••••••">
          </label>
		 <label class="field">
		 <span>Cargo</span>
          <select id="rol" name="rol" required>
 			 <option value="">Seleccione un rol / cargo</option>
  				<%
      				List<Rol> listaRoles = (List<Rol>) request.getAttribute("listadoRoles");
      				if (listaRoles != null) {
         				 for (Rol r : listaRoles) {
 				 %>
          				<option value="<%= r.getId() %>"><%= r.getNombre() %></option>
  				<%
        			  }
     				 }
 				 %>
			</select>
			</label>
          <label class="field">
            <span>¿Es empleado?</span>
            <select id="cboEmpleado" name="cboEmpleado" required>
              <option value="true">Sí</option>
              <option value="false" selected>No</option>
            </select>
          </label>

          <label class="field">
            <span>Estado</span>
            <select id="cboEstado" name="cboEstado" required>
              <option value="true" selected>Activo</option>
              <option value="false">Inactivo</option>
            </select>
          </label>

          <label class="field">
            <span>Apellidos</span>
            <input type="text" id="txtApellidos" name="txtApellidos" required>
          </label>

          <label class="field">
            <span>Nombres</span>
            <input type="text" id="txtNombres" name="txtNombres" required>
          </label>

          <label class="field">
            <span>Fecha de nacimiento</span>
            <input type="date" id="txtFechaNac" name="txtFechaNac" required>
          </label>

          <label class="field">
            <span>Celular</span>
            <input type="text" id="txtCelular" name="txtCelular" placeholder="Ej: 987654321">
          </label>

          <label class="field">
            <span>Correo electrónico</span>
            <input type="email" id="txtCorreo" name="txtCorreo" required placeholder="correo@ejemplo.com">
          </label>

          <label class="field">
            <span>Salario</span>
            <input type="number" step="0.01" id="txtSalario" name="txtSalario" required placeholder="0.00">
          </label>

          <div class="field full">
            <button type="submit" class="btn btn-amber">Registrar empleado</button>
          </div>

        </div>
      </form>
    </div>
</main>
</div>

</body>
</html>