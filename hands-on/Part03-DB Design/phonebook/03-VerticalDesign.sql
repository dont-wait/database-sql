CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV2
(
	Nick nvarchar(30),
--	Phone varchar(50), --cấm đa trị, cấm gộp nhiều số phone trong 1 cell
	Phone1 char(11),
	Phone2 char(11),
	Phone3 char(11) --éo biết cột nào là loại nào, 1 2 3 vô hồn

) -- 3 số phome gom vào 1 cột
CREATE TABLE PhoneBookV2_
(
	Nick nvarchar(30),
--	Phone varchar(50), --cấm đa trị, cấm gộp nhiều số phone trong 1 cell
	HomePhone char(11),
	WorkPhone char(11),
	CellPhone char(11) 

) -- 3 số phome gom vào 1 cột
-- MỞ RỘNG TABLE THEO CHIỀU NGANG - THÊM CỘT
SELECT * FROM PhoneBookV2_


INSERT INTO PhoneBookV2_ VALUES(N'sangnt', NULL, NULL, '090x')
INSERT INTO PhoneBookV2_ VALUES(N'annguyen', '090x', '091x', NULL)

INSERT INTO PhoneBookV2_ VALUES(N'binhle', '090x', '091x', '092x')

--***** PHÂN TÍCH: 
-- >>>>> ƯU ĐIỂM: SELECT PHONE LÀ RA ĐC TÂT CẢ CÁC SỐ DI ĐỘNG LUÔN
--1.SQL. Cho tui bt các số di động của mội người
SELECT p.Nick, p.CellPhone FROM PhoneBookV2_ p 
-- >>>>> Cho tui biết số để bàn, ở nhà của a binhle??? 
-- >>>>> In cho tui số di động của mọi người???

SELECT p.Nick, p.CellPhone FROM PhoneBookV2_ p WHERE P.Nick = 'binhle'

-- >>>>> NHƯỢC ĐIỂM
--> Thống kê số điện thoại đang có, mấy sim??? kko trả lời được
--> Data bị null, phí không gian lưu trữ
--> NGƯỜI CÓ 4 PHONE, 5 PHONE THÌ SAO???
--> solution: thêm cột, càng thêm cột để trừ hao về người nhiều phone, những người còn lại thì bị null càng nhiều
--> PHÍ VÌ CHỈ VÌ MỘT VÀI NGƯỜI NHIỀU PHONE THÌ MỌI NGƯỜI ĐỀU PHẢI XEM CHUNG LÀ NHIỀU SỐ PHONE -> PHÍ KHÔNG GIAN LƯU TRỮ
--> WHERE CỨNG TRÊN CÁI CỘT LÀ KHÔNG HAY
--> GIẢ SỬ VẪN QUYẾT TÂM THEO CỘT, NỞ CỘT RA, THÌ  GIÁ PHẢI TRẢ SỬA CODE LẬP TÌNH
--> SAU NÀY, VÌ TÊN CỘT MỚI ĐC THÊM VÔ KHI NÂNG CẤP APP, SỬA THÊM CÂU QUERY

--> TRIẾT LÍ THIẾT KẾ: CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ, KO THÊM CỘT CỦA TABLE, CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG SỐ LƯỢNG

--> PHIÊN BẢN 3 - PHIÊN BẢN NGON BẮT ĐẦU, AI NHIỀU PHONE THÌ NHIỀU DÒNG, NHIỀU CELL THEO CHIỀU DỌC THÊM DÒNG
--> COUNT NGON LÀNH LUÔN, TRẢ LỜI NGAY ĐC CÂU BAO NHIÊU SIM BAO NHIÊU DÒNG


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


