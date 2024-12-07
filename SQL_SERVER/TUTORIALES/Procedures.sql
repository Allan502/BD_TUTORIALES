-- PROCEDURES

CREATE PROCEDURE InsertEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @HireDate DATETIME
AS
BEGIN
    -- Inserta un nuevo empleado en la tabla Employees
INSERT INTO Employees (FirstName, LastName, HireDate)
VALUES (@FirstName, @LastName, @HireDate);
END;
EXEC InsertEmployee 'John', 'Doe', '2024-12-01';




ALTER PROCEDURE InsertEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @HireDate DATETIME,
    @Department VARCHAR(50) -- Nuevo parámetro
    AS
BEGIN
    -- Inserta un nuevo empleado en la tabla Employees, ahora también con el Departamento
INSERT INTO Employees (FirstName, LastName, HireDate, Department)
VALUES (@FirstName, @LastName, @HireDate, @Department);
END;




DROP PROCEDURE InsertEmployee;




CREATE PROCEDURE GetEmployeeCount
    @EmployeeCount INT OUTPUT
AS
BEGIN
    -- Cuenta el número de empleados
SELECT @EmployeeCount = COUNT(*) FROM Employees;
END;
DECLARE @Count INT;
EXEC GetEmployeeCount @EmployeeCount = @Count OUTPUT;
SELECT @Count AS TotalEmployees;





CREATE PROCEDURE GetEmployeeById
    @EmployeeID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
    BEGIN
    SELECT * FROM Employees WHERE EmployeeID = @EmployeeID;
    END
    ELSE
    BEGIN
        PRINT 'Empleado no encontrado';
    END
END;

CREATE PROCEDURE UpdateEmployeeSalaries
    @PercentageIncrease DECIMAL(5, 2)
AS
BEGIN
    DECLARE @EmployeeID INT;
    DECLARE @CurrentSalary DECIMAL(10, 2);

    DECLARE employee_cursor CURSOR FOR
SELECT EmployeeID, Salary FROM Employees;

OPEN employee_cursor;
FETCH NEXT FROM employee_cursor INTO @EmployeeID, @CurrentSalary;

WHILE @@FETCH_STATUS = 0
BEGIN
        -- Aumenta el salario
UPDATE Employees
SET Salary = @CurrentSalary * (1 + @PercentageIncrease / 100)
WHERE EmployeeID = @EmployeeID;

FETCH NEXT FROM employee_cursor INTO @EmployeeID, @CurrentSalary;
END

CLOSE employee_cursor;
DEALLOCATE employee_cursor;
END;







BEGIN TRY
    -- Intentar insertar un registro
INSERT INTO Employees (FirstName, LastName, HireDate)
    VALUES ('Jane', 'Smith', '2024-12-10');
END TRY
BEGIN CATCH
    -- Capturar y mostrar el error
PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;