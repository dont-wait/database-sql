
-- CHIẾN LƯỢC: GOM 1 BẢNG
-- XEM: ĐA TRỊ, COMPOSITE, LÔKUP, LẶP LẠI TRÊN 1 NHÓM CỘT
--      TÁCH THÊM ÒNG TỐT HƠN THÊM CỘT ( KHI CẦN THÊM DATA)
CREATE DATABASE DBDESIGN_ACTIVITIES
USE DBDESIGN_ACTIVITIES

CREATE TABLE ACTIVITY_V1
(
	LectID char(8),
	LectName nvarchar(30), -- Composite, tách nếu muốn sort
	Email varchar(50),
	Phone char(11),
	Major varchar(30),
	StartDate datetime,
	ActType nvarchar(30), 
	Topic nvarchar(30),
	Intro nvarchar(250),
	Room nvarchar(50), --luư hyperlink của Zoom, Meet, phòng
	Seats int
)
SELECT * FROM ACTIVITY_V1
INSERT INTO ACTIVITY_V1 VALUES('00000001', N'HOÀ.ĐNT', 'hoadnt@', '090x', 'CF', '2021-11-3', 'Seminar', 'Nhập môn Machine Learning', '...', N'Phòng seminar Thư viện ĐH FPT HCM', 100)

INSERT INTO ACTIVITY_V1 VALUES('00000001', N'HOÀ.ĐNT', 'hoadnt@', '090x', 'CF', '2021-11-3', 'seminar', 'Giới thiệu về YOLO v4', '...', N'Phòng seminar Thư viện ĐH FPT HCM', 100)

INSERT INTO ACTIVITY_V1 VALUES('00000001', N'HOÀ.ĐNT', 'hoadnt@', '090x', 'CF', '2021-11-3 07:00:00', 'seminar', 'Giới thiệu về YOLO v4 (part 2)', '...', N'Phòng seminar Thư viện ĐH FPT HCM', 100)

-- ƯU ĐIỂM & NHƯỢC ĐIỂM

CREATE TABLE LECTURER_V2 
(
	LectID char(8) PRIMARY KEY,
	LectName nvarchar(30), 
	Email varchar(50),
	Phone char(11),
	Major varchar(30)
)
CREATE TABLE ACTIVITY_V2
(
	SEQ int IDENTITY PRIMARY KEY,
	StartDate datetime,
	ActType nvarchar(30), --coi chừng gõ WORKSHOP ko ai cấm gõ TRAINING
							-- mùi của LOOKUP

	Topic nvarchar(30),
	Intro nvarchar(250),
	Room nvarchar(50), --luư hyperlink của Zoom, Meet, phòng
	Seats int,
	LectID char(8) REFERENCES LECTURER_V2(LectID)
)
INSERT INTO LECTURER_V2 VALUES('00000001', N'HOÀ.ĐNT', 'hoadnt@', '090x', 'CF')
INSERT INTO ACTIVITY_V2 VALUES('2021-11-3', 'Seminar', N'Nhập môn Machine Learning', '...', N'Phòng seminar Thư viện ĐH FPT HCM', 100, '00000001')

INSERT INTO ACTIVITY_V2 VALUES('2021-11-3', 'seminar', N'Giới thiệu về YOLO v4', '...', N'Phòng seminar Thư viện ĐH FPT HCM', 100, '00000001')

INSERT INTO ACTIVITY_V2 VALUES('2021-11-3 07:00:00', 'workshop', N'Giới thiệu về YOLO v4 (part 2)', '...', N'Phòng seminar Thư viện ĐH FPT HCM', 100, '00000001')

select * FROM ACTIVITY_V2
