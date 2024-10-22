CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK
--------------------------------------
-- TA CẦN GIẢI QUYẾT LOẠI ĐIỆN THOẠI NÀO
CREATE TABLE PhoneBookV3_2
(
	Nick nvarchar(30), -- ngoài cột này bị lặp lại, mình còn cần thêm cột fullname, email, company, chức vụ,...
	--...CompanyName,...
	Phone char(11), --CẦN THÊM THÔNG TIN PHONE
	PhoneType nvarchar(10) --090x Home, 091x Work
)
CREATE TABLE PhoneBookV4_1
(
	Phone char(11), 
	PhoneType nvarchar(10),
	Nick nvarchar(30) --chỉ cần join vẫn okie
)
CREATE TABLE Person (
	Nick nvarchar(30),
	Title nvarchar(30),
	Company nvarchar(40)
)
SELECT * FROM PhoneBookV4_1
SELECT * FROM Person
----------------------------------------
-- TÁCH BẢNG
-- INFO BỊ PHÂN MẢNH, NẰM NHIỀU NƠI, PHẢI JOIN RỒI
-- NHẬP DATA COI CHỪNG BỊ VÊNH, XOÁ DATA COI CHỪNG LẠC TRÔI,
-- PHÂN MẢNH PHẢI CÓ LÚC TÁI NHẬP (JOIN) TRÊN CỘT MẸ NÀO???
-- FK XUẤT HIỆN???
-- hok thích vơi fk đc ko??? đc và ko đc
-- nếu chỉ cần join éo cần fk, cột = value, khớp là join, nối bảng
-- nếu kèm thêm xoá, sửa, thêm, lộn xộn ko nhất quán

INSERT INTO Person VALUES(N'sangnt', 'Lecture', 'HUIT')
INSERT INTO Person VALUES(N'annguyen', 'Lecture', 'HUIT')
INSERT INTO Person VALUES(N'binhle', 'Lecture', 'HUIT')


INSERT INTO PhoneBookV4_1 VALUES('090x', 'Cell', N'sangnt')

INSERT INTO PhoneBookV4_1 VALUES('090x', 'Cell', N'annguyen')		
INSERT INTO PhoneBookV4_1 VALUES('091x', 'Home', N'annguyen')

INSERT INTO PhoneBookV4_1 VALUES('090x', 'Cell', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES('091x', 'Cell', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES('092x', 'Home', N'binhle')

-- PHÂN TÍCH 
-- *ƯU ĐIỂM
-- COUNT NGON, GROUP BY theo nick, theo loại phone
--Where theo loại phone ngon
SELECT * FROM PhoneBookV3_2 WHERE PhoneType = 'Cell'
-- *NHƯỢC ĐIỂM
-- Redundancy trên info của nick/full/cty/email/năm sinh... giải quyết được bên Person
	-- Tính nhất quán (inconsistency) của loại phone: có người gõ: Cell, CELL, cell éo sợ vì cùng một kiểu
	--	gõ them: Di động -> người hiểu
	-- máy hiểu khác nhau

	--quẻy liệt kê các số di động của tất cả mọi người, toang khi WHERE
	-- vì éo biết được có bao nhiêu loại chữ biểu diễn cho DI ĐỘNG
INSERT INTO PhoneBookV4_1 VALUES('098x', 'MOBILE', 'binhle')
INSERT INTO PhoneBookV4_1 VALUES('098x', 'Sugardaddy', 'binhle')

-- SQL. Liệt kê các số di động của bình lê
--SELECT * FROM PhoneBookV4_1 WHERE PhoneType = 'CELL' OR PhoneType = 'Mobile' OR PhoneType
SELECT * FROM PhoneBookV4_1 WHERE PhoneType IN ('Cell', 'CELL')
	--tính in đến bao giờ, khi người ta còn gõ được những người khác mà còn 
	--biểu diễn được khái niệm di động

-- QUY TẮC THÊM: CÓ NHỮNG LOẠI DỮ LIỆU BIẾT TRƯỚC LÀ NHIỀU, NHƯNG LẠI HỮU HẠN VALUE NHẬP,
--TỈNH THÀNH NHIỀU - NHƯNG CHỈ CÓ 63, DÂN TỘC 54, CHÂU LỤC 56,  
--CÓ NÊN CHO NGƯỜI TA GÕ TAY KHÔNG - KHÔNG - VÌ SẼ GÂY NÊN KHÔNG NHẤT QUÁN INCONSISTENCY
--TỐT NHẤT CHO CHỌN, CHỌN PHẢI TỪ CÁI CÓ SẴN, SẴN SÀNG, TỨC LÀ TÁCH TABLE KHÁC

-- KO CHO GÕ LUNG TUNG, GÕ TRONG CÁI ĐÃ CÓ - DÍNH 2 THỨ, TABLE KHÁC (ĐÃ NÓI TRÊN)
--						FK ĐỂ ĐẢM BẢO ĐÚNG TRONG ĐÓ HOY
