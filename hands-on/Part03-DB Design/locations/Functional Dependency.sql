CREATE DATABASE DBDESIGN_VNLOCATIONS
USE DBDESIGN_VNLOCATIONS

-- Thiết kế csdl lưu đc thông tin phường/xã, quận/huyện, tỉnh/thành phố
-- chính là 1 phần của đại chỉ đc tách ra cho nhu cầu thống kê
-- nó là 1 phần của Composite field
--|SEQ|DOSE|Injdate|vacine (Fk LK)|Lot|Địa chỉ chích - Composite|
--|SEQ|DOSE|Injdate|vacine (Fk LK)|Lot|Số nhà|Phường-Quận-Tỉnh|

-- XÉT RIÊNG PHƯỜNG-QUẬN-TỈNH RÕ RÀNG 3 CỘT LOOKUP
CREATE TABLE Locations 
(
	provice nvarchar(30),
	district nvarchar(30),
	ward nvarchar(30)
)
SELECT * FROM Locations


-- PHÂN TÍCH TABLE
--1. TRÙNG LẶP CỤM INFO TỈNH-QUẬN

--2. LOOKUP TRÊN PROVICE, DISTRICT(WARD)

--3. SỰ PHỤ THUỘC LOGIC GIỮA TỈNH VÀ DISTRICT (WARD)
--   FUNCTIONAL DEPENDENCY - FD - PHỤ THUỘC HÀM
--   CÓ 1 CÁI ÁNH XẠ, MỐI QUAN GIỮA A VÀ B, PROVINCE VS. DISTRICT
-- CỨ CHỌN TP.HCM -> Q1, Q2, Q3,...
--		ĐN        -> BH, LBT, LK,..

-- Y = F(X) = X^2, CỨ CHỌN F(2) -> 4

-- TÁCH LOOKUP VÌ DỄ NHẤT
-- RA 1 TABLE, PHẦN TABLE CÒN LẠI THÌ FK SANG LOOKUP

-- Vaccination(liều, tên-vaccine)
--								FK sang Vaccine(tên-vaccine)


--CHỈ LOOKUP 64 TỈNH, KO CHO CHỌN LỘN XỘN
CREATE TABLE Province
(
	PName nvarchar(30)
)
SELECT * FROM Locations --10581 dòng ứng với xã/phường/quận khác nhau
						--nhưng chỉ có 63 tình thành lặp lại
SELECT DISTINCT provice FROM Locations --giống cục thống kê
--dùng nó để insert sang table lookup
INSERT INTO Province VALUES(N'Thành phố Cần Thơ')
INSERT INTO Province VALUES(N'Thành phố Vĩnh Long')


--CÁCH INSERT THỨ 2
INSERT INTO Province VALUES(N'Thành phố Vĩnh Long'), (N'Thành phố Cần Thơ')
--MỖI DÒNG CÁCH NHAU BẰNG DẤU PHẨY

--TUYỆT CHIÊN INSERT THỨ 3
--COPY PASTE ĐÃ HỌC CHO 10K DÒNG

--TUYỆT CHIÊN INSERT THỨ 4
--INSERT INTO Province VALUES CÓ 63 TỈNH LÀ NGON - TA XÀI KIỂU SUB QUERY TRONG LỆNH INSERT

-- viết sai chỉnh tả province :<
INSERT INTO Province SELECT DISTINCT l.provice FROM Locations l

SElECT COUNT(*) FROM Locations --10581 xã phường
SElECT COUNT(provice) FROM Locations --10581 xã phường
SElECT COUNT(distinct provice) FROM Locations --10581 xã 
SElECT COUNT(*) AS NoPname FROM Province

-- TẠO TABLE LOOKUP QUẬN/HUYỆN
CREATE TABLE District
(
	DName nvarchar(30)
)

--có bao nhiêu quận ở Việt Name
SElECT district FROM Locations --10581 quận được lặp lại, ăn theo cả phường xã
SElECT DISTINCT district FROM Locations --683 quận được 
-- RẤT CẨN THẬN KHI CHƠI VỚI QUẬN/HUYỆN
--TIỀN GIANG, VĨNH LONG, TRAG VINH, ĐỀU CÓ HUYỆN "CHÂU THÀNH"
-- BẢNG DISTRICT CHỈ CÓ 1 CHÂU THÀNH, LÁT HỒI!!!

-- PK CỦA District ko thể là TÊN QUẬN/HUYỆN ĐC!!!


SElECT COUNT(DISTINCT district) FROM Locations

--CHÈN VÀO TABLE QUẬN
INSERT INTO District SELECT DISTINCT District FROM Locations

SELECT * FrOM District

-- City và District CÓ SỰ PHỤ THUỘC LẪN NHAU, TỪ THẰNG NÀY SUY NGƯỢC RA DC THẰNG KIA
-- NHÌN QUẬN CÓ THỂ ĐOÁN T/P (CHIỀU NÀY KO CHẮC AN TOÀN)
--							 NHÌN CHÂU THÀNH, SAO ĐOÁN ĐƯỢC TỈNH??? ST, TV, VL
-- NHÌN T/P ĐOÁN RA QUẬN (HỢP LÍ VỀ SUY LUẬN)
--							 VL -> MANG THÍT, VL, CHÂU THÀNH
--							 ST -> ... CHÂU THÀNH
-- FD NÊN ĐỌC LÀ CITY -> DISTRICT 
-- TABLE CHỨA CÁC FD KIỂU PHỤ THUỘC NGANG GIỮA CÁC CỘT -> SUY NGHĨ ĐẾN VIỆC TÁCH BẢNG
-- TÁCH THẰNG VẾ TRÁI & PHẢI, RA TABLE KHÁC!!!, TÁCH XONG THÌ PHẢI FK
-- CÒN LẠI

-- SAU KHI TÁCH TA CÓ TRONG TAY 3 TABLE
-- PROVINCE( PName)

--			DISTRICT (DName, PName(FK lên trên))

--				WARD ( WName phường nào, quận nào DName (FK lên Quận))


-- GIẢI PHÁP "DỞ" CHO HUYỆN CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY!!! TA SẼ LÀM SAU
-- DÙNG NATURAL KEY, KEY TỰ NHIÊN - DÙNG TÊN CỦA TỈNH, HUYỆN LÀM KEY 
-- DÙNG KEY TỰ GÁN, TỰ TĂNG, KEY THAY THẾ, KEY GIẢ (SURROGATE KEY/ARTIFICIAL KEY)

-- PHIÊN BẢN ĐẸP NHƯNG VẪN CÒN CHÚT CHÂU THÀNH!!!
DROP TABLE Province
DROP TABLE District

CREATE TABLE Province
(
	PName nvarchar(30) PRIMARY KEY	
)
INSERT INTO Province SELECT DISTINCT l.provice FROM Locations l
SELECT * FROM Province

DROP TABLE District
CREATE TABLE District
(
	DName nvarchar(30) NOT NULL, -- HOK CÓ 2 CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY
	-- QUẬN NÀO VẬY

	--VẢ THUỘC VỀ TỈNH/THÀNH PHỐ NÀO VẬY
	PName nvarchar(30) NOT NULL REFERENCES Province(PName)
							--THAM CHIẾU ĐỂ KO NHẬP TỈNH KO TỒN TẠI, TỈNH AHIHI
	PRIMARY KEY(DName, PName)
)
INSERT INTO District 

SELECT District, provice FROM Locations  --10581 PHƯỜNG XÃ BỊ CẮT CỘT WARD
SELECT * FROM Locations

SELECT DISTINCT District, provice FROM Locations ORDER BY District --699 quận, có rất nhiều Châu thành của 6 tỉnh miền Tây
INSERT INTO District 
						SELECT DISTINCT District, provice 
						FROM Locations ORDER BY District 
SELECT * FROM District
--COMPOSITE KEY

--hỏi thử: TPHCM có những Quận nào???
SELECT DName FROM District WHERE PName = N'Thành phố Hồ Chí Minh'

SELECT DName FROM District WHERE PName = N'Tỉnh Long An'
SELECT DName FROM District WHERE PName = N'Tỉnh Sóc Trăng'

-- THÀNH PHẦN ĐÔNG DATA NHẤT LÀ WARD/PHƯỜNG, CÓ 10581 DÒNG
-- ỨNG VỚI VÔ SỐ LẶP LẠI CÁC QUẬN, FK
-- xã có trùng tên hem
CREATE TABLE Ward
(
	WNAME nvarchar(30),
	--Xã phường ơi, bạn ở quận nào?
	DName nvarchar(30) --REFERENCES District(DName)
)

SELECT * FROM Locations --10581 Xã Phường, liệu rằng có trùng???
SELECT COUNT(Distinct Ward) FROM Locations
							--7884, TRÙNG TÊN 3000 TÊN

SELECT Ward FROM Locations ORDER BY Ward

INSERT INTO Ward SELECT Ward, district FROM Locations --10581
SELECT * FROM Ward

--CHO TUI XEM CÁC PHƯỜNG CỦA Q1. TPHCM
SELECT * FROM Ward WHERE DName = N'Quận 1'


-- Huyện Châu Thành của Tiền Giang có những xã nào!!!
--23 xã
SElECT w.WName, w.DName, d.PName FROM Ward w INNER JOIN 
							District d ON W.DName = d.DName INNER JOIN Province			p ON p.PName = d.PName
							WHERE d.DName = N'Huyện Châu Thành' 
							AND d.PName = N'Tỉnh Tiền Giang'

-- TABLE PROVINCE CŨNG CHÂU THÀNH NÊN DÙ CÓ JOIN ĐI NỮA THÌ VẪN TRÙNG VỚI CÁC THÀNH PHỐ KHÁC