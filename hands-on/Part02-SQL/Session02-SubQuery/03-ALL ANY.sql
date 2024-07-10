USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của câu lệnh SELECT
-- SELECT * FROM <TABLE> WHERE ...
-- WHERE CỘT TOÁN-TỬ-SO-SÁNH VỚI VALUE-CẦN-LỌC
--       CỘT > >= <= = != VALUE
--						  DÙNG CÂU SUB-QUERY TUỲ NGỮ CẢNH
--       CỘT            = (SUB CHỈ CÓ 1 VALUE)
--       CỘT            IN (SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)
--		 CỘT			> >= < <= ALL (1 CÂU SUB 1 CỘT NHIỀU VALUE)
--		 CỘT			          ANY (1 CÂU SUB 1 CỘT NHIỀU VALUE)

------------------------------------------------
-- THỰC HÀNH
-- tạo 1 table có 1 cột tên là Numbr, chỉ chứa 1 đống dòng các số nguyên
CREATE TABLE Num
(
	Numbr int

)
SELECT * FROM Num
INSERT INTO Num values (1)
INSERT INTO Num values (1)
INSERT INTO Num values (2)
INSERT INTO Num values (9)
INSERT INTO Num values (5)
INSERT INTO Num values (100)
INSERT INTO Num values (101)

--1. In ra những số > 5
SELECT * FROM Num WHERE Numbr > 5

--2. In ra số lớn nhất trong các số đã nhập
--SỐ LỚN NHẤT TRONG 1 ĐÁM ĐC ĐỊNH NGHĨA LÀ: MÀY LỚN HƠN CẢ ĐÁM ĐÓ VÀ BẰNG CHÍNH NÓ
--lớn hơn tất cả, ngoại trừ chính mình -> mình là MAX CỦA ĐÁM
SELECT * FROM Num WHERE Numbr = 101 --lầy
SELECT * FROM Num WHERE Numbr >= ALL (SELECT * FROM Num)

--3. SỐ nhỏ nhất là số nào?
SELECT * FROM Num WHERE Numbr <= ALL (SELECT * FROM Num)

SELECT * FROM Num WHERE Numbr > ALL (SELECT * FROM Num) --bạn đang top 1, không thể 
														--cao hơn nx, chả lẻ bạn lại lớn hơn cả bạn =)
--4. Nhân viên nào lớn tuổi nhất
SELECT * FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) >= ALL (SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees )
--5. Đơn hàng nào có trọng lượng nặng nhất
SELECT * FROM Orders WHERE Freight >= ALL (SELECT Freight FROM Orders)