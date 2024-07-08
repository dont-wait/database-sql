USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của câu lệnh SELECT
-- SELECT * FROM <TABLE> WHERE ...

-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT LIKE PATTERN NÀO ĐÓ e.g. '____'
-- WHERE CỘT BETWEEN RANGE
-- WHERE CỘT IN (TẬP HỢP GIÁ TRỊ ĐC LIỆT KÊ)

-- MỘT CÂU SELECT TUỲ CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 VALUE/CELL
-- MỘT CÂU SELECT TUỲ CÁCH VIẾT CÓ THỂ TRẢ VỀ 1 TẬP GÍA TRỊ/CELL
-- TẬP KẾT QUẢ NÀY ĐỒNG NHẤT( CÁC GIÁ TRỊ KHÁC NHAU CỦA 1 BIẾN)

--*****
-- WHERE CỘT = VALUE NÀO ĐÓ - đã học, e.g YEAR(DOB) = 2003
--			 = THAY VALUE NÀY = 1 CÂU SQL KHÁC MIỄN TRẢ VỀ 1 CELL
-- KĨ THUẬT VIẾT CÂU SQL THEO KIỂU HỎI GIÁN TIẾP, LỒNG NHAU, TRONG
-- CÂU SQL CHỨA CÂU SQL KHÁC
------------------------------------------------
--THỰC HÀNH
--1. In ra danh sách nhân viên
SELECT * FROM Employees
SELECT FirstName FROM Employees WHERE EmployeeID = 1 --return 1 cell not 1 row
SELECT FirstName FROM Employees --1 tập giá trị/1 cột/phép chiếu ĐỒNG NHẤT DỮ LIỆU(FIRST NAME) THAM CHIẾU

--2. Liệt kê các nhân viên ở London
SELECT * FROM Employees WHERE City = 'London'

--3. Liệt kê các nhân viên cùng quê với King Robert
SELECT * FROM Employees WHERE FirstName = 'Robert'
SELECT City FROM Employees WHERE FirstName = 'Robert'

-- đáp án cho câu 3 bắt đầu
--SELECT City FROM Employees WHERE City = City quê Robert
--SELECT City FROM Employees WHERE City = 'London' - thay london = Robert
SELECT * FROM Employees 
		 WHERE City = (
						SELECT City FROM Employees 
						WHERE FirstName = 'Robert'												
					  )
				AND FirstName != 'Robert'
-- câu này cho 9.9 điểm, trong kết quả vẫn còn Robert, bị dư, tìm cùng quê Robert thì 
-- không cần nói lại Robert

--4. Liệt kê các đơn hàng
SELECT * FROM Orders ORDER BY Freight DESC

--4.1 Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn 252kg
SELECT * FROM Orders WHERE Freight >= 252 --47

--4.2 Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng đơn hàng 10555
--SELECT * FROM Orders WHERE Freight >= ??? của đơn hàng 10555
SELECT * FROM Orders WHERE Freight >= (
										SELECT Freight FROM Orders
										WHERE OrderID = 10555
									) --47 xuất hiện lun 10555

SELECT * FROM Orders WHERE Freight >= (
										SELECT Freight FROM Orders
										WHERE OrderID = 10555
									) --46
						   AND OrderID != 10555

-- BTVN
--1. Liệt kê danh sách các công ty vận chuyển hàng
SELECT * FROM Shippers --5      

--2. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận 
--	 có mã số là 1
SELECT * FROM Orders WHERE ShipVia = 1 --249

--3. Liệt kê danh sách các đơn hàng đc vận chuyển bởi công ty giao vận
--   có tên Speedy Express
SELECT * FROM Shippers
SELECT * FROM Orders WHERE ShipVia = (
							SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express'
							)
--4. Liệt kê danh sách các đơn hàng đc vận chuyển bởi công ty giao vận
--   có tên Speedy Express và trọng lượng từ 50 - 100
SELECT * FROM Orders WHERE ShipVia = (
							SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express'
							)
							AND Freight BETWEEN 50 AND 100
							--	        IN là so sánh =, Thay cho 1 đóng OR
--5. Liệt kê các mặt hàng cùng chủng loại Cato với mặt hàng Filo Mix
SELECT * FROM Products WHERE CategoryID = (
											SELECT CategoryID FROM Products WHERE ProductName = 'Filo Mix'
											)
								AND ProductName != 'Filo Mix' --6
--6. Liệt kê các nhân viên trẻ tủi hơn nhân viên Janet
SELECT * FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) <
																	(
							SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees 
							WHERE FirstName = 'Janet'
							) --1
SELECT * FROM Employees WHERE BirthDate >	(
											SELECT BirthDate AS Age FROM Employees 
											WHERE FirstName = 'Janet'
							) --1
