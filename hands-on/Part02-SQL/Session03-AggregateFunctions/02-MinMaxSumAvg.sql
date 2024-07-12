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

-- NHẮC LẠI
-- CỘT XH TRONG SELECT HÀM Ý DẾM THEO CỘT NÀY, CỘT NÀY PHẢI XUẤT HIỆN TRONG GROUP BY

-- TỈNH <ĐẾM CÁI GÌ ĐÓ CỦA TỈNH> -> RÕ RÀNG PHẢI CHIA THEO TỈNH MÀ ĐẾM
								 -- GROUP BY TỈNH
-- CHUYÊN NGÀNH, <ĐẾM CỦA CHUYÊN NGÀNH> --> CHIA THEO CN MÀ ĐẾM
										-- GROUP BY CHUYÊN NGÀNH
-- CÓ QUYỀN GROUP BY TRÊN NHIỀU CỘT

-- MÃ CHUYÊN NGÀNH, TÊN CHUYÊN NGÀNH <SL SV> -> GROUP BY TRÊN 2 CỘT MÃ CN, TÊN CHUYÊN NGÀNH

-- ÔN TẬP THÊM
-- 1. In danh sách nhân viên
SELECT * FROM Employees

--2. Đếm xem mỗi khu vực có bao nhiêu nv
SELECT COUNT(Region) FROM Employees GROUP BY Region--5 0
--DO NULL KO DC XEM LÀ VALUE ĐỂ ĐẾM, NHƯNG VẪN LÀ 1 VALUE ĐỂ ĐC CHIA NHÓM
--                                   NHÓM KO CÓ GIÁ TRỊ

SELECT COUNT(*) FROM Employees WHERE Region IS NULL --4
SELECT Region, COUNT(*) FROM Employees GROUP BY Region --5 4

--3. Khảo sát đơn hàng 
SELECT * FROM Orders
-- Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) FROM Orders 
							 GROUP BY ShipCountry

--4. Quốc gia nào ncó từ 50 đơn hàng trở lên
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders 
							 GROUP BY ShipCountry
							 HAVING COUNT(*) >= 50

--5 Quốc gia nào có NHIỀU ĐƠN HÀNG NHẤT
SELECT MAX([No orders]) FROM
							(SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders 
																		 GROUP BY ShipCountry
							) AS CTry
							-- CẦN TÌM LỚN NHẤT THÌ PHẢI CÓ BẢNG CHỨA DỮ LIỆU ĐỂ XÉT
							-- CẦN BẢNG CHỨA DỮ LIỆU THÌ PHẢI LỌC DỮ LIỆU TỪ TABLE CHA 
--lấy đc max rồi

SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders 
							 GROUP BY ShipCountry
							 HAVING COUNT(*) = (
												SELECT MAX([No orders]) FROM
													(
													SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders 
													GROUP BY ShipCountry
													) AS Cntry
												)

--6. Liệt kê đơn hàng của k/h có mã VINET
SELECT * FROM Orders WHERE CustomerID = 'VINET'

--7 VINET đã mua bao nhiêu lần
SELECT CustomerID, COUNT(*) FROM Orders 
							WHERE CustomerID = 'VINET'
							GROUP BY CustomerID --KIỂM TRA OKIE THÌ MỚI ĐẾM, LOẠI NHỮNG THG K LIÊN QUAN
SELECT CustomerID, COUNT(*) FROM Orders 
							GROUP BY CustomerID
							HAVING CustomerID = 'VINET' --CHIA XOG RÒI MỚI ĐẾM CÁI MIH CẦN