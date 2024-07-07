USE Northwind
------------------------------------------------
-- LÍ THUYẾT

-- CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- MỆNH ĐỀ WHERE: DÙNG LÀM BỘ LỘC/FILTER/NHẶT RA NHỮNG DỮ LIỆU TA CẦN THEO 1 TIÊU CHÍ NÀO ĐÓ
-- VÍ DỤ: Lọc ra những sv có quê ở Bình DƯơng
--		  Lọc ra những sv có quê ở Tiền Giang và điểm tb >= 8

-- CÚ PHÁP DÙNG BỘ LỌC
-- SELECT  (cột bạn muốn in ra) FROM <TÊN_TABLE> WHERE <ĐIỀU KIỆN LỌC>
-- * ĐIỀU KIỆN LỌC: TÌM TỪNG DÒNG, VỚI CÁI-CỘT CÓ GIÁ TRỊ CẦN LỌC
--					LỌC THEO TÊN CỘT VỚI VALUE THẾ NÀO, LẤY TÊN CỘT, XEM VALUE TRONG CELL
--					CÓ THOẢ ĐIỀU KIỆN LỌC HAY KO?
-- ĐỂ VIẾT ĐK LỌC TA CẦN
--    > tên cột
--	  value của cột (cell)
--    toán tử (operators) > >= <= =(một ấu = hoy, ko giống C Java ==), !=, <> (!= hoặc dùng <> cùng 1 ý nghĩa)
--	  nhiều dk lọc đi kèm, dùng thêm logic operator, AND, OR, NOT (~~~~ J, C: && || !=)
-- VÍ DỤ: WHERE City = N'Bình Dương'
--        WHERE City = N'Tiền Giang' AND Gpa >= 8

-- LỌC LIÊN QUAN ĐẾN GIÁ TRỊ/VALUE/CELL CHỨA GÌ, TA PHẢI QUAN TÂM ĐẾN DATA TYPES
-- Số: nguyên/thực, ghi số ra như truyền thống 5, 110, 3.14, 9.8
-- Chuỗi/kí tự: 'A', 'Ahihi'
-- Ngày tháng: '2003-01-02'
---------------------------------------------------------
-- THỰC HÀNH
-- 1. In ra danh sách các khách hàng
SELECT* FROM Customers -- 93

-- 2. In ra danh sách khách hàng đến từ Ý
SELECT* FROM Customers WHERE Country = 'Italy'

-- 3. In ra ds k/h đến từ Mỹ
SELECT * FROM Customers WHERE Country = 'USA'

-- 4. In ra những k/h đến từ Mỹ và Ý
--SELECT * FROM Customers WHERE Country = 'USA' AND 'Italy'
-- đời thường có thể nói, những k/h đến từ Ý và Mỹ, Ý hoặc Mĩ
SELECT * FROM Customers WHERE Country = 'USA' AND Country = 'Italy' -- mỗi người thì chỉ ở 1 quốc gia
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Italy' -- 16
-- Sort theo Ý, Mĩ, để gom cùng nhau cho dễ theo dõi
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Italy' ORDER By Country

-- 5. In ra k/h đến từ thủ đô nc Đức
SELECT * FROM Customers WHERE City = 'Berlin' --1
SELECT * FROM Customers WHERE NOT City = 'London'
SELECT * FROM Customers WHERE City = 'Berlin' AND Country = 'Germany' --1

-- 6. In ra thông tin của nv
--SELECT DISTINCT TitleOfCOurtesy FROM Employees
SELECT * FROM Employees

-- 7. In ra thông tin nv có năm sinh từ 1960 trở lên gần đúng
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 --4/9

-- 8. In ra thông tin nv có tuổi từ 60 trở lên
SELECT * FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) >= 60
SELECT *, YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) >= 60
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age, * FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) >= 60

-- 9. Những nv nào ở Luân Đôn
SELECT * FROM Employees WHERE City = 'London'

-- 10. Những nv không ở london
SELECT * FROM Employees WHERE City != 'London'
SELECT * FROM Employees WHERE City <> 'London'
-- Vi diệu, đảo mệnh đề
SELECT * FROM Employees WHERE NOT City = 'London'

-- 11. In ra hồ sơ nv có mã số là 1
-- đi vào ngân hàng giao dịch, hoặc đánh số tk, làm cmdn
-- filter cho cmnd
SELECT * FROM Employees WHERE EmployeeID = 1
-- select mà có where y chỉ 1 dòng trả về, 
select distinct EmployeeID, City FROM Employees Where EmployeeID = 1 order by EmployeeID

-- SELECT ...		FROM ..			WHERE ... GROUP BY ... HAVING ... ORDER BY
--		  DISTINCT	1, N table	
--		  hàm
--        NESTED QUERY/SUB QUERY

-- 12. Xem thông tin bên đơn hàng
SELECT * FROM Orders

-- 13. Xem thông tin bên đơn hàng sắp xếp giảm dần theo trọng lượng
SELECT * FROM Orders ORDER BY Freight DESC

-- 14. Xem thông tin bên đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng >= 500
SELECT * FROM Orders WHERE Freight >= 500 ORDER BY Freight DESC 

-- 15. Xem thông tin bên đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng 100 đến 500
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 ORDER BY Freight DESC 

-- 16. Xem thông tin bên đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng 100 đến 500 và
-- ship bởi  công ty giao vận số 1
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND NOT ShipCity = 'London' ORDER BY Freight DESC 
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND ShipCity <> 'London' ORDER BY Freight DESC 

-- 17. Liệt kê k/h đến từ Mỹ hoặc Mexico
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Mexico'

-- 18. Liệt kê k/h không đến từ Mỹ hoặc Mexico
SELECT * FROM Customers WHERE Country <> 'USA' AND Country <> 'Mexico'
SELECT * FROM Customers WHERE NOT(Country = 'USA' OR  Country = 'Mexico')
SELECT * FROM Customers WHERE Country <> 'USA' AND Country != 'Mexico'

-- 19. Liệt kê các nhân viên sinh ra trong đoạn 1960 1970
SELECT * FROM Employees ORDER BY BirthDate DESC
SELECT * FROM Employees WHERE YEAR(BIRTHDate) >= 1960 AND YEAR(BIRTHDATE) <= 1970 ORDER BY BirthDate DESC




