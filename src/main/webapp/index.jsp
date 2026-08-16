<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="util.Constantes" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taller Fortuna — Panel de control</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;600;700&family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="css/index.css">
    
    <style>
        nav a.nav-item {
            text-decoration: none;
            display: flex;
        }
        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
    </style>
</head>


<%
    String nombreSesion = (String) session.getAttribute(Constantes.NAME);
    String apellidoSesion = (String) session.getAttribute(Constantes.LASTNAME);
    if (nombreSesion == null) { nombreSesion = "Invitado"; }
    if (apellidoSesion == null) { apellidoSesion = ""; }
%>

<body>
<div class="shell">
  <aside class="sidebar">
    <div class="brand">
      <div class="brand-mark"></div>
      <div class="brand-text">
        <p class="display">Taller Fortuna</p>
        <span>Panel de gestión</span>
      </div>
    </div>
    
    <nav id="nav">
      <ul>
        <li>
          <a href="resumen.jsp" target="contentFrame" class="nav-item">Resumen</a>
        </li>
        <li>
          <a href="nueva_orden.jsp" target="contentFrame" class="nav-item">Nueva orden</a>
        </li>
        <li>
          <a href="ListarClientes.jsp" target="contentFrame" class="nav-item">Listado de clientes</a>
        </li>
        <li>
          <a href="RegistroCliente.jsp" target="contentFrame" class="nav-item">Registro Clientes</a>
        </li>
   
        <li>
          <a href="VehiculoServlet?tipo=list" target="contentFrame" class="nav-item active">Vehículos</a>
        </li>
        
        <li>
          <a href="repuestos.jsp" target="contentFrame" class="nav-item">Repuestos y servicios</a>
        </li>
        <li>
          <a href="compras.jsp" target="contentFrame" class="nav-item">Compras</a>
        </li>
        <li>
          <a href="UsuarioServlet?tipo=lis" target="contentFrame" class="nav-item">Usuarios</a>
        </li>
        <li>
          <a href="reportes.jsp" target="contentFrame" class="nav-item">Reportes</a>
        </li>
      </ul>
    </nav>
   
    <div class="user-box">
  		<p class="u-name"><%= nombreSesion %> <%= apellidoSesion %></p>
  		<button class="btn-logout" onclick="logout()">Cerrar sesión</button>
	</div>
  </aside>
  
  <main id="main" style="padding: 0; max-width: 100%;">
    <iframe name="contentFrame" id="contentFrame" src="dashboard.jsp" style="width: 100%; height: 100vh; border: none;"></iframe>
  </main>
 
</div>
<script>
    function logout() {
        window.location.href = "LoginServlet?opc=logout";
    }
</script>
</body>
</html>