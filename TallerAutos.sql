DROP DATABASE IF EXISTS taller_autos;
CREATE DATABASE taller_autos;
USE taller_autos;

-- =====================================================================
-- TABLAS MAESTRAS (catálogos)
-- =====================================================================
CREATE TABLE tipo_documento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_do VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_tipo_documento_codigo (tipo_do)
) ENGINE=InnoDB;

CREATE TABLE marca_producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_ma VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_marca_producto_codigo (codigo)
) ENGINE=InnoDB;

CREATE TABLE forma_pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_pa VARCHAR(50) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_forma_pago_codigo (codigo)
) ENGINE=InnoDB;

CREATE TABLE marca_vehiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca_vehi VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_marca_vehiculo_codigo (codigo)
) ENGINE=InnoDB;

CREATE TABLE modelo_vehiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_marca INT NOT NULL,
    modelo_ve VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_modelo_vehiculo_codigo (codigo),
    CONSTRAINT fk_modelo_vehiculo_marca FOREIGN KEY (id_marca) REFERENCES marca_vehiculo(id)
) ENGINE=InnoDB;

CREATE TABLE rol (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_rol_codigo (codigo)
) ENGINE=InnoDB;

CREATE TABLE categoria_producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_pro_ser VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_categoria_producto_codigo (codigo)
) ENGINE=InnoDB;

CREATE TABLE almacen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sedes VARCHAR(16) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    codigo VARCHAR(20) NOT NULL,
    UNIQUE KEY uq_almacen_codigo (codigo)
) ENGINE=InnoDB;

-- =====================================================================
-- USUARIOS
-- =====================================================================
CREATE TABLE Empleado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(16) NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    ultima_sesion DATETIME NULL,
    id_rol INT NOT NULL,
    fecha_crea DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modif DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    empleado TINYINT NOT NULL DEFAULT 1,
    apellidos VARCHAR(150) NOT NULL,
    nombres VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE NULL,
    celular VARCHAR(20) NULL,
    correo VARCHAR(150) NULL,
    salario DECIMAL(10,2) NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_usuario_codigo (codigo),
    UNIQUE KEY uq_usuario_login (usuario),
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id)
) ENGINE=InnoDB;

-- =====================================================================
-- PRODUCTO / SERVICIO
-- =====================================================================
CREATE TABLE producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(16) NOT NULL,
    num_parte VARCHAR(32) NULL,
    tipo TINYINT NOT NULL DEFAULT 0 COMMENT '0=producto, 1=servicio',
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT NULL,
    id_marca INT NULL,
    id_categoria INT NULL,
    stock DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_minimo DECIMAL(10,2) NOT NULL DEFAULT 0,
    precio_venta DECIMAL(10,2) NOT NULL DEFAULT 0,
    precio_costo DECIMAL(10,2) NOT NULL DEFAULT 0,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_producto_codigo (codigo),
    CONSTRAINT fk_producto_marca FOREIGN KEY (id_marca) REFERENCES marca_producto(id),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id)
) ENGINE=InnoDB;

CREATE TABLE movimiento_stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_almacen INT NOT NULL,
    tipo TINYINT NOT NULL COMMENT '1=ingreso, 2=salida',
    cantidad DECIMAL(10,2) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_movimiento_producto FOREIGN KEY (id_producto) REFERENCES producto(id),
    CONSTRAINT fk_movimiento_almacen FOREIGN KEY (id_almacen) REFERENCES almacen(id)
) ENGINE=InnoDB;

-- =====================================================================
-- Cliente / TERCERO / VEHÍCULO
-- =====================================================================
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(16) NOT NULL,
    id_cliente INT NOT NULL,
    nombres VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    id_tipo_documento INT NOT NULL,
    num_documento VARCHAR(32) NOT NULL,
    UNIQUE KEY uq_contacto_codigo (codigo),
    CONSTRAINT fk_contacto_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id),
    CONSTRAINT fk_contacto_tipo_doc FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id)
) ENGINE=InnoDB;

CREATE TABLE PROVEEDOR (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    contacto VARCHAR(50) NOT NULL,
    empresa VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    ruc VARCHAR(20) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    pais VARCHAR(30) NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    codigoTrabajador VARCHAR(16) NOT NULL,
    CONSTRAINT fk_CODIGO_TRABAJADOR FOREIGN KEY (codigoTrabajador) REFERENCES Empleado(codigo)
) ENGINE = InnoDB;

CREATE TABLE vehiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(16) NOT NULL,
    id_marca INT NOT NULL,
    id_modelo INT NOT NULL,
    placa VARCHAR(10) NOT NULL,
    id_cliente INT NOT NULL, 
    num_motor VARCHAR(50) NULL,
    color VARCHAR(50) NULL,
    kilometraje INT NOT NULL DEFAULT 0,
    anio SMALLINT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_vehiculo_placa (placa),
    CONSTRAINT fk_vehiculo_marca FOREIGN KEY (id_marca) REFERENCES marca_vehiculo(id),
    CONSTRAINT fk_vehiculo_modelo FOREIGN KEY (id_modelo) REFERENCES modelo_vehiculo(id),
    CONSTRAINT fk_vehiculo_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id)
) ENGINE=InnoDB;

-- =====================================================================
-- TRANSACCIONES: ORDEN DE SERVICIO Y DIAGNÓSTICO
-- =====================================================================
CREATE TABLE orden_servicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_orden VARCHAR(20) NOT NULL,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL, 
    id_asesor INT NOT NULL, 
    fecha_ingreso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    problema_cliente TEXT NOT NULL, 
    kilometraje_ingreso INT NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1 COMMENT '0=Pendiente, 1=Activo, 2=Inactivo', 
    UNIQUE KEY uq_numero_orden (numero_orden),
    CONSTRAINT fk_orden_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id),
    CONSTRAINT fk_orden_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id),
    CONSTRAINT fk_orden_asesor FOREIGN KEY (id_asesor) REFERENCES Empleado(id)
) ENGINE=InnoDB;

CREATE TABLE informe_diagnostico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_orden_servicio INT NOT NULL,
    id_tecnico INT NOT NULL, 
    diagnostico_inicial TEXT NOT NULL,
    CONSTRAINT fk_diagnostico_orden FOREIGN KEY (id_orden_servicio) REFERENCES orden_servicio(id),
    CONSTRAINT fk_diagnostico_tecnico FOREIGN KEY (id_tecnico) REFERENCES empleado(id)
) ENGINE=InnoDB;

-- =====================================================================
-- PROCEDIMIENTOS ALMACENADOS: EMPLEADO
-- =====================================================================

DELIMITER //

CREATE PROCEDURE SP_Insertar_Empleado(
    IN p_codigo VARCHAR(16),
    IN p_usuario VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_rol INT,
    IN p_empleado TINYINT,
    IN p_apellidos VARCHAR(150),
    IN p_nombres VARCHAR(150),
    IN p_fecha_nac DATE,
    IN p_celular VARCHAR(20),
    IN p_correo VARCHAR(150),
    IN p_salario DECIMAL(10,2),
    IN p_estado TINYINT
)
BEGIN
    INSERT INTO Empleado (
        codigo, 
        usuario, 
        password, 
        id_rol, 
        empleado, 
        apellidos, 
        nombres, 
        fecha_nacimiento, 
        celular, 
        correo, 
        salario, 
        estado
    ) 
    VALUES (
        p_codigo, 
        p_usuario, 
        p_password, 
        p_rol, 
        p_empleado, 
        p_apellidos, 
        p_nombres, 
        p_fecha_nac, 
        p_celular, 
        p_correo, 
        p_salario, 
        p_estado
    );
END //

CREATE PROCEDURE usp_validalogin(
    IN usu VARCHAR(50), 
    IN pwd VARCHAR(255)
)
BEGIN
    SELECT * FROM Empleado 
    WHERE usuario = usu AND password = pwd;
END //

CREATE PROCEDURE SP_obtener_Empleado(
    IN p_ID INT
)
BEGIN
    SELECT * FROM Empleado WHERE id = p_ID;
END //

CREATE PROCEDURE SP_actualizar_Empleado(
    IN p_ID INT, 
    IN p_codigo VARCHAR(16), 
    IN p_usuario VARCHAR(50), 
    IN p_password VARCHAR(255), 
    IN p_rol INT, 
    IN p_empleado TINYINT, 
    IN p_apellidos VARCHAR(150), 
    IN p_nombres VARCHAR(150), 
    IN p_fecha_nac DATE, 
    IN p_celular VARCHAR(20), 
    IN p_correo VARCHAR(150), 
    IN p_salario DECIMAL(10,2), 
    IN p_estado TINYINT
)
BEGIN
   UPDATE Empleado SET 
        codigo = p_codigo, 
        usuario = p_usuario, 
        password = p_password, 
        id_rol = p_rol, 
        empleado = p_empleado, 
        apellidos = p_apellidos, 
        nombres = p_nombres, 
        fecha_nacimiento = p_fecha_nac, 
        celular = p_celular, 
        correo = p_correo, 
        salario = p_salario, 
        estado = p_estado 
   WHERE id = p_ID;
END //

CREATE PROCEDURE SP_Seleccionar_Empleado()
BEGIN
    SELECT * FROM Empleado;
END //

CREATE PROCEDURE SP_Eliminar_Empleado(
    IN p_id INT,
    IN p_estado TINYINT
)
BEGIN
	UPDATE Empleado
    SET estado = p_estado
    WHERE id = p_id;
END //

-- =====================================================================
-- PROCEDIMIENTOS ALMACENADOS: VEHÍCULO CLIENTE (Estructuras vacías prontas para desarrollo)
-- =====================================================================

DELIMITER //

-- =====================================================================
-- 1. REGISTRAR VEHÍCULO
-- =====================================================================
CREATE PROCEDURE SP_Registrar_Vehiculo_Cliente(
    IN p_codigo VARCHAR(16),
    IN p_id_marca INT,
    IN p_id_modelo INT,
    IN p_placa VARCHAR(10),
    IN p_id_cliente INT,
    IN p_num_motor VARCHAR(50),
    IN p_color VARCHAR(50),
    IN p_kilometraje INT,
    IN p_anio SMALLINT
)
BEGIN
    INSERT INTO vehiculo (
        codigo, 
        id_marca, 
        id_modelo, 
        placa, 
        id_cliente, 
        num_motor, 
        color, 
        kilometraje, 
        anio, 
        estado
    ) 
    VALUES (
        p_codigo, 
        p_id_marca, 
        p_id_modelo, 
        p_placa, 
        p_id_cliente, 
        p_num_motor, 
        p_color, 
        p_kilometraje, 
        p_anio, 
        1 -- Por defecto se registra como Activo (1)
    );
END //

-- =====================================================================
-- 2. LISTAR VEHÍCULOS CON SUS DETALLES (Une marcas, modelos y clientes)
-- =====================================================================
CREATE PROCEDURE SP_listar_Vehiculo_Cliente()
BEGIN
    SELECT 
        v.id,
        v.codigo AS vehiculo_codigo,
        v.placa,
        v.color,
        v.kilometraje,
        v.anio,
        v.num_motor,
        v.estado,
        m.nombre AS marca_nombre,
        mod_v.nombre AS modelo_nombre,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre,
        c.num_documento AS cliente_documento
    FROM vehiculo v
    INNER JOIN marca_vehiculo m ON v.id_marca = m.id
    INNER JOIN modelo_vehiculo mod_v ON v.id_modelo = mod_v.id
    INNER JOIN CLIENTE c ON v.id_cliente = c.id
    ORDER BY v.id DESC; -- Muestra los últimos registrados primero
END //

-- =====================================================================
-- 3. MODIFICAR VEHÍCULO
-- =====================================================================
CREATE PROCEDURE SP_Modificar_Vehiculo_Cliente(
    IN p_id INT,
    IN p_codigo VARCHAR(16),
    IN p_id_marca INT,
    IN p_id_modelo INT,
    IN p_placa VARCHAR(10),
    IN p_id_cliente INT,
    IN p_num_motor VARCHAR(50),
    IN p_color VARCHAR(50),
    IN p_kilometraje INT,
    IN p_anio SMALLINT
)
BEGIN
    UPDATE vehiculo 
    SET 
        codigo = p_codigo,
        id_marca = p_id_marca,
        id_modelo = p_id_modelo,
        placa = p_placa,
        id_cliente = p_id_cliente,
        num_motor = p_num_motor,
        color = p_color,
        kilometraje = p_kilometraje,
        anio = p_anio
    WHERE id = p_id;
END //

-- =====================================================================
-- 4. CAMBIAR ESTADO (Eliminación lógica: 0=Pendiente, 1=Activo, 2=Inactivo)
-- =====================================================================
CREATE PROCEDURE SP_CambiarEstado_Vehiculo_Cliente(
    IN p_id INT,
    IN p_estado TINYINT
)
BEGIN
    UPDATE vehiculo 
    SET estado = p_estado
    WHERE id = p_id;
END //

DELIMITER ;


DELIMITER //

-- =====================================================================
-- 1. CREAR CLIENTE
-- =====================================================================
CREATE PROCEDURE SP_Crear_Cliente(
    IN p_codigo VARCHAR(20),
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(30),
    IN p_celular VARCHAR(20),
    IN p_correo VARCHAR(50),
    IN p_direccion VARCHAR(50),
    IN p_fecha_pedido DATE,
    IN p_id_tipo_documento INT,
    IN p_num_documento VARCHAR(32)
)

BEGIN
    INSERT INTO CLIENTE (
        codigo, 
        nombre, 
        apellido, 
        celular, 
        correo, 
        direccion, 
        fecha_Pedido, 
        id_tipo_documento, 
        num_documento
    ) 
    VALUES (
        p_codigo, 
        p_nombre, 
        p_apellido, 
        p_celular, 
        p_correo, 
        p_direccion, 
        p_fecha_pedido, 
        p_id_tipo_documento, 
        p_num_documento
    );
END //

-- =====================================================================
-- 2. EDITAR CLIENTE
-- =====================================================================
CREATE PROCEDURE SP_EditarCliente(
    IN p_id INT,
    IN p_codigo VARCHAR(20),
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(30),
    IN p_celular VARCHAR(20),
    IN p_correo VARCHAR(50),
    IN p_direccion VARCHAR(50),
    IN p_fecha_pedido DATE,
    IN p_id_tipo_documento INT,
    IN p_num_documento VARCHAR(32)
)
BEGIN
    UPDATE CLIENTE 
    SET 
        codigo = p_codigo,
        nombre = p_nombre,
        apellido = p_apellido,
        celular = p_celular,
        correo = p_correo,
        direccion = p_direccion,
        fecha_Pedido = p_fecha_pedido,
        id_tipo_documento = p_id_tipo_documento,
        num_documento = p_num_documento
    WHERE id = p_id;
END //

-- =====================================================================
-- 3. SELECCIONAR / LISTAR CLIENTES (Con nombre de documento)
-- =====================================================================
CREATE PROCEDURE SP_Seleccionar_Cliente()
BEGIN
    SELECT 
        c.id,
        c.codigo,
        c.nombre,
        c.apellido,
        c.celular,
        c.correo,
        c.direccion,
        c.fecha_Pedido,
        td.nombre AS tipo_documento_nombre,
        c.num_documento
    FROM CLIENTE c
    INNER JOIN tipo_documento td ON c.id_tipo_documento = td.id
    ORDER BY c.id DESC;
END //

-- =====================================================================
-- 4. ACTUALIZAR ESTADO CLIENTE (Nota: Tu tabla CLIENTE no tenía columna estado,
-- se crea el procedimiento listo por si decides agregarle la columna después)
-- =====================================================================
CREATE PROCEDURE SP_Actualizar_Estado_Cliente(
    IN p_id INT,
    IN p_estado TINYINT
)
BEGIN
    -- Si en el futuro agregas la columna estado a CLIENTE, descomenta la siguiente línea:
    -- UPDATE CLIENTE SET estado = p_estado WHERE id = p_id;
    
    -- Por ahora, como muestra de ejecución:
    SELECT p_id AS id_cliente, p_estado AS nuevo_estado;
END //

-- =====================================================================
-- 5. CARGAR DATOS RÁPIDO CLIENTE CONCURRIDO (Buscador predictivo)
-- =====================================================================
CREATE PROCEDURE SP_CARGAR_DATOS_RAPIDO_CLIENTE_CONCURRIDO(
    IN p_busqueda VARCHAR(100) -- Puede ser el nro documento o apellido
)
BEGIN
    SELECT 
        id,
        codigo,
        CONCAT(nombre, ' ', apellido) AS cliente_completo,
        celular,
        num_documento
    FROM CLIENTE
    WHERE num_documento = p_busqueda 
       OR apellido LIKE CONCAT('%', p_busqueda, '%')
    LIMIT 10; -- Optimiza la velocidad de carga en el sistema
END //

DELIMITER ;

DELIMITER //

-- =====================================================================
-- PROCEDIMIENTOS PARA: ORDEN DE SERVICIO
-- =====================================================================

-- 1. Registrar una nueva orden de ingreso
CREATE PROCEDURE SP_Registrar_Orden_Servicio(
    IN p_numero_orden VARCHAR(20),
    IN p_id_vehiculo INT,
    IN p_id_cliente INT,
    IN p_id_asesor INT,
    IN p_problema_cliente TEXT,
    IN p_kilometraje_ingreso INT
)
BEGIN
    INSERT INTO orden_servicio (
        numero_orden,
        id_vehiculo,
        id_cliente,
        id_asesor,
        problema_cliente,
        kilometraje_ingreso,
        estado
    ) 
    VALUES (
        p_numero_orden,
        p_id_vehiculo,
        p_id_cliente,
        p_id_asesor,
        p_problema_cliente,
        p_kilometraje_ingreso,
        1 -- 1 = Activo / Registrado por defecto
    );
END //

-- 2. Listar todas las órdenes con los datos del carro y cliente
CREATE PROCEDURE SP_Listar_Ordenes_Servicio()
BEGIN
    SELECT 
        o.id AS id_orden,
        o.numero_orden,
        o.fecha_ingreso,
        o.kilometraje_ingreso,
        o.problema_cliente,
        o.estado,
        v.placa AS vehiculo_placa,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre,
        CONCAT(e.nombres, ' ', e.apellidos) AS asesor_nombre
    FROM orden_servicio o
    INNER JOIN vehiculo v ON o.id_vehiculo = v.id
    INNER JOIN CLIENTE c ON o.id_cliente = c.id
    INNER JOIN Empleado e ON o.id_asesor = e.id
    ORDER BY o.id DESC;
END //

-- 3. Cambiar estado de la orden (0=Pendiente, 1=Activo, 2=Inactivo)
CREATE PROCEDURE SP_CambiarEstado_Orden_Servicio(
    IN p_id INT,
    IN p_estado TINYINT
)
BEGIN
    UPDATE orden_servicio 
    SET estado = p_estado
    WHERE id = p_id;
END //


-- =====================================================================
-- PROCEDIMIENTOS PARA: INFORME DIAGNÓSTICO
-- =====================================================================

-- 1. Registrar el diagnóstico que hizo el mecánico técnico
CREATE PROCEDURE SP_Registrar_Informe_Diagnostico(
    IN p_id_orden_servicio INT,
    IN p_id_tecnico INT,
    IN p_diagnostico_inicial TEXT
)
BEGIN
    INSERT INTO informe_diagnostico (
        id_orden_servicio,
        id_tecnico,
        diagnostico_inicial
    ) 
    VALUES (
        p_id_orden_servicio,
        p_id_tecnico,
        p_diagnostico_inicial
    );
END //

-- 2. Ver el diagnóstico de una orden específica
CREATE PROCEDURE SP_Obtener_Diagnostico_Por_Orden(
    IN p_id_orden INT
)
BEGIN
    SELECT 
        i.id AS id_informe,
        o.numero_orden,
        i.diagnostico_inicial,
        CONCAT(e.nombres, ' ', e.apellidos) AS tecnico_asignado
    FROM informe_diagnostico i
    INNER JOIN orden_servicio o ON i.id_orden_servicio = o.id
    INNER JOIN Empleado e ON i.id_tecnico = e.id
    WHERE i.id_orden_servicio = p_id_orden;
END //

DELIMITER ;




-- =====================================================================
-- INSERCIÓN DE DATOS MAESTROS (Semillas / Seeds)
-- =====================================================================

-- 1. Tipos de Documento de Identidad
INSERT INTO tipo_documento (tipo_do, nombre, codigo) VALUES 
('DNI', 'Documento Nacional de Identidad', 'TD-01'),
('RUC', 'Registro Único de Contribuyentes', 'TD-02'),
('CE', 'Carné de Extranjería', 'TD-03'),
('PAS', 'Pasaporte', 'TD-04');

-- 2. Marcas de Repuestos / Productos
INSERT INTO marca_producto (tipo_ma, nombre, codigo) VALUES 
('BOSCH', 'Bosch', 'MP-01'),
('ACDELCO', 'ACDelco', 'MP-02'),
('MOBIL', 'Mobil', 'MP-03'),
('MICHELIN', 'Michelin', 'MP-04'),
('GENUINO', 'Repuestos Originales OEM', 'MP-05');

-- 3. Formas de Pago para la Caja
INSERT INTO forma_pago (tipo_pa, nombre, codigo) VALUES 
('EFECTIVO', 'Efectivo', 'FP-01'),
('TARJETA_DB', 'Tarjeta de Débito', 'FP-02'),
('TARJETA_CR', 'Tarjeta de Crédito', 'FP-03'),
('TRANSFERENCIA', 'Transferencia Bancaria / Pago Digital', 'FP-04');

-- 4. Marcas de Vehículos
INSERT INTO marca_vehiculo (marca_vehi, nombre, codigo) VALUES 
('TOYOTA', 'Toyota', 'MV-01'),
('NISSAN', 'Nissan', 'MV-02'),
('HYUNDAI', 'Hyundai', 'MV-03'),
('HONDA', 'Honda', 'MV-04');

