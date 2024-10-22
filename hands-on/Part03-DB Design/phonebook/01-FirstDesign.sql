CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV1
(
	Nick nvarchar(30),
	Phone varchar(50),

) -- 3 số phome gom vào 1 cột
SELECT * FROM PhoneBookV1
INSERT INTO PhoneBookV1 VALUES(N'sangnt', '090x')
-- An có 2 số phone, làm sao lưu?
INSERT INTO PhoneBookV1 VALUES(N'annguyen', '090x, 091x')

-- Bình có 3 số phone, làm sao lưu? mày ko thấy t để độ rộng của cột phone là
-- 50 à
INSERT INTO PhoneBookV1 VALUES(N'binhle', '090x, 091x, 092x')

--***** PHÂN TÍCH: 
-- >>>>> ƯU ĐIỂM: SELECT PHONE LÀ RA ĐC TÂT CẢ CÁC SỐ DI ĐỘNG

-- >>>>> Cho tui biết số để bàn, ở nhà của a binhle??? TOANG
-- >>>>> Đáp án: quy ước số đầu tiên là để bàn, số 2 là di động, 3 là work
-- >>>>> khốn nạn vì quy ước ngầm, số nào là loại nào!!! khó nhớ cho
--		 người nhập liệu
-- >>>>> In cho tui số di động của mọi người???
INSERT INTO PhoneBookV1 VALUES(N'binhle', '090x | 091x | 092x')
INSERT INTO PhoneBookV1 VALUES(N'cuongvo', '090x, 091x, 092x')
INSERT INTO PhoneBookV1 VALUES(N'dungphan', '090x-091x-092x')
-- >>>>> Tiêu chí cắt chuỗi - DELIMITER DẤU PHÂN CÁCH KO NHẤT QUÁN
-- >>>>> quy ước ngầm về nhập dấu phân cách

-- đếm xem mỗi người có bao nhiêu số phone!!! COUNT() QUÁ QUEN
-- dấu phân cách khó khăn cho cắt để count!!!

-- KHÓ KHĂN XẢY RA KHI TA GOM NHIỀU CÙNG NGỮ NGĨA NÀO 
-- TRONG 1 COLUMN (cột Phone lưu nhiều số phone cách nhau bằng dấu cách)
-- gây khó khăn cho nhập dữ liệu (ko nhất quán dấu cách), khi select
-- count() thống kê theo tiêu chí (in số phone ở nhà)
-- update thêm phone mới, xoá số cũ, dịch chuyển quy ước đầu giờ :)))

-- MỘT CELL MÀ CHỨA NHIỀU VALUE CÙNG KIỂU ĐƯỢC GỌI LÀ CỘT ĐA TRỊ
-- MULTI-VALUED COLUMN -> TIỀM ẨN NHIỀU KHÓ KHĂN CHO VIỆC XỬ LÍ DATA

-- NẾU 1 TABLE CÓ CỘT ĐA TRỊ NGƯỜI TA NÓI RẰNG NÓ ÉO ĐẠT CHUẨN 
--LEVEL THIẾT KẾ CHÁN QUÁ - 1ST NORMALIZATION FORM

-- CHUẨN 1, CHẤT LƯỢNG THIẾT KẾ TÍNH TỪ LEVEL 1 2 3....

-- THIẾT KẾ KIẾM THÌ PHẢI NÂNG CẤP, KO CHƠI ĐA TRỊ NỮA
-- KO CHƠI GOM VALUE TRONG 1 VALUE
-- 2 CHIẾN LƯỢC FIX
-- CHIỀU NGANG(thêm cột), CHIỀU DỌC( thêm dòng)!!!!!****


