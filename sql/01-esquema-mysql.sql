-- ============================================================================
--  SISTEMA DE GESTION DE CONDOMINIO (SGAC) - Esquema para MySQL 8.4
--  Traducido de "CREACION DE DB Y TABLAS.sql" (T-SQL / SQL Server)
-- ============================================================================

DROP DATABASE IF EXISTS condominio;
CREATE DATABASE condominio CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE condominio;

-- ============================================================================
--  1. TABLA ROLES
-- ============================================================================
CREATE TABLE roles (
    id_rol      INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(50)  NOT NULL UNIQUE,
    descripcion VARCHAR(150),
    estado      BIT(1)      NOT NULL DEFAULT b'1'
) ENGINE=InnoDB;

-- ============================================================================
--  2. TABLA PERSONAS
-- ============================================================================
CREATE TABLE personas (
    id_persona       INT AUTO_INCREMENT PRIMARY KEY,
    nombres          VARCHAR(100) NOT NULL,
    apellidos         VARCHAR(100) NOT NULL,
    dpi              VARCHAR(20)  NOT NULL UNIQUE,
    telefono         VARCHAR(20),
    correo           VARCHAR(150),
    fecha_nacimiento DATE,
    estado           BIT(1)      NOT NULL DEFAULT b'1'
) ENGINE=InnoDB;

-- ============================================================================
--  3. TABLA USUARIOS
-- ============================================================================
CREATE TABLE usuarios (
    id_usuario     INT AUTO_INCREMENT PRIMARY KEY,
    id_persona     INT          NOT NULL,
    id_rol         INT          NOT NULL,
    username       VARCHAR(50)  NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,
    estado         BIT(1)      NOT NULL DEFAULT b'1',
    fecha_creacion DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_Usuarios_Personas FOREIGN KEY (id_persona)
        REFERENCES personas (id_persona),

    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (id_rol)
        REFERENCES roles (id_rol)
) ENGINE=InnoDB;

-- ============================================================================
--  4. TABLA VIVIENDAS
-- ============================================================================
CREATE TABLE viviendas (
    id_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    numero      VARCHAR(20)  NOT NULL,
    bloque      VARCHAR(20),
    direccion   VARCHAR(200),
    estado      VARCHAR(30)  NOT NULL DEFAULT 'Ocupada',

    CONSTRAINT CK_Viviendas_Estado CHECK (estado IN ('Disponible', 'Ocupada', 'Mantenimiento', 'Inactiva'))
) ENGINE=InnoDB;

-- ============================================================================
--  5. TABLA VIVIENDA_PERSONA
-- ============================================================================
CREATE TABLE vivienda_persona (
    id_vivienda_persona INT AUTO_INCREMENT PRIMARY KEY,
    id_vivienda         INT         NOT NULL,
    id_persona          INT         NOT NULL,
    tipo_relacion       VARCHAR(30) NOT NULL,
    fecha_inicio        DATE        NOT NULL DEFAULT (CURRENT_DATE),
    fecha_fin           DATE        NULL,
    estado              BIT(1)      NOT NULL DEFAULT b'1',

    CONSTRAINT FK_ViviendaPersona_Viviendas FOREIGN KEY (id_vivienda)
        REFERENCES viviendas (id_vivienda),

    CONSTRAINT FK_ViviendaPersona_Personas FOREIGN KEY (id_persona)
        REFERENCES personas (id_persona),

    CONSTRAINT CK_ViviendaPersona_TipoRelacion CHECK (tipo_relacion IN
        ('Propietario', 'Residente', 'Inquilino', 'Familiar'))
) ENGINE=InnoDB;

-- ============================================================================
--  6. TABLA VEHICULOS
-- ============================================================================
CREATE TABLE vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_vivienda INT         NOT NULL,
    placa      VARCHAR(20)  NOT NULL UNIQUE,
    marca      VARCHAR(50),
    modelo     VARCHAR(50),
    color      VARCHAR(30),
    tipo       VARCHAR(30),
    estado     BIT(1)      NOT NULL DEFAULT b'1',

    CONSTRAINT FK_Vehiculos_Viviendas FOREIGN KEY (id_vivienda)
        REFERENCES viviendas (id_vivienda)
) ENGINE=InnoDB;

-- ============================================================================
--  7. TABLA CONCEPTOS_CUOTA
-- ============================================================================
CREATE TABLE conceptos_cuota (
    id_concepto   INT AUTO_INCREMENT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL UNIQUE,
    descripcion   VARCHAR(200),
    monto_base    DECIMAL(10,2) NOT NULL,
    periodicidad  VARCHAR(30)  NOT NULL,
    estado        BIT(1)      NOT NULL DEFAULT b'1',

    CONSTRAINT CK_ConceptosCuota_Monto CHECK (monto_base >= 0),

    CONSTRAINT CK_ConceptosCuota_Periodicidad CHECK (periodicidad IN
        ('Mensual', 'Trimestral', 'Semestral', 'Anual', 'Unica'))
) ENGINE=InnoDB;

-- ============================================================================
--  8. TABLA CUOTAS
-- ============================================================================
CREATE TABLE cuotas (
    id_cuota          INT AUTO_INCREMENT PRIMARY KEY,
    id_vivienda       INT           NOT NULL,
    id_concepto       INT           NOT NULL,
    periodo           VARCHAR(20)   NOT NULL,
    monto             DECIMAL(10,2) NOT NULL,
    fecha_emision     DATE          NOT NULL DEFAULT (CURRENT_DATE),
    fecha_vencimiento DATE          NOT NULL,
    estado            VARCHAR(30)   NOT NULL DEFAULT 'Pendiente',

    CONSTRAINT FK_Cuotas_Viviendas FOREIGN KEY (id_vivienda)
        REFERENCES viviendas (id_vivienda),

    CONSTRAINT FK_Cuotas_Conceptos FOREIGN KEY (id_concepto)
        REFERENCES conceptos_cuota (id_concepto),

    CONSTRAINT CK_Cuotas_Monto CHECK (monto >= 0),

    CONSTRAINT CK_Cuotas_Estado CHECK (estado IN
        ('Pendiente', 'Pagada', 'Vencida', 'Cancelada'))
) ENGINE=InnoDB;

-- ============================================================================
--  9. TABLA PAGOS
-- ============================================================================
CREATE TABLE pagos (
    id_pago     INT AUTO_INCREMENT PRIMARY KEY,
    id_cuota    INT           NOT NULL,
    id_usuario  INT           NOT NULL,
    monto       DECIMAL(10,2) NOT NULL,
    fecha_pago  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(30)   NOT NULL,
    referencia  VARCHAR(100),
    estado      VARCHAR(30)   NOT NULL DEFAULT 'Aprobado',

    CONSTRAINT FK_Pagos_Cuotas FOREIGN KEY (id_cuota)
        REFERENCES cuotas (id_cuota),

    CONSTRAINT FK_Pagos_Usuarios FOREIGN KEY (id_usuario)
        REFERENCES usuarios (id_usuario),

    CONSTRAINT CK_Pagos_Monto CHECK (monto > 0),

    CONSTRAINT CK_Pagos_Metodo CHECK (metodo_pago IN
        ('Efectivo', 'Transferencia', 'Tarjeta', 'Deposito')),

    CONSTRAINT CK_Pagos_Estado CHECK (estado IN
        ('Pendiente', 'Aprobado', 'Rechazado', 'Cancelado'))
) ENGINE=InnoDB;

-- ============================================================================
--  10. TABLA NOTIFICACIONES
-- ============================================================================
CREATE TABLE notificaciones (
    id_notificacion    INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario         INT         NOT NULL,
    titulo             VARCHAR(150) NOT NULL,
    mensaje            TEXT        NOT NULL,
    tipo               VARCHAR(30) NOT NULL,
    fecha_publicacion  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion   DATETIME    NULL,
    estado             BIT(1)      NOT NULL DEFAULT b'1',

    CONSTRAINT FK_Notificaciones_Usuarios FOREIGN KEY (id_usuario)
        REFERENCES usuarios (id_usuario),

    CONSTRAINT CK_Notificaciones_Tipo CHECK (tipo IN
        ('Pago', 'Aviso', 'Alerta', 'Sistema'))
) ENGINE=InnoDB;

-- ============================================================================
--  11. TABLA AUDITORIA
-- ============================================================================
CREATE TABLE auditoria (
    id_auditoria    INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario      INT          NOT NULL,
    accion          VARCHAR(50)  NOT NULL,
    tabla_afectada  VARCHAR(50)  NOT NULL,
    registro_id     INT          NULL,
    descripcion     VARCHAR(255),
    fecha           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_Auditoria_Usuarios FOREIGN KEY (id_usuario)
        REFERENCES usuarios (id_usuario)
) ENGINE=InnoDB;
