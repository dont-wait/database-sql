USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của câu lệnh SELECT
-- SELECT * FROM <TABLE> WHERE ...

-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT IN (MỘT TẬP HỢP NÀO ĐÓ)
-- ví dụ: City IN('London', 'Berlin', 'NewYork) -- thay thế cho OR OR
											    -- City = ten-city OR City = ten-city
-- NẾU CÓ 1 CÂU SQL MÀ TRẢ VỀ ĐƯỢC 1 CỘT, NHIỀU DÒNG
-- MỘT CỘT VÀ NHIỀU DÒNG THÌ TA CÓ THỂ XEM NÓ TƯƠNG ĐƯƠNG MỘT TẬP HỢP
-- SELECT CITY FROM EMPLOYEES, BẠN ĐC 1 LOẠT CÁC T/P
-- TA CÓ THỂ NHÉT/LỒNG CÂU 1 CỘT/NHIỀU DÒNG VÀO TRONG MỆNH ĐỀ IN CỦA CÂU SQL BÊN NGOÀI
-- Bác Long muốn mua rau, thịt cá nhưng đang dịch Covid Thế nên bác không thể đi mua trực tiếp mà phải thông qua anh Bộ đội
-- gián típ mua giúp vì chỉ anh ms bt chỗ mua, (kết nối 2 Table)
-- * CÚ PHÁP
-- WHERE CỘT IN (MỘT CÂU SELECT TRẢ VỀ 1 CỘT NHIỀU DÒNG - NHIỀU VALUE CÙNG KIỂU - TẬP HỢP)
----------------------------------------------------------------------
-- THỰC HÀNH
--1. Liệt kê các nhóm hàng
SELECT * FROM Categories

--2. In ra các món hàng/mặt hàng thuộc nhóm 1, 6, 8
SELECT * FROM Products WHERE CategoryID IN(1,6,8)	
SELECT * FROM Products WHERE CategoryID = 1 OR CategoryID = 6 OR CategoryID = 8

--3. In ra các món hàng thuộc nhóm bia/rượu, thịt và hải sản
SELECT * FROM Products WHERE CategoryID IN (SELECT CategoryID FROM Categories 
											WHERE CategoryName 
											IN('Beverages', 'Meat/Poultry', 'Seafood')
											)

--4. Nhân viên quê London phụ trách những đơn hàng nào
SELECT * FROM Employees WHERE City = 'London'
SELECT * FROM Orders WHERE EmployeeID IN (
											SELECT EmployeeID FROM Employees 
															  WHERE City = 'London'
										)

--BTVN
--1. Nhà cung cấp đến từ Mỹ cung cấp những mặt hàng nào
SELECT * FROM Suppliers
SELECT * FROM Products WHERE SupplierID IN (
											SELECT SupplierID FROM Suppliers WHERE Country = 'USA')

--2. Nhà cung cấp đến từ Mỹ cung cấp những nhóm hàng 
SELECT * FROM Categories WHERE CategoryID IN (SELECT CategoryID FROM Suppliers WHERE Country = 'USA')
--3. các đơn hàng vận chuyển tới thành phố Sao Paulo đc vận chuyển bởi những hãng nào
--   Các cty nào đã vận chuyển hàng tới Sao Paulo
SELECT * FROM Shippers
SELECT * FROM Orders
SELECT * FROM Shippers WHERE ShipperID IN (SELECT ShipVia FROM Orders WHERE ShipCity = 'Sao Paulo')
--4. Khách hàng đến từ London, Berlin, Madrid có những đơn hàng nào
--	 Liệt kê các đơn hàng của khách hàng đến từ Berlin, London, Madrid
SELECT * FROM Customers
SELECT * FROM Orders WHERE ShipCity IN (SELECT DISTINCT City FROM Customers WHERE City IN ('Berlin', 'London', 'Madrid'))