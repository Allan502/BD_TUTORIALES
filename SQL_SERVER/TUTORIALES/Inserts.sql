-- INSERCIONES
INSERT INTO TableName (Column1, Column2, Column3)
VALUES (Value1, Value2, Value3);

INSERT INTO TableName (Column1, Column2, Column3)
VALUES
    (Value1a, Value2a, Value3a),
    (Value1b, Value2b, Value3b),
    (Value1c, Value2c, Value3c);

-- INSERCION COMPUESTA DE UN SELECT
INSERT INTO Employees (EmployeeID, FirstName, LastName)
SELECT EmployeeID, FirstName, LastName
FROM TempEmployees
WHERE HireDate > '2023-01-01';

-- INSERCION CON DEFAULTS
INSERT INTO TableName (Column1, Column2)
VALUES (Value1, Value2);
INSERT INTO Orders (OrderID, OrderDate)
VALUES (101, DEFAULT);


-- INSERCION CON OUTPUTS
-- Este código inserta un registro en la tabla "Employees" y captura los valores de las columnas
-- "EmployeeID" y "FirstName" generados por la inserción usando la cláusula OUTPUT.
-- Los valores capturados se insertan en la tabla de variables "@InsertedRows" para ser utilizados posteriormente.
DECLARE @InsertedRows TABLE (EmployeeID INT, FirstName VARCHAR(50));

-- Insertar un nuevo registro en "Employees" y capturar "EmployeeID" y "FirstName" generados
-- en la tabla de variables "@InsertedRows".
INSERT INTO Employees (FirstName, LastName)
    OUTPUT INSERTED.EmployeeID, INSERTED.FirstName
INTO @InsertedRows (EmployeeID, FirstName)
VALUES ('John', 'Doe');

-- Seleccionamos los registros capturados de la tabla de variables "@InsertedRows"
SELECT * FROM @InsertedRows;


-- EJEMPLOS ADICIONALES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
OrderDate DATETIME DEFAULT GETDATE()  -- Usando GETDATE() como valor por defecto
);
INSERT INTO Orders (OrderID, OrderDate)
VALUES (101, DEFAULT);



CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
OrderDate DATETIME DEFAULT GETDATE(),  -- Valor por defecto con la hora actual
CreatedAt DATETIME2 DEFAULT SYSDATETIME()  -- Otra opción, más precisa, con fracción de segundos
);
INSERT INTO Orders (OrderID)
VALUES (101);  -- La columna OrderDate tomará automáticamente el valor de GETDATE()


-- PROCEDURES
CREATE PROCEDURE InsertEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50)
AS
BEGIN
INSERT INTO Employees (EmployeeID, FirstName, LastName)
VALUES (@EmployeeID, @FirstName, @LastName);
END;
-- EJEMPLOS ADICIONALES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
