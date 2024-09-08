USE Northwind
--1. In ra thông tin các sản phẩm (nhãn hàng/mặt hàng) có trong hệ thống
SELECT * FROM Products
-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, mã chủng loại, đơn giá, số lượng trong kho 
SELECT p.ProductID, p.ProductName, p.SupplierID, p.CategoryID, p.UnitPrice, p.UnitsInStock FROM Products p
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp (quốc gia)
SELECT p.ProductID, p.ProductName, p.SupplierID, s.CompanyName, s.Country FROM Products p 
										INNER JOIN Suppliers s 
										ON p.SupplierID = s.SupplierID 
-- Output 3: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại
SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName FROM Products p 
																JOIN Categories c 
																ON p.CategoryID = c.CategoryID
-- Output 4: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp
SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName, p.SupplierID, s.CompanyName, s.Country 
FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID 
                JOIN Suppliers s ON p.SupplierID = s.SupplierID 

--2. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Mỹ
SELECT * FROM Products p JOIN Suppliers s ON p.SupplierID = s.SupplierID WHERE s.Country = 'USA'
-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 
SELECT p.ProductID, p.ProductName, p.CategoryID, s.CompanyName, s.Country, p.UnitPrice, p.UnitsInStock 
FROM Products p JOIN Suppliers s 
ON p.SupplierID = s.SupplierID 
WHERE s.Country = 'USA'
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, đơn giá, số lượng trong kho, mã chủng loại,
--tên chủng loại 
SELECT p.ProductID, p.ProductName, p.CategoryID, s.CompanyName, p.UnitPrice, p.UnitsInStock, p.CategoryID, c.CategoryName 
FROM Products p JOIN Suppliers s 
ON p.SupplierID = s.SupplierID 
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE s.Country = 'USA'

--3. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Anh, Pháp, Mỹ
-- Output: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 
SELECT p.ProductID, p.ProductName, p.CategoryID, s.CompanyName, s.Country, p.UnitPrice, p.UnitsInStock 
FROM Products p JOIN Suppliers s 
ON p.SupplierID = s.SupplierID 
WHERE s.Country IN ('USA','FRANCE', 'Uk')

--4. Có bao nhiêu nhà cung cấp?
SELECT * FROM Suppliers
SELECT COUNT(CompanyName) AS [No Supplier] FROM Suppliers

--5. Có bao nhiêu nhà cung cấp đến từ Mỹ
SELECT COUNT(CompanyName) AS [No Supplier] FROM Suppliers WHERE Country = 'USA'

--6. Nhà cung cấp Exotic Liquids cung cấp những sản phẩm nào
SELECT * FROM Suppliers WHERE CompanyName = 'Exotic Liquids'
SELECT * FROM Products p JOIN Suppliers s ON p.SupplierID = s.SupplierID WHERE s.CompanyName = 'Exotic Liquids'
-- Output 1: mã sản phẩm, tên sản phẩm, đơn giá, số lượng trong kho
SELECT p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock 
FROM Products p JOIN Suppliers s 
ON p.SupplierID = s.SupplierID 
WHERE s.CompanyName = 'Exotic Liquids'
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName 
FROM Products p JOIN Suppliers s  
				ON p.SupplierID = s.SupplierID 
				JOIN Categories c 
				ON c.CategoryID = p.CategoryID
WHERE s.CompanyName = 'Exotic Liquids'
-- Output 3: mã nhà cung cấp, tên nhà cung cấp, mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.SupplierID, s.CompanyName, p.ProductID, p.ProductName, p.CategoryID, c.CategoryName 
FROM Suppliers s JOIN Products p 
                 ON s.SupplierID = p.SupplierID
				 JOIN Categories c 
				 ON p.CategoryID = c.CategoryID
WHERE s.CompanyName = 'Exotic Liquids'

--7. Mỗi nhà cung cấp cung cấp bao nhiêu mặt hàng (nhãn hàng)
SELECT * FROM Categories
-- Output 1: mã nhà cung cấp, số lượng mặt hàng
SElECT p.SupplierID, p.UnitsInStock FROM Suppliers s JOIN Products p ON s.SupplierID = p.SupplierID 
-- Output 2: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
SElECT p.SupplierID, s.CompanyName, p.UnitsInStock FROM Suppliers s JOIN Products p ON s.SupplierID = p.SupplierID

--8. Nhà cung cấp Exotic Liquids cung cấp bao nhiêu nhãn hàng?
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
SElECT p.SupplierID, s.CompanyName, p.UnitsInStock FROM Suppliers s JOIN Products p ON s.SupplierID = p.SupplierID 
WHERE s.CompanyName = 'Exotic Liquids'