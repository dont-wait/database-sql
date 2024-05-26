USE Northwind
------------------------------------------------
-- LÍ THUYẾT

-- CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- TA Muốn sắp xếp dữ liệu/sort theo 1 tiêu chí nào đó, thường sẽ là tăng dần - ASCENDING/ASC
--																	 giảm dần - DESCENDING/DESC
-- mặc định không nói năng gì cả thì sort tăng dần
-- A < B < C 
-- 1 < 2 < 3
-- Ta có thể sort nhiều cột
-- SELECT .... FROM <TÊN-TABLE> ORDER BY Tên-Cột MUỐN SORT <KIỂU SORT>
---------------------------------------------------------

--1. in ra ds nhân viên
SELECT * FROM Employees

--2. in ra ds nv tăng dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate ASC
SELECT * FROM Employees ORDER BY BirthDate --- mặc định tăng dần

--3. in ra ds nv giảm dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate DESC

--4. Tính tiền chi tiết mua hành
SELECT * FROM [Order Details]
SELECT *,  UnitPrice * Quantity * (1 - Discount) AS SubTotal FROM [Order Details]

--5. Tính tiền chi tiết mua hàng, sắp xếp giảm dần theo tổng tiền
SELECT * FROM [Order Details]
SELECT *,  UnitPrice * Quantity * (1 - Discount) AS SubTotal FROM [Order Details]
						ORDER BY SubTotal DESC
--6. In ra ds nv giảm dần theo tuổi
SELECT * FROM Employees
SELECT  FirstName, BirthDate, YEAR(GETDATE()) - YEAR(BirthDate) AS Age  FROM Employees 
ORDER BY Age DESC