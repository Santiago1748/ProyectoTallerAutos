<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;600;700&family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet">
<!-- Referencia a tu archivo CSS externo -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reportes.css">
</head>
<body>
 <div>
    <main>
      <div>

      <section class="view" id="view-reportes">
        <div class="section-title"><h2>Reportes</h2></div>
        <div class="grid-2">
          <div class="panel">
            <h3>Ingresos por período (últimos 6 meses)</h3>
            <div id="ingresosBars"></div>
          </div>
          <div class="panel">
            <h3>Productividad de mecánicos — horas prom. por orden</h3>
            <div id="productividadBars"></div>
          </div>
        </div>
      </section>

    </div>
  </main>
</div>

<div class="toast-stack" id="toastStack"></div>

</body>
</html>