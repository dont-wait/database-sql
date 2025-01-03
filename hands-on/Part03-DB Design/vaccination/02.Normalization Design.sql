﻿-- THIẾT KẾ ĐẦU TIÊN: GOM TẤT CẢ TRONG 1 TABLE
-- Đặc điểm chính là cột, value đđ chính là cell
-- Thông tin chích ngừa bao gồm: tên: An Nguyễn, cccd: 1234567789.., 

CREATE DATABASE DBDESIGN_VACCINATION
USE DBDESIGN_VACCINATION

CREATE TABLE VaccinationV1
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK
	                                   --key ứng viên, candidate key
	InjectionInfo nvarchar(255) 
)
--cách thiết kế này lưu trữ các mũi chích của mình đc ko? - ĐƯỢC
SELECT * FROM VaccinationV1

INSERT INTO VaccinationV1 
   VALUES('00000000001', N'NGUYỄN', N'AN', '090X', N'AZ Ngày 28.9.2021 ĐH FPT | AZ Ngày 28.10.2021 BV LÊ VĂN THỊNH, Q. TĐ')

--PHÂN TÍCH:
--ƯU   : DỄ LƯU TRỮ, SELECT, CÓ NGAY, đa trị tốt trong vụ này!!!
--NHƯỢC: THỐNG KÊ ÉO ĐC, ÍT NHẤT ĐI CẮT CHUỖI, CĂNG !!!  BỊ CĂNG DO ĐA TRỊ

--SOLUTION: CẦN QUAN TÂM THỐNG KÊ, TÍNH TOÁN SỐ LIỆU (? MŨI, AZ CÓ BAO NGƯỜI...)
--TÁCH CỘT, TÁCH BẢNG
CREATE TABLE VaccinationV2
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK
	                                   --key ứng viên, candidate key
	Dose1 nvarchar(100), --AZ, Astra, Astra.... 25.9.2021, DH FPT - COMPOSITE (phức hợp)
	Dose2 nvarchar(100)  --AZ, AZ, .....
)
--PHÂN TÍCH:
--*ƯU   : gọn gàng, select gọn gàng
--*NHƯỢC: NULL!!!, THÊM MŨI NHẮC 3, 4 HÀNG NĂM THÌ SAO???
--        CHỈ VÌ VÀI NGƯỜI, MÀ TA PHẢI CHỪA CHỖ NULL
--        THỐNG KÊ!!! CỘT COMPOSITE CHƯA CHO MÌNH ĐC THỐNG KÊ


-- MULTI-VALUED CELL : MỘT CELL CHỨA NHIỀU INFO ĐỘC LẬP BÌNH ĐẲNG VỀ NGỮ NGHĨA
--               Ví dụ: Address: 1/1 LL, Q.1, TP.HCM ; 1/1 Man Thiện, P.5, TP.TĐ
--                           thường trú                  tạm trú 
--               GÓI COMPO, NHIỀU ĐỒ TRONG 1 CELL
--               ĐỌC: CÓ 2 ĐỊA CHỈ

-- COMPOSITE VALUE CELL: Một value duy nhất, mỗi value này gom nhiều miếng nhỏ hơn
--                       nhiều miếng nhỏ hơn, mỗi miếng có 1 vai trò riêng
--                       gom chung lại thành 1 thứ khác
--                       Address: 1/1 Man Thiện, P.5, TP.HCM    
--                       FullName: Hoàng  Ngọc Trinh -> cả: tên gọi đầy đủ
--                                 first  last  midd 

--VÌ SỐ LẦN CHÍCH CÒN CÓ THỂ GIA TĂNG CHO TỪNG NGƯỜI, MŨI 2, MŨI NHẮC, MŨI THƯỜNG NIÊN
--AI CHÍCH NHIỀU THÌ NHIỀU DÒNG, HAY HƠN HẲN

CREATE TABLE PersonV3
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK	
)

--COMPOSITE GỘP N INFO VÀO TRONG 1 CELL, DỄ, NHANH LÀ ƯU ĐIỂM, NHẬP 1 CHUỖI DÀI LÀ XONG
--               NHƯỢC ĐIỂM: ÉO THÔNG KÊ TỐT, ÉO SORT ĐC
--                           FullName sort làm sao
--COMPOSITE SẼ TÁCH CỘT, VÌ MÌNH ĐÃ CỐ TRƯỚC ĐÓ GOM N THỨ KHÁC NHAU ĐỂ LÀM RA 1 THỨ KHÁC 
--               TÁCH CỘT TRẢ LẠI ĐÚNG NGỮ NGHĨA CHO TỪNG THẰNG

CREATE TABLE VaccinationV3
(                                   --key ứng viên, candidate key
	Dose nvarchar(100), --AZ, Astra, Astra.... 25.9.2021, DH FPT - COMPOSITE (phức hợp)	
	PersonID char(11) REFERENCES PersonV3(ID)
)
--PHÂN TÍCH:
--ƯU   : CHÍCH THÊM NHÁT NÀO, THÊM DÒNG NHÁT ĐÓ, CHẤP 10 MŨI ĐỦ CHỖ LƯU, KO ẢNH HƯỞNG NGƯỜI CHƯA CHÍCH
--NHƯỢC: THỐNG KÊ ÉO ĐC
-- COMPOSITE TÁCH TIẾP THÀNH CỘT CỘT CỘT CỘT CỘT CỘT CỘT, TRẢ LẠI ĐÚNG Ý NGHĨA CHO TỪNG M
-- MIẾNG INFO NHỎ

CREATE TABLE PersonV4
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK	
)

CREATE TABLE VaccinationV4
(                                   --key ứng viên, candidate key
	--Dose nvarchar(100), --AZ, Astra, Astra.... 25.9.2021, DH FPT - COMPOSITE (phức hợp)	
	-- tách cột hoy
	Dose int, -- liều chích số 1
	InjDate datetime, --giờ chích
	Vaccine nvarchar(50), --tên vaccine
	Lot nvarchar(20), 
	[Location] nvarchar(50),
	PersonID char(11) REFERENCES PersonV4(ID)
)

INSERT INTO PersonV4 VALUES('00000000001', N'NGUYỄN', N'AN', '0901x')
INSERT INTO PersonV4 VALUES('00000000002', N'LÊ', N'BÌNH', '090X')
SELECT * FROM PersonV4

INSERT INTO VaccinationV4 
  VALUES(1, GETDATE(), 'AZ', NULL, NULL, '00000000001')

SELECT * FROM PersonV4
SELECT * FROM VaccinationV4

--IN RA XANH VÀNG CHO MỖI NGƯỜI
SELECT * FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID  

SELECT p.id, p.FirstName, COUNT(*) AS 'No Doses' FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID 
					GROUP BY p.id, p.FirstName --CHẾT MẸ COUNT(*)
					                           --BÌNH CÓ 1 DÒNG KHA KHÁ NULL CHƯA CHÍCH


SELECT p.id, p.FirstName, COUNT(v.Dose) AS 'No Doses' FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID 
					GROUP BY p.id, p.FirstName 	
	
-- ĂN TIỀN XANH ĐỎ	
SELECT p.id, p.FirstName, IIF(COUNT(v.Dose) = 0, 'NOOP', 
                          IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN')) 
						  AS STATUS		 
					FROM PersonV4 p LEFT JOIN VaccinationV4 v
										ON p.ID = v.PersonID 
										GROUP BY p.id, p.FirstName 	

-- AN NGUYỄN TỪ VÀNG THÀNH XANH KHI CÓ THÊM MŨI CHÍCH NÀY
INSERT INTO VaccinationV4 
  VALUES(2, GETDATE(), 'AZ', NULL, NULL, '00000000001')

SELECT * FROM PersonV4
SELECT * FROM VaccinationV4 
-------------------------------------------------------------
-------------------------------------------------------------
--* PHÂN TÍCH
-- Cột Vaccine cho phép gõ các giá trị tên VC một cách tự do -> inconsistency
-- AZ, Astra, AstraZeneca AstraZeneca, Astra Zeneca
-- >>>>> có mùi của dropdown, mùi của combo box >>>>> Lookup table
-- ko cho gõ mà cho chọn từ danh sách có sẵn...
-- tham chiếu từ danh sách có sẵn
-- Vaccine phải tách thành table CHA, TABLE 1, ĐÁM CON ĐÁM N
-- PHẢI REFERENCE VỀ

CREATE TABLE PersonV5
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK	
)

INSERT INTO PersonV5 VALUES('00000000001', N'NGUYỄN', N'AN', '0901x')
INSERT INTO PersonV5 VALUES('00000000002', N'LÊ', N'BÌNH', '090X')
INSERT INTO PersonV5 VALUES('00000000003', N'VÕ', N'CƯỜNG', '092X')

CREATE TABLE VaccineV5
(
	VaccineName varchar(30) PRIMARY KEY
    -- hãng sx, địa chỉ hãng, thông tin về lâm sàng...
)

INSERT INTO VaccineV5 VALUES('AstraZeneca')
INSERT INTO VaccineV5 VALUES('Pfizer')
INSERT INTO VaccineV5 VALUES('Verocell')
INSERT INTO VaccineV5 VALUES('Moderna')

SELECT * FROM VaccineV5
--PRIMARY KEY MÀ LÀ VARCHAR() LÀM GIẢM HIỆU NĂNG VỀ THỰC THI QUERY
--CHẠY CHẬM. THƯỜNG NGƯỜI TA SẼ CHỌN PK LÀ CON SỐ LÀ TỐT NHẤT, TỐT NHÌ CHAR
--SẼ GIẢNG RIÊNG 1 BUỔI VỀ PRIMARY KEY (PK, FK, CK, SPK, NK, SRK-AK) 
CREATE TABLE VaccinationV5
(                                  
	SEQ int IDENTITY PRIMARY KEY,  --CỨ TĂNG MÃI MÃI ĐI, 2 TỶ 1 MẤY LẦN CHÍCH
	Dose int, -- liều chích số 1, 2 có thể lặp lại cho mỗi person, ko thể là PK
	InjDate datetime, --giờ chích
	Vaccine varchar(30) REFERENCES VaccineV5(VaccineName), 
	--tên vaccine KO CHO GÕ TỰ DO, PHẢI THAM CHIẾU
	Lot nvarchar(20), 
	[Location] nvarchar(50),  --nơi chích bản chất là COMPOSITE, TÁCH THÀNH CỘT CITY, QUẬN/HUYỆN
	                          --LẠI LÀ LOOKUP NẾU MUỐN, ĐỂ KO GÕ LUNG TUNG, THỐNG KÊ TIỆN TỪNG ĐVI
	PersonID char(11) REFERENCES PersonV5(ID),

	--FOREIGN KEY (Vaccine) REFERENCES VaccineV5(VaccineName),
	--CONSTRAINT FK_VCN_VC FOREIGN KEY (Vaccine) REFERENCES VaccineV5(VaccineName)
)
SELECT * FROM Personv5
SELECT * FROM VaccineV5
INSERT INTO VaccinationV5 
  VALUES(1, GETDATE(), 'AstraZeneca', NULL, NULL, '00000000001') --OK

INSERT INTO VaccinationV5 
  VALUES(2, '2021-12-20', 'AstraZeneca', NULL, NULL, '00000000001')  --OK 

SELECT * FROM VaccinationV5


INSERT INTO VaccinationV5 
  VALUES(3, '2021-12-20', 'AZ', NULL, NULL, '00000000001') --THẤT BẠI
  --ko có loại vaccine gõ tay AZ
--SEQ tăng mẹ nó thành số 3 và bị thất bại!!!!!

INSERT INTO VaccinationV5 
  VALUES(1, '2021-12-20', 'Verocell', NULL, NULL, '00000000002')


SELECT * FROM VaccineV5
SELECT * FROM PersonV5
SELECT * FROM VaccinationV5

-- THỐNG KÊ ĐC NHỮNG GÌ
--1. Có bao nhiêu mũi vaccine AZ đã đc chích (chích bao nhát, ko care người)
--Output: loại vaccine, tổng số mũi đã chích
SELECT COUNT(v.Dose) AS NoAZVaccine FROM VaccinationV5 v WHERE v.Vaccine = 'AstraZeneca'

--2. Ngày x có bao nhiêu mũi đã đc chích
--Output: ngày, tổng số mũi đã chích
SELECT v.InjDate, COUNT(v.Dose) FROM VaccinationV5 v
					GROUP BY v.InjDate
--3. Thống kê số mũi chích của mỗi cá nhân
--Output: CCCD, Tên (full), di động, số mũi đã chích (0, 1, 2, 3)  
SELECT p.ID, CONCAT(p.FirstName, ' ', p.LastName) 
							AS FullName, p.Phone, COUNT(v.Dose) AS NoDose 
							FROM Personv5 p LEFT JOIN VaccinationV5 v 
							ON p.ID = v.PersonID
							GROUP BY p.ID, p.FirstName, p.LastName, p.Phone

--4. In ra thông tin chích của mỗi cá nhân
--Output: CCCD, Tên (full), di động, số mũi đã chích (0, 1, 2, 3), MÀU SẮC
SELECT p.ID, CONCAT(p.FirstName, ' ', p.LastName) 
							AS FullName, p.Phone, COUNT(v.Dose) AS NoDose
							, IIF(COUNT(v.Dose) = 0, 'NOPE'
							, IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN')) AS STATUS 
							FROM Personv5 p LEFT JOIN VaccinationV5 v 
							ON p.ID = v.PersonID
							GROUP BY p.ID, p.FirstName, p.LastName, p.Phone

--5. Có bao nhiêu công dân đã chích ít nhất 1 mũi vaccine
SELECT p.FirstName, COUNT(p.id) AS [NoDose] FROM Personv5 p LEFT JOIN VaccinationV5 v 
									ON p.ID = v.PersonID GROUP BY p.FirstName
--6. Những công dân nào chưa chích mũi nào?
--Output: CCCD, Tên
SELECT p.ID, concat(p.FirstName, ' ', p.LastName) AS FULLNAME FROM Personv5 p LEFT JOIN VaccinationV5 v 
									on p.ID = v.PersonID WHERE v.Dose is null 
--7. Công dân có CCCD X đã chích những mũi nào 
--Output: CCCD, Tên, thông tin chích (in gộp + chuỗi, tái nhập composite)
SELECT p.ID, concat(p.FirstName, ' ', p.LastName) as FullName,  v.*  FROM Personv5 p LEFT JOIN VaccinationV5 v ON p.ID = v.PersonID
-- CHỐT HẠ: TÁCH ĐA TRỊ, HAY COMPOSITE DỰA TRÊN NHU CẦU THỐNG KÊ
--          NẾU CÓ CỦA DỮ LIỆU TA LƯU TRỮ!!!
--          GOM BẢNG -> TÌM ĐA TRỊ, TÌM COMPOSITE, TÌM LOOKUP TÁCH THEO
--                      NHU CẦU!!! 

--8. Thống kê số mũi vaccine đã chích của mỗi loại vaccine
SELECT * FROM VaccinationV5  --VERO VÀ AZ KO HÀ, MẤT TIÊU MO, PF

SELECT * FROM VaccineV5 v INNER JOIN  --chả khác câu trên, JOIN =, CHỈ LẤY ĐÃ CHÍCH, KO CARE CHƯA CHÍCH
              VaccinationV5 vc ON v.VaccineName = vc.Vaccine

SELECT * FROM VaccineV5 v LEFT JOIN  
              VaccinationV5 vc ON v.VaccineName = vc.Vaccine

SELECT v.VaccineName, COUNT(*) FROM VaccineV5 v LEFT JOIN  
              VaccinationV5 vc ON v.VaccineName = vc.Vaccine
GROUP BY v.VaccineName	-- gần đúng hoy, count(*) toang cho thằng
                        -- chơi hệ LEFT do có 1 dòng Pfizer chủ yếu null
						-- do chưa ai chích, NHỚ COUNT(*) KHÁC COUNT(NULL)

SELECT v.VaccineName, COUNT(VC.SEQ) FROM VaccineV5 v LEFT JOIN  
              VaccinationV5 vc ON v.VaccineName = vc.Vaccine
			  --WHERE DATE CHÍCH LÀ THỐNG KÊ THEO NGÀY
			  --QUẬN HUYỆN NỮA LÀ THỐNG KÊ THEO NGÀY, QUẬN
GROUP BY v.VaccineName			   