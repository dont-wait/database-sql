USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- Trong thực tế có những lúc ta muốn tìm dữ liệu/filter theo kiểu gần đúng
-- gần đúng trên kiểu chuỗi, ví dụ, liệt kê ai đó có tên là AN, khác câu 
-- liệt kê ai đó tên bắt đầu bằng chữ A
-- Tìm đúng, TOÁN TỬ = 'AN'
-- Tìm gần đúng, tìm có SỰ XUẤT HIỆN, KO DÙNG =, DÙNG TOÁN TỬ LIKE
--						LIKE 'A'...
-- ĐỂ SỬ DỤNG TOÁN TỬ LIKE, TA CẦN THÊM 2 SỰ TRỢ GIÚP, DẤU % VÀ DẤU _
-- % đại diện cho 1 chuỗi bất kì nào đó, 
-- _ đại diện dùng cho  1 kí tự đặc biệt nào đó
-- Ví dụ: NAME LIKE 'A%', bất kì ai có tên xh bằng chữ A, phần còn lại là gì ko care
--		  NAME LIKE 'A_', bất kì ai có tên là 2 kí tự, trong đó kí tự đầu phải là A
-- 1. In ra ds nv
SELECT * FROM Employees

-- 2. Nhân viên nào có tên bắt đầu bằng chữ A
-- ở đây và dùng dấu = là nói máy đang đi tìm ai tên 'A%'
SELECT * FROM Employees WHERE FirstName LIKE 'A%'

-- 2.1 Nhân viên nào có tên bắt đầu bằng chữ A, in cả full name ghép đầu đủ
SELECT EmployeeID, FirstName + ' ' + LastName AS [Full Name] FROM Employees WHERE FirstName LIKE 'A%'
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS [Full Name] 
					FROM Employees WHERE FirstName LIKE 'A%'

-- 3. Nhân viên nào có tên chữ A cuối cùng
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS [Full Name] 
					FROM Employees WHERE FirstName LIKE '%A'

-- 4. Nhân viên nào có 4 kí tự
-- Dùng hàm kiểm tra độ dài của tên coi có bằng 4 hay ko - homework
SELECT * FROM Employees WHERE FirstName LIKE '____'

-- 5. Xem danh sách các sản phẩm/món đó đang có - Product
SELECT * FROM Products

-- 6. Những sản phẩm nào có tên bắt đầu 'CH'
SELECT * FROM Products WHERE ProductName LIKE 'Ch%'

SELECT * FROM Products WHERE ProductName LIKE '%Ch%'
-- Trong tên có từ Ch, ko quan tâm vị trí xuất hiện

-- 7. Những sản phẩm nào có tên có 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '_____'

-- 8. Những sản phẩm nào có tên sản phẩm mà có từ cuối là 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '%_____' -- tên có từ 5 kí tự trở lên

SELECT * FROM Products WHERE ProductName LIKE '% _____' -- tên có ít nhất 2 từ 
														-- từ cuối 5 kí tự
														-- VÔ TÌNH LOẠI ĐI THẰNG
														-- TÊN CHỈ CÓ 5 KÍ TỰ
SELECT * FROM Products WHERE ProductName LIKE '% _____' OR ProductName LIKE '_____'
