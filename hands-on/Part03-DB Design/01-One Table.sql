CREATE DATABASE DBDESIGN_ONETABLE
--CREATE DÙNG ĐỂ TẠO CẤU TRÚC LƯU TRỮ/DÀN KHUNG/ THÙNG CHỨA DÙNG LƯU TRỮ DATA/INFO
--TƯƠNG ĐƯƠNG VIỆC XÂY PHÒNG CHỨA ĐỒ - DATABASE
--			  MUA TỦ ĐỂ TRONG PHÒNG - TABLE
--1 DB CHỨA NHIỀU TABLE - 1 PHÒNG THÌ CÓ NHIỀU TỦ
--						  1 NHÀ CÓ NHIỀU PHÒNG
--TẠO RA CẤU TRÚC LƯU TRỮ - CHƯA NÓI DATA BỎ VÀO - DDL (PHÂN NHÁNH CỦA SQL)

USE DBDESIGN_ONETABLE

--Tạo table lưu trữ hồ sơ sv: mã số (phân biệt các sv với nhau), tên, dob, địa chỉ,...
--1 SV ~~~ 1 OBJECT ~~~ 1 ENTITY
--1 TABLE DÙNG LƯU TRỮ NHIỀU ENTITY
CREATE TABLE StudentV1
(
	StudentID char(8), 
	LastName nvarchar(40),  --tại sao ko gộp fullname cho rồi
	FirstName nvarchar(10), --n: lưu kí tự Unicode tiếng Việt
	DOB datetime,
	--"Home Address"
	[Address] nvarchar(50)
)
--SQL Server | Oracle (Oracle/Java) | DB (IBM) | MySQL | PostgetSQL | SQLite | MS Access (Office)

--THAO TÁC TRÊN DATA/MÓN ĐỒ TRONG TỦ/TRONG TABLE - DML/DQL (DÀNH RIÊNG CHO SQL)
SELECT * FROM StudentV1 -- gõ chuẩn

--ĐƯA DATA VÀO TABLE/MUA ĐỒ QUẦN ÁO BỎ VÀO TỦ
INSERT INTO StudentV1 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'...TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE THÔNG TIN

--MỘT SỐ CỘT CHƯA THÈM NHẬP INFO, ĐƯỢC QUYỀN BỎ TRỐNG NẾU CỘT CHO PHÉP TRỐNG VALUE
--DEFAULT KHI ĐÓNG CÁI TỦ/MUA TỦ/THIẾT KẾ TỦ, MẶC ĐỊNH NULL
INSERT INTO StudentV1 VALUES('SE123457', N'Lê', N'Bình', '2003-1-1', NULL)

-- TÊN THÀNH PHỐ LÀ NULL, WHERE = 'NULL' OKIE VÌ NÓ LÀ DATA
-- NULL Ở CÂU TRÊN WHERE ADDRESS IS NULL
INSERT INTO StudentV1 VALUES('SE123458', N'Võ', N'Cường', '2003-1-1', N'NULL') 

--TUI CHỈ MÚN LƯU VÀI INFO, KO ĐỦ SỐ CỘT, MIỄN CỘT CÒN LẠI CHO PHÉP BỎ TRỐNG THÌ MỚI ĐƯỢC QUYỀN LÀM TRÒ NÀY
INSERT INTO StudentV1(StudentID, LastName, FirstName) 
	VALUES('SE123459', N'Phạm', N'Dũng')


INSERT INTO StudentV1(LastName, FirstName, StudentID) 
	VALUES(N'Dũng', N'Phạm', 'SE123459')

INSERT INTO StudentV1(LastName, FirstName, StudentID) 
	VALUES(NULL, NULL, NULL) --SIÊU NGUY HIỂM, SINH VIÊN TOÀN THÔNG TIN TRỐNG
							 -- GÀI CÁCH ĐƯA DATA VÀO  CÁC CỘT SAO CHO HỢP LÍ
							 -- CONSTRAINT TRÊN DATA/CELL/COLUNM
SELECT * FROM StudentV1

--CÚ NGUYEN HIỂM NÀY CÒN LỚN HƠN!!!!!!!!!!!!!
INSERT INTO StudentV1(StudentID, LastName, FirstName) 
	VALUES('SE123459', N'Đỗ', N'Giang')
--TRùNG ID LÀ MỘT ĐIỀU KHÔNG CHẤP NHẬN ĐƯỢC, KO XÁC ĐỊNH ĐƯỢC 1 SV
--GÀN RÀNG BUỘC DỮ LIỆU QUAN TRỌNG NÀY
--CỘT MÀ VALUE CẤM TRÙNG TRONG MỌI CELL
--DÙNG LÀM CHÌA KHOÁ/KEY ĐỂ TÌM RA/MỞ RA/XĐ
--DUY NHẤT 1 INFO, 1 DÒNG, 1 INFO, 1 ENTITY, 1 OBJECT
--CỘT NÀY ĐƯỢC GỌI LÀ 1 PRIMARY KEY

SELECT * FROM StudentV1 WHERE StudentID = 'se123459'


--GÀI CÁCH ĐƯA DATA VÀO TABLE ĐỂ KO CÓ NHỮNG HIỆN TƯỢNG BẤT THƯỜNG, 1 DÒNG TRỐNG TRƠN, KEY TRÙNG
--KEY NULL - DEFAULT THIẾT KẾ CHO PHÉP NULL TẤT CẢ
--GÀI
CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY, --BAO HÀM LUÔN NOT NULL - BẮT BUỘC PHẢI ĐƯA DATA
									--BẮT BUỘC ĐƯA DATA CẤM TRÙNG
	LastName nvarchar(40) NOT NULL,  --tại sao ko gộp fullname cho rồi
	FirstName nvarchar(10)NOT NULL, --n: lưu kí tự Unicode tiếng Việt
	DOB datetime,
	--"Home Address"
	[Address] nvarchar(50)
)
INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'...TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE THÔNG TIN
SELECT * FROM StudentV2

INSERT INTO StudentV2(LastName, FirstName, StudentID) 
	VALUES(NULL, NULL, NULL)
INSERT INTO StudentV2(LastName, FirstName, StudentID) 
	VALUES('aHIHI', NULL, NULL)

--COI CÓ ĐC TRÙNG MÃ SỐ SV HAY KO
INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'...TP.Hồ Chí Minh') 
INSERT INTO StudentV2 VALUES('GD123456', N'Nguyễn', N'An', '2003-1-1', N'...TP.Hồ Chí Minh') 
INSERT INTO StudentV2 VALUES('SE123457', N'Lê', N'Bình', '2003-1-1', null) 
SELECT * FROM StudentV2
INSERT INTO StudentV2 VALUES('SE123458', N'Lê', N'Bình', null, null) --okIE
INSERT INTO StudentV2(StudentID, LastName, FirstName) VALUES('SE12412', N'Cường', 'Võ') 
INSERT INTO StudentV2 
				VALUES(NULL, NULL, NULL, NULL, NULL) --GẪY 3 CHỖ, BẮT ĐẦU TỪ CHỖ ID

CREATE TABLE StudentV3
(
	StudentID char(8) NOT NULL PRIMARY KEY, 
	LastName nvarchar(40) NOT NULL,  --tại sao ko gộp fullname cho rồi
	FirstName nvarchar(10) NOT NULL, --n: lưu kí tự Unicode tiếng Việt
	DOB datetime,
	--"Home Address"
	[Address] nvarchar(50) NULL
)

CREATE TABLE StudentV4
(
	StudentID char(8) NOT NULL, 
	LastName nvarchar(40) NOT NULL,  --tại sao ko gộp fullname cho rồi
	FirstName nvarchar(10) NOT NULL, --n: lưu kí tự Unicode tiếng Việt
	DOB datetime,
	--"Home Address"
	[Address] nvarchar(50) NULL,
	PRIMARY KEY(StudentID)
)

INSERT INTO StudentV4 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'...TP.Hồ Chí Minh') 
SELECT * FROM StudentV4

--GENERATE TỪ TOOL THIẾT KẾ
CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName int NOT NULL, 
  PRIMARY KEY (StudentID));
