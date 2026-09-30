-- ============================================================================
--  SISTEMA DE GESTION DE CONDOMINIO (SGAC) - Datos iniciales para MySQL 8.4
--  Traducido de "CREACION DE DATOS Y OTROS.sql"
--
--  NOTA: las contraseñas del script original venían en texto plano ('123456').
--  Aquí se guardan como hash SHA-256 (mismo formato que produce PasswordUtil):
--      '123456' -> 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
--  Usuarios: admin/123456, mlopez/123456, pcobros/123456
-- ============================================================================

USE condominio;

-- ---------------------------------------------------------------------------
--  Roles
-- ---------------------------------------------------------------------------
INSERT INTO roles (nombre, descripcion) VALUES
    ('Administrador',            'Acceso completo al sistema'),
    ('Personal Administrativo',  'Gestion de informacion administrativa'),
    ('Encargado de Cobros',      'Gestion de cuotas y pagos');

-- ---------------------------------------------------------------------------
--  Personal administrativo
-- ---------------------------------------------------------------------------
INSERT INTO personas
    (nombres, apellidos, dpi, telefono, correo, fecha_nacimiento) VALUES
    ('Carlos', 'Gomez',  '1234567890101', '5555-1111', 'carlos@sgac.com', '1990-05-15'),
    ('Maria',  'Lopez',  '1234567890102', '5555-2222', 'maria@sgac.com',  '1992-08-20'),
    ('Pedro',  'Ramirez','1234567890103', '5555-3333', 'pedro@sgac.com',  '1988-03-10');

-- ---------------------------------------------------------------------------
--  Usuarios  (password = SHA-256 de '123456')
-- ---------------------------------------------------------------------------
INSERT INTO usuarios (id_persona, id_rol, username, password) VALUES
    (1, 1, 'admin',   '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
    (2, 2, 'mlopez',  '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
    (3, 3, 'pcobros', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92');

-- ---------------------------------------------------------------------------
--  Viviendas
-- ---------------------------------------------------------------------------
INSERT INTO viviendas (numero, bloque, direccion, estado) VALUES
    ('101', 'A', 'Condominio Bloque A, Casa 101', 'Ocupada'),
    ('102', 'A', 'Condominio Bloque A, Casa 102', 'Ocupada'),
    ('103', 'A', 'Condominio Bloque A, Casa 103', 'Ocupada'),
    ('201', 'B', 'Condominio Bloque B, Casa 201', 'Ocupada'),
    ('202', 'B', 'Condominio Bloque B, Casa 202', 'Disponible');

-- ---------------------------------------------------------------------------
--  Personas del condominio
-- ---------------------------------------------------------------------------
INSERT INTO personas
    (nombres, apellidos, dpi, telefono, correo, fecha_nacimiento) VALUES
    ('Juan',  'Perez',   '2345678900101', '5555-4444', 'juan@gmail.com',  '1985-02-10'),
    ('Ana',   'Perez',   '2345678900102', '5555-5555', 'ana@gmail.com',   '1987-07-22'),
    ('Luis',  'Gonzalez','2345678900103', '5555-6666', 'luis@gmail.com',  '1990-11-05'),
    ('Sofia', 'Gonzalez','2345678900104', '5555-7777', 'sofia@gmail.com', '1993-04-18'),
    ('Pedro', 'Morales', '2345678900105', '5555-8888', 'pedro@gmail.com', '1979-09-30');

-- ---------------------------------------------------------------------------
--  Relacionar personas con viviendas
-- ---------------------------------------------------------------------------
INSERT INTO vivienda_persona (id_vivienda, id_persona, tipo_relacion) VALUES
    (1, 4, 'Propietario'),
    (1, 5, 'Residente'),
    (2, 6, 'Propietario'),
    (2, 7, 'Residente'),
    (3, 8, 'Propietario');

-- ---------------------------------------------------------------------------
--  Vehículos
-- ---------------------------------------------------------------------------
INSERT INTO vehiculos (id_vivienda, placa, marca, modelo, color, tipo) VALUES
    (1, 'P123ABC', 'Toyota', 'Corolla', 'Blanco', 'Automovil'),
    (1, 'M456DEF', 'Honda',  'CB190',   'Rojo',   'Motocicleta'),
    (2, 'P789GHI', 'Mazda',  '3',       'Gris',   'Automovil'),
    (3, 'P321JKL', 'Honda',  'Civic',   'Negro',  'Automovil');

-- ---------------------------------------------------------------------------
--  Conceptos de cuotas
-- ---------------------------------------------------------------------------
INSERT INTO conceptos_cuota (nombre, descripcion, monto_base, periodicidad) VALUES
    ('Mantenimiento',        'Cuota mensual de mantenimiento',          500.00,  'Mensual'),
    ('Seguridad',            'Servicio de seguridad del condominio',   150.00,  'Mensual'),
    ('Agua',                 'Consumo de agua',                         100.00,  'Mensual'),
    ('Cuota Extraordinaria', 'Cuota extraordinaria para proyectos',    1000.00,  'Unica');

-- ---------------------------------------------------------------------------
--  Cuotas
-- ---------------------------------------------------------------------------
INSERT INTO cuotas
    (id_vivienda, id_concepto, periodo, monto, fecha_vencimiento, estado) VALUES
    (1, 1, 'Septiembre 2026', 500.00, '2026-09-30', 'Pendiente'),
    (2, 1, 'Septiembre 2026', 500.00, '2026-09-30', 'Pendiente'),
    (3, 1, 'Septiembre 2026', 500.00, '2026-09-30', 'Pagada'),
    (4, 2, 'Septiembre 2026', 150.00, '2026-09-30', 'Pendiente');

-- ---------------------------------------------------------------------------
--  Pagos
-- ---------------------------------------------------------------------------
INSERT INTO pagos (id_cuota, id_usuario, monto, metodo_pago, referencia, estado) VALUES
    (3, 3, 500.00, 'Transferencia', 'TRX-202609-001', 'Aprobado');

-- ---------------------------------------------------------------------------
--  Notificaciones
-- ---------------------------------------------------------------------------
INSERT INTO notificaciones (id_usuario, titulo, mensaje, tipo) VALUES
    (1, 'Cuotas pendientes',      'Existen cuotas pendientes de pago en el sistema.', 'Alerta'),
    (3, 'Nuevo pago registrado',  'Se ha registrado un nuevo pago mediante transferencia.', 'Pago'),
    (2, 'Aviso administrativo',   'Recuerde revisar las cuotas próximas a vencer.', 'Aviso');

-- ---------------------------------------------------------------------------
--  Auditoría
-- ---------------------------------------------------------------------------
INSERT INTO auditoria (id_usuario, accion, tabla_afectada, registro_id, descripcion) VALUES
    (1, 'LOGIN',   'usuarios', 1, 'Inicio de sesion del administrador'),
    (3, 'INSERT',  'pagos',    1, 'Registro de pago por transferencia'),
    (1, 'UPDATE',  'cuotas',   3, 'Actualizacion del estado de la cuota');
