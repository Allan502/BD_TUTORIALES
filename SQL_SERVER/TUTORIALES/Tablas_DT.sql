

-- DIFERENCIA USAR VARCHAR Y NVARCHAR
-- VARCHAR LENGUAJE ESPANOL/INGLES -- ASCII
-- NVARCHAR SOPORTA MAS SIMBOLOS, OTROS IDIOMAS -- UNICODE

CREATE TABLE Pacientes(
    idPaciente INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE NOT NULL, -- FECHA, formato YY:MM:DD
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    correo VARCHAR(100),
    historialMedico TEXT, -- Grandes cantidades de texto
    fotografia IMAGE
);

CREATE TABLE Medicos (
    idMedico INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    telefono VARCHAR(15),
    salario MONEY, -- Money 4 decimales, tambien usado DECIMAL(2, 2) numero de enteros y decimales respectivamente
    horarioInicio TIME, -- Formato HH:mm:ss:nn, nn por defecto es de 7 digitos
    horarioFin TIME
);

CREATE TABLE Citas (
    idCita INT PRIMARY KEY IDENTITY(1,1),
    idPaciente INT NOT NULL,
    idMedico INT NOT NULL,
    fechaCita DATETIME NOT NULL, -- FECHA Y HORA
    diagnostico TEXT,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente), -- REFERENCIA A TABLAS EXTERNAS
    FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico)
);

CREATE TABLE Recetas (
    idReceta INT PRIMARY KEY IDENTITY(1,1),
    idCita INT NOT NULL,
    medicamento VARCHAR(100) NOT NULL,
    dosis VARCHAR(100),
    frecuencia VARCHAR(50),
    duracion VARCHAR(50),
    FOREIGN KEY (idCita) REFERENCES Citas(idCita)
);

CREATE TABLE Facturas (
    idFactura INT PRIMARY KEY IDENTITY(1,1),
    idPaciente INT NOT NULL,
    monto MONEY NOT NULL,
    fechaPago DATETIME NOT NULL,
    metodoPago VARCHAR(50) CHECK (metodoPago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'Seguro')),
    idSeguro INT NULL,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente)
);

CREATE TABLE Inventario (
    idProducto INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(255),
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    precio MONEY NOT NULL CHECK (precio >= 0),
    fechaVencimiento DATE
);

-- EJEMPLOS ADICIONALES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CREATE TABLE DataTypesExample (
-- Enteros: Se utilizan para almacenar números enteros de diferentes rangos y tamaños.
    ID INT IDENTITY(1,1) PRIMARY KEY,      -- Número entero autoincremental, clave primaria.
    SmallNumber SMALLINT,                 -- Entero pequeño (-32,768 a 32,767).
    TinyNumber TINYINT,                   -- Entero muy pequeño (0 a 255).
    BigNumber BIGINT,                     -- Entero grande (-2^63 a 2^63-1).
    NumericValue NUMERIC(10, 2),          -- Número exacto con 10 dígitos, 2 decimales.
    DecimalValue DECIMAL(10, 2),          -- Similar a NUMERIC, para cálculos financieros.

    -- Flotantes: Para valores aproximados con decimales (no exactos).
    FloatValue FLOAT,                     -- Flotante de doble precisión.
    RealValue REAL,                       -- Flotante de precisión simple.

    -- Moneda: Manejo específico para valores financieros.
    MoneyValue MONEY,                     -- Valores monetarios grandes con hasta 4 decimales.
    SmallMoneyValue SMALLMONEY,           -- Valores monetarios pequeños.

    -- Fecha y hora: Almacenan información temporal con distintos niveles de precisión.
    CurrentDate DATE,                     -- Solo fecha (formato: YYYY-MM-DD).
    CurrentTime TIME(3),                  -- Solo hora (HH:MM:SS.mmm, milisegundos).
    DateTimeValue DATETIME,               -- Fecha y hora (precisión: 3.33 ms).
    DateTime2Value DATETIME2(7),          -- Fecha y hora con precisión hasta 100 ns.
    SmallDateTimeValue SMALLDATETIME,     -- Fecha y hora con rango reducido.
    DateTimeOffsetValue DATETIMEOFFSET(2),-- Fecha y hora con zona horaria (precisión: 2 decimales). YYYY-MM-DD hh:mm:ss.ssssss -hh:mm -> donde hh:mm offset de la zona horaria

    -- Cadenas de caracteres: Texto en diferentes formatos.
    TextValue VARCHAR(50),                -- Cadena de texto variable en ASCII (máx. 50).
    NTextValue NVARCHAR(50),              -- Cadena de texto variable en Unicode.
    CharValue CHAR(10),                   -- Cadena de texto fija en ASCII (exactamente 10).
    NCharValue NCHAR(10),                 -- Cadena de texto fija en Unicode.

    -- Binarios: Para almacenar datos no textuales, como imágenes o archivos.
    BinaryValue BINARY(10),               -- Binario de longitud fija (10 bytes).
    VarBinaryValue VARBINARY(MAX),        -- Binario de longitud variable (máx. 2 GB).
    ImageValue IMAGE,                     -- Almacena datos binarios grandes (obsoleto, pero soportado).

    -- JSON y XML: Para datos semiestructurados.
    JsonData NVARCHAR(MAX),               -- JSON almacenado como texto Unicode.
    XmlData XML,                          -- XML nativo con soporte de consultas XPath.

    -- Identificadores únicos: Para claves o valores globales únicos.
    UniqueID UNIQUEIDENTIFIER,            -- Identificador único global (GUID).

    -- Otros: Tipos adicionales para casos específicos.
    BooleanValue BIT,                     -- Valores booleanos (0 o 1).
    GeospatialValue GEOGRAPHY,            -- Coordenadas geográficas (datos espaciales).
    HierarchyValue HIERARCHYID,           -- Estructuras jerárquicas (ej., árbol organizacional).
    SqlVariantValue SQL_VARIANT,          -- Almacena valores de cualquier tipo soportado.
    TimestampValue ROWVERSION             -- Número de versión único por fila (no es una marca de tiempo real).
);


-- HORA 3 ms
CREATE TABLE Horarios (
    ID INT PRIMARY KEY,
    HoraInicio TIME(3), -- Precisión de milisegundos. Acepta: '08:30:00.123' y '14:00:00'
    HoraFin TIME -- Precisión máxima (7 por defecto). Acepta: '17:45:00.5678901' y '22:30:00'
);

-- HORA solo con segundos
CREATE TABLE Horarios (
    ID INT PRIMARY KEY,
    Hora TIME(0) -- Solo horas, minutos y segundos (sin fracciones)
);

-- Insercion de hora truncada a segundos
INSERT INTO Horarios (ID, Hora)
VALUES (1, '12:34:56.789'); -- Se almacena como '12:34:56' con TIME(0).


-- Formatear fecha a DD/MM/YYYY
SELECT CONVERT(VARCHAR, GETDATE(), 103) AS FechaFormatoEuropeo;
-- Resultado: 06/12/2024 (Estilo 103: dd/MM/yyyy)

-- EJEMPLOS ADICIONALES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

