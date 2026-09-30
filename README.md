# Sistema de Condominio (SGAC)

Aplicacion web para administrar personas, viviendas, vehiculos, cuotas, pagos y
notificaciones de un condominio.

- **Backend:** Java 21 + Spring Boot 4.1.1
- **Vistas:** Thymeleaf + HTML/CSS
- **Base de datos:** Microsoft SQL Server 2025 (base `condominio`)
- **Build:** Maven (incluido, no hace falta instalarlo)

---

## Requisitos en la maquina nueva

1. **JDK 21** (probado con Eclipse Temurin 21).
2. **SQL Server** (2019 o superior) con el motor corriendo en el puerto `1433`.
3. **Internet la primera vez**, solo para que Maven descargue las dependencias.

No necesitas MySQL, ni IntelliJ, ni MySQL Workbench.

---

## Pasos para clonar y ejecutar

### 1. Clonar

```bash
git clone https://github.com/laguirrec1-hash/PROYECTO-CONDOMINIO.git
cd PROYECTO-CONDOMINIO
```

### 2. Crear la base de datos

Con `sqlcmd` (viene con SQL Server) o pegando los scripts en SQL Server
Management Studio, en este orden:

```bash
sqlcmd -S localhost -U sa -P "TU_PASSWORD" -C -f 1252 -i "CREACION DE DB Y TABLAS.sql"
sqlcmd -S localhost -U sa -P "TU_PASSWORD" -C -f 1252 -d condominio -i "CREACION DE DATOS Y OTROS.sql"
```

El primer script crea la base `condominio` con sus 11 tablas.
El segundo carga los datos de ejemplo (incluye los 3 usuarios).

> El flag `-f 1252` es necesario porque los scripts tienen acentos y estan
> guardados en codificacion Windows-1252.

### 3. Configurar la conexion

La configuracion esta en `src/main/resources/application.properties`. Por
defecto apunta a `localhost`, base `condominio`, usuario `sa` con password
`Sgac2026!`.

Si en la maquina nueva el servidor, la base o las credenciales son distintas,
**no hace falta editar el archivo**: se sobreescriben con variables de entorno
al arrancar.

| Variable | Valor por defecto | Significado |
|---|---|---|
| `DB_SERVER` | `localhost` | Servidor SQL Server |
| `DB_NAME` | `condominio` | Nombre de la base |
| `DB_USER` | `sa` | Usuario |
| `DB_PASSWORD` | `Sgac2026!` | Contrasena |

Ejemplo en Windows (PowerShell):

```powershell
$env:DB_PASSWORD = "OtraPassword"
.\mvnw.cmd spring-boot:run
```

### 4. Arrancar

Windows:

```powershell
.\mvnw.cmd spring-boot:run
```

Linux / Mac:

```bash
./mvnw spring-boot:run
```

Espera hasta que aparezca `Started SistemaCondominioApplication` y abre
`http://localhost:8080`.

### 5. Iniciar sesion

| Usuario | Contrasena | Rol |
|---|---|---|
| `admin` | `123456` | Administrador (acceso total) |
| `mlopez` | `123456` | Personal Administrativo |
| `pcobros` | `123456` | Encargado de Cobros |

---

## Notas utiles

- **Las contrasenas se guardan con SHA-256**, no en texto plano. El script de
  datos ya trae los hashes; si insertas un usuario a mano en la base, guarda el
  hash, no la contrasena.
- **`spring.jpa.hibernate.ddl-auto=validate`**: la aplicacion NO crea ni
  modifica tablas. Si las entidades no coinciden con la base, se niega a
  arrancar. Es intencional, para no dañar los datos.
- **Borrar con relaciones:** si una vivienda tiene cuotas, la base impide
  eliminarla y la app muestra un mensaje claro en vez de un error tecnico.
- La carpeta `sql/` contiene una version anterior para MySQL. **No se usa**; el
  motor actual es SQL Server.
