CREATE DATABASE DBDESIGN_ONEMANY
USE DBDESIGN_ONEMANY

--TABLE 1 TẠO TRƯỚC, TABLE N TẠO SAU
CREATE TABLE MajorV1 (
	MajorID char(2) PRIMARY KEY, --mặc định db engine tự tạo tên tàng buộc
	MajorName nvarchar(40) NOT NULL,
	--....
)
--CHÈN DATA   MUA QUẦN ÁO BỎ VÀO TỦ
INSERT INTO MajorV1 VALUES('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV1 VALUES('IA', N'An toàn thông tin')

DROP TABLE StudentV1
CREATE TABLE StudentV1 (
	StudentID char(8) NOT NULL, 
	LastName  nvarchar(50) NOT NULL, 
	FirstName nvarchar(50) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) null,
	MID char(2),	--tên cột khoá ngoại/tham chiếu ko cần trùng với bên key
				-- bắt buộc trùng  100% kiểu dữ liệu, CẦN THAM CHIẾU DATA THÔI
   --CONSTRAINT PK_STUDENTV1 PRIMARY KEY(StudentID)
);
ALTER TABLE StudentV1 ADD CONSTRAINT PK_STUDENTV1 PRIMARY KEY(StudentID)
--CHÈN DATA SINH VIEN
SELECT * FROM StudentV1
SELECT * FROM MajorV1
INSERT INTO StudentV1 VALUES('SE1', N'Nguyễn', N'AN', NULL, NULL, 'SE')

--THIẾT KẾ TRÊN SAI VÌ ... KO CÓ THAM CHIẾU GIỮA MAJORID CỦA STUDENT  VS MAJOR PHÍA TRÊN
INSERT INTO StudentV1 VALUES('SE2', N'Nguyễn', N'bíNH', NULL, NULL, 'HI')




CREATE TABLE MajorV2 (
	MajorID char(2) PRIMARY KEY, --mặc định db engine tự tạo tên tàng buộc
	MajorName nvarchar(40) NOT NULL,
	--....
)
--CHÈN DATA   MUA QUẦN ÁO BỎ VÀO TỦ
INSERT INTO MajorV2 VALUES('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV2 VALUES('IA', N'An toàn thông tin')
DROP TABLE MajorV2
DROP TABLE StudentV2
CREATE TABLE StudentV2 (
	StudentID char(8) PRIMARY KEY, 
	LastName  nvarchar(50) NOT NULL, 
	FirstName nvarchar(50) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) null,
	--MID char(2) REFERENCES MajorV2(MajorID)	
	MajorID char(2) FOREIGN KEY REFERENCES MajorV2(MajorID)
	--tớ chọn chuyên ngành ở trên kia kìa, xin tham chiếu trên kia
);
SELECT * FROM MajorV2
INSERT INTO StudentV2 VALUES('SE1', N'Nguyễn', N'AN', NULL, NULL, 'SE')

INSERT INTO StudentV1 VALUES('SE2', N'Nguyễn', N'bíNH', NULL, NULL, 'HI')

SELECT * FROM StudentV2

-- KHÔNG ĐƯỢC XOÁ TABLE 1 NẾU NÓ ĐANG ĐC THAM CHIẾU BỞI THẰNG KHÁC
-- NẾU CÓ MỐI QUAN HỆ 1-N, XOÁ N TRƯỚC RỒI MỚI XOÁ 1 SAU

----------------------------------------------------------
-- THÊM KĨ THUẬT VIẾT FK, Y CHANG CÁCH VIẾT CỦA PK
/*
DROP TABLE StudentV3
CREATE TABLE StudentV3 (
	StudentID char(8) PRIMARY KEY, 
	LastName  nvarchar(50) NOT NULL, 
	FirstName nvarchar(50) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) null,
	MID char(2),
	CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY (MID) REFERENCES MajorV3(MajorID)
);
CREATE TABLE MajorV3 (
	MajorID char(2) PRIMARY KEY, --mặc định db engine tự tạo tên tàng buộc
	MajorName nvarchar(40) NOT NULL,
	--....
)
SELECT * FROM MajorV3
SELECT * FROM StudentV3
*/
-- TA CÓ QUYỀN GỠ MỘT RÀNG BUỘC ĐÃ THIẾT LẬP!!!
ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3	
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY (MID) REFERENCES MajorV3(MajorID)

-- INSERT LÀ CHẾT, DO CHƯA CÓ DỮ LIỆU ĐỂ THAM CHIẾU -  CHƯA ADD SE vào MAJOR
INSERT INTO StudentV3 VALUES('SE1', N'Nguyễn', N'AN', NULL, NULL, 'SE')
INSERT INTO StudentV3 VALUES('SE2', N'Lê', N'Bình', NULL, NULL, 'AH')


INSERT INTO MajorV3 VALUES('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV3 VALUES('AH', N'AHIHI')


-- THAO TÁC MẠNH TAY TRÊN DATA/MÓN ĐỒ QUẦN ÁO TRONG TỦ - DML (UPDATE & DELETE)
DELETE FROM StudentV3 -- CỰC KÌ NGUY HIỂM KHI THIẾU WHERE, XOÁ HẾT DATA
DELETE FROM StudentV3 WHERE MID = 'AH';
DELETE FROM MajorV3 WHERE MajorID = 'AH';
-- KHI MUỐN XOÁ 1 THÌ KHÔNG ĐƯỢC VÌ CÓ NGƯỜI ĐANG THAM CHIẾU ĐẾN -> MUỐN
-- XOÁ MÀ NHỮNG N ĐI THEO 1 ĐÓ CŨNG XOÁ THEO LUN, KHÔNG BỊ CẤM NX

-- GÀI THÊM HÀNH XỬ KHI XOÁ, SỬA DATA Ở RÀNG BUỘC KHOÁ NGOẠI/DÍNH KHOÁ CHÍNH LUÔN
-- HIỆU ỨNG DOMINO, SỤP ĐỖ DÂY CHUYỀN, 1 XOÁ - N ĐI SẠCH >>>> CASCADE DELETE, CASCADE UP
--									   1 SỬA, N ĐI THEO >>>> CASCADE ĐI UPDATE
-- NGAY LÚC DESIGN TABLE/CREATE TABLE ĐÃ PHẢI TÍNH VỤ NÀY RỒI
-- VẪN CÓ THỂ SỬA SAU NÀY KHI CÓ DATA. CÓ THỂ CÓ TROUBLE
-- CỤM LỆNH: CREATE/ ALTER/ DROP - CẤU TRÚC CỦA CÁI TỦ

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3	-- XOÁ RÀNG BUỘC KHOÁ NGOẠI BỊ THIẾU

-- VIỆC GÀI THÊM RULE NHỎ LIÊN QUAN XOÁ SỬA DATA
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
					 FOREIGN KEY (MID) REFERENCES MajorV3(MajorID)
					 ON DELETE CASCADE
					 ON UPDATE CASCADE

-- UPDATE DML, SỬA DATA ĐANG CÓ
UPDATE MajorV3 SET MajorID = 'AK' --CẨN THẬN NẾU KO CÓ WHERE, TOÀN BỘ TABLE SẼ BỊ ẢNH HƯỞNG
UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'

--SỤP ĐỔ, XOÁ 1, N ĐI SẠCH SẼ
--XOÁ CHUYÊN NGÀNH AHIHI, XEM SAO ??? CÒN 1 SINH VIÊN NÀO KHÔNG
DELETE FROM MajorV3 WHERE MajorID = 'AH' -- SV CÓ MÃ SỐ AH1 LÊN ĐƯỜNG LÊN
DELETE FROM MajorV3 WHERE MajorID = 'AK' -- SV CÓ MÃ SỐ AH1 LÊN ĐƯỜNG LÊN

-- CÒN 2 CÁI GÀI NỮA LIÊN QUAN ĐẾN TÍNH ĐỒNG BỘ DATA/CONSISTANCY
-- SET NULL VÀ DEFAULT
-- KHI 1 XOÁ, N VỀ NULL
-- KHI 1 XOÁ, N VỀ DEFAULT
SELECT * FROM StudentV3
SELECT * FROM MajorV3

-- *******CHỐT HẠ
-- XOÁ BÊN 1 TỨC LÀ MẤT BÊN 1, KO LẼ SỤP ĐỔ CẢ ĐÁM BÊN N, KO HAY, NÊN CHỌN LÀ ĐƯA BÊN N VỀ NULL
-- UPDATE BÊN 1, BÊN 1 VẪN CÒN GIỮ DÒNG/ROW, BÊN N NÊN ĐỒNG BỘ THEO, ĂN THEO, CASCADE
SELECT * FROM StudentV3
SELECT * FROM MajorV3

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3	-- XOÁ RÀNG BUỘC KHOÁ NGOẠI BỊ THIẾU

-- VIỆC GÀI THÊM RULE NHỎ LIÊN QUAN XOÁ SỬA DATA
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
					  FOREIGN KEY (MID) REFERENCES MajorV3(MajorID)
					  ON DELETE SET NULL -- XOÁ CHO MỒ CÔI, BƠ VƠ, NULL, TỪ TỪ TÍNH
					  ON UPDATE CASCADE -- SỬA BỊ ẢNH HƯỞNG DÂY TRUYỀN
-- CHO SV BƠ VƠ CHUYÊN NGÀNH VỀ HỌC SE
UPDATE StudentV3 SET MID = 'SE' -- TOÀN TRUYỀN HỌC SE
UPDATE StudentV3 SET MID = 'SE' WHERE MID IS NULL


CREATE TABLE StudentV3 (
	StudentID char(8) PRIMARY KEY, 
	LastName  nvarchar(50) NOT NULL, 
	FirstName nvarchar(50) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) null,
	MID char(2) DEFAULT 'SE',
	CONSTRAINT FK_StudentV3_MajorV3
				FOREIGN KEY (MID) REFERENCES MajorV3(MajorID)
				ON DELETE SET DEFAULT
				ON UPDATE CASCADE
)
SELECT * FROM StudentV3
SELECT * FROM MajorV3
--ALTER TABLE STUDENTV3 ADD CONSTRAINT... Ở TRÊN DONE

-- CHO SV KO CHỌN CHUYỆN NGÀNH, HẮN HỌC GÌ??? HỌC SE ĐẤY

INSERT INTO StudentV3 VALUES('SE1', N'Nguyễn', N'AN', NULL, NULL, 'SE')
INSERT INTO StudentV3 VALUES('SE2', N'Lê', N'Bình', NULL, NULL, 'AH')

INSERT INTO StudentV3(StudentID, LastName, FirstName) VALUES('SE3', N'Lê', N'Bình')
DELETE FROM MajorV3 WHERE MajorID = 'AH'