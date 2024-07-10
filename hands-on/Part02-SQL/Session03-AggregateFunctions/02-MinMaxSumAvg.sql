USE Northwind
------------------------------------------------------------------------------------
-- LÍ THUYẾT
-- B ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàm gom nhóm - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()
-- * CÚ PHÁP CHUẨN
-- SELECT CỘT... HÀM GOM NHÓM()... FROM <TABLE> WHERE...
-- SELECT CỘT,.. HÀM GOM NHÓM(), ... FROM <TABLE> WHERE ... GROUP BY ... HAVING(WHERE THỨ 2)
------------------------------------------------------------------------------------
-- THỰC HÀNH
-- 1. Liệt kê danh sách nhân viên
SELECT * FROM Employees

-- 2. Năm sinh nào là bé nhất
SELECT MIN(BirthDate) FROM Employees --chơi theo cột
SELECT MAX(BirthDate) FROM Employees --chơi theo cột

-- 3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
SELECT * FROM Employees WHERE BirthDate = (
											SELECT MIN(BirthDate) FROM Employees
										  )
SELECT * FROM Employees WHERE BirthDate <= (
											SELECT MIN(BirthDate) FROM Employees
										  )
SELECT * FROM Employees WHERE BirthDate <= ALL (SELECT BirthDate FROM Employees)

--4.1 Trong các đơn hàng đơn hàng nào có trọng lượng nhỏ nhất/lớn nhất
--4.2 Trong lượng nào là lớn nhất trong các đơn hàng đã bán
SELECT * FROM Orders Order by Freight Desc
--4.1
SELECT MAX(Freight) FROM Orders
--4.2
SELECT * FROM Orders WHERE Freight = (SELECT MAX(Freight) FROM Orders)
SELECT * FROM Orders WHERE Freight >= ALL (SELECT MAX(Freight) FROM Orders)
SELECT * FROM Orders WHERE Freight >= ALL (SELECT Freight FROM Orders)

--5. Tính tổng khối lượng các đơn hàng đã vận chuyển
--830
SELECT * FROM Orders
SELECT COUNT(*) FROM Orders --1 dòng 830
SELECT SUM(Freight) AS [Freight in total] FROM Orders --64942.69

--6. Trung bình các đơn hàng nặng bao nhiêu
SELECT AVG(Freight)  FROM Orders --78.2442

--7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT * FROM Orders WHERE Freight >= (
					 SELECT AVG(Freight) FROM Orders
					 )
SELECT * FROM Orders WHERE Freight >= ALL (SELECT AVG(Freight) FROM Orders)

--8. Có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả --242 Only
SELECT COUNT(*) FROM Orders WHERE Freight >= (
							SELECT AVG(Freight) FROM Orders
							)
--CHỈ NHỮNG THẰNG LỚN HƠN TRUNG BÌNH THÌ MỚI ĐẾM, HOK CHIA NHÓM À NHEN
SELECT COUNT(*) FROM (
					 SELECT * FROM Orders 
							  WHERE Freight >= (
												SELECT AVG(Freight) FROM Orders
											  )
					 ) AS [AVG]
