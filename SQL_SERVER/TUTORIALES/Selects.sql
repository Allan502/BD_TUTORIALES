-- TIPOS DE SELECTS

-- Obtener todos los registros de la tabla "Employees"
SELECT * FROM Employees;

-- Obtener solo las columnas "FirstName" y "LastName" de la tabla "Employees"
SELECT FirstName, LastName FROM Employees;

-- Usar alias para las columnas
SELECT FirstName AS "Nombre", LastName AS "Apellido" FROM Employees;


-- Obtener empleados cuyo "LastName" es 'Doe'
SELECT * FROM Employees WHERE LastName = 'Doe';
-- Obtener empleados cuyo "FirstName" comienza con 'J'
SELECT * FROM Employees WHERE FirstName LIKE 'J%';


-- Buscar empleados cuyo salario está entre 50000 y 80000
SELECT * FROM Employees WHERE Salary BETWEEN 50000 AND 80000;
-- Buscar empleados que tengan un salario específico o un valor en una lista
SELECT * FROM Employees WHERE Salary IN (60000, 70000, 80000);
-- Buscar empleados con nombres que contengan 'John'
SELECT * FROM Employees WHERE FirstName LIKE '%John%';


-- Ordenar los empleados por "LastName" en orden ascendente
SELECT * FROM Employees ORDER BY LastName;
-- Ordenar los empleados por "Salary" en orden descendente
SELECT * FROM Employees ORDER BY Salary DESC;


-- Obtener los primeros 5 empleados con el salario más alto
SELECT TOP 5 * FROM Employees ORDER BY Salary DESC;


-- Obtener el número de empleados
SELECT COUNT(*) FROM Employees;
-- Obtener el salario total de todos los empleados
SELECT SUM(Salary) FROM Employees;
-- Obtener el salario promedio de los empleados
SELECT AVG(Salary) FROM Employees;


-- Obtener el salario promedio por cada departamento
SELECT Department, AVG(Salary) FROM Employees GROUP BY Department;


-- Obtener el salario promedio por departamento, pero solo para departamentos con más de 3 empleados
SELECT Department, AVG(Salary)
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 3;


-- JOIN
-- Obtener todos los empleados y su departamento
SELECT E.FirstName, E.LastName, D.DepartmentName
FROM Employees E
         INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
-- Obtener todos los empleados y sus departamentos, incluso si no tienen departamento
SELECT E.FirstName, E.LastName, D.DepartmentName
FROM Employees E
         LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;


-- SUBCONSULTAS
-- Obtener empleados con un salario mayor que el salario promedio
SELECT *
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);



-- Obtener los empleados contratados en el último mes
SELECT *
FROM Employees
WHERE HireDate > DATEADD(MONTH, -1, GETDATE());
-- Explicación:
-- GETDATE(): Devuelve la fecha y hora actuales del sistema.
-- DATEADD(MONTH, -1, GETDATE()): Resta 1 mes a la fecha actual.
-- Esto selecciona los empleados cuya fecha de contratación es posterior a la fecha de hace un mes.

-- Calcular cuántos días han pasado desde la contratación de cada empleado
SELECT FirstName, LastName, DATEDIFF(DAY, HireDate, GETDATE()) AS DaysEmployed
FROM Employees;
-- Explicación:
-- DATEDIFF(DAY, HireDate, GETDATE()): Calcula la diferencia en días entre la fecha de contratación (HireDate) y la fecha actual (GETDATE()).
-- DaysEmployed: Alias que muestra la cantidad de días que han pasado desde la contratación del empleado.



-- Obtener el nombre completo de los empleados (concatenando FirstName y LastName)
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;
-- Explicación:
-- CONCAT(FirstName, ' ', LastName): Une el primer nombre (FirstName), un espacio (' ') y el apellido (LastName) en una sola cadena.
-- FullName: Alias que contiene el nombre completo del empleado.

-- Obtener una subcadena del "FirstName" (primeros 3 caracteres)
SELECT SUBSTRING(FirstName, 1, 3) FROM Employees;
-- Explicación:
-- SUBSTRING(FirstName, 1, 3): Extrae una subcadena del primer nombre (FirstName) comenzando desde la primera letra (posición 1) y con una longitud de 3 caracteres.
-- Esto devuelve los primeros 3 caracteres del primer nombre de cada empleado.




-- Buscar empleados cuyo salario esté entre 50,000 y 80,000, y que estén en el departamento de 'IT'
SELECT *
FROM Employees
WHERE Salary BETWEEN 50000 AND 80000
AND Department = 'IT';



-- Convertir una cadena a un número
SELECT CAST('12345' AS INT);
-- Convertir una fecha a una cadena
SELECT CONVERT(VARCHAR, GETDATE(), 103);  -- Estilo 103: DD/MM/YYYY

