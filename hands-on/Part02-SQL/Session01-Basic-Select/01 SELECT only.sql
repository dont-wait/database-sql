USE Northwind -- Chọn để chơi với thùng chứa data nào đó
			  -- tại 1 thời điểm chơi với 1 thùng chứa data

SELECT * FROM Customers

SELECT * FROM Employees

------------------------------------------------
-- LÍ THUYẾT
-- 1. DBE cung cấp câu lệnh SELECT dùng để
--		in ra màn hình 1 cái gì đó ~~~ printf() sout()
--		in ra dữ liệu có trong table (hàng/cột)!!!!!!!!!!!!!!
--		dùng cho mục đích nào thì kết quả hiển thị luôn là 1 table
------------------------------------------------

-- 1. Hôm nay là ngày bao nhiêu???
SELECT GETDATE()

SELECT GETDATE() AS [Hôm nay là ngày]

-- 2. Hôm nay là tháng mấy???
SELECT YEAR(GETDATE()) AS [Hôm nay là năm]
SELECT MONTH(GETDATE()) AS [Hôm nay là tháng]

-- 3. Trị tuyệt đối của -5 là???
SELECT ABS(-5) AS [Trị tuyệt đối của -5 là]

-- 4. 5 + 5 là
SELECT SUM(5+5) AS [năm cộng năm bằng: ]
SELECT 5 + 5

-- 5. In ra tên của mình
SELECT N'Sang Ngọc Trinh' AS [My full name is: ]
SELECT N'Sang' + N'Ngọc Trinh' AS [My full name is: ]

-- 6. Tính tuổi
SELECT 2024 - 2005
SELECT YEAR(GETDATE()) - 2005
--nếu không convert thì máy sẽ không hiểu vì lộn xộn data
-- PHẢI QUY VỀ 1 KIỂU DATA TYPE
SELECT N'Sang' + N'Ngọc Trinh ' + CONVERT(varchar, YEAR(GETDATE()) - 2005) + ' years old' AS [My profile]

SELECT N'Sang' + N'Ngọc Trinh ' + CAST(YEAR(GETDATE()) - 2005 AS varchar) + ' years old' AS MyProfile
 
 -- 7. Nhân 2 số
SELECT 10 * 10 AS [10x10]