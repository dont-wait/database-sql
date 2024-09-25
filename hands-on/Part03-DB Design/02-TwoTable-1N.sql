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