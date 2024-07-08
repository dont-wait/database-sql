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
