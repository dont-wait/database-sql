-- PHẦN NÀY THÍ NGHIỆM CÁC LOẠI RÀNG BUỘC - CONSTRAINTS - QUY TẮC GÀI TRÊN DATA

--1. RÀNG BUỘC PRIMARY KEY
-- tạm thời chấp nhân PK là 1 cột (tương lai có thể nhiều cột) mà giá trị
-- của nó trên mọi dòng/mọi cell của cột này ko trùng lại, mục đích dùng để 
-- WHERE ra đc 1 dòng duy nhất
-- VALUE CỦA KEY CÓ THỂ ĐƯỢC TẠO RA THEO 2 CÁCH
-- CÁCH 1: TỰ NHẬP = TAY, DB ENGINE SẼ TỰ KIỂM TRA GIÙM MÌNH CÓ TRÙNG HAY KO?
--			NẾU TRÙNG DB ENGINE TỰ BÁO VI PHẠM PK CONSTRAINT - HỌC RỒI   --UK: TRẢI NGHIỆM SƯỚNG 
															 --UI: GIAO DIỆN ĐẸP

-- CÁCH 2: ÉO CẦN NHẬP = TAY CÁI VALUE CỦA PK, MÁY /DB ENGINE TỰ GENERATE  CHO
--			MÌNH 1 CON SỐ KO TRÙNG LẠI!!! CON SỐ TỰ TĂNG, CON SỐ KIỂU HEXA...

-- THỰC HÀNH
-- THIẾT KẾ TABLE lưu thông tin đăng kí event nào  đó (giống đk qua gg form)
-- thông tin cần lưu trữ: số thứ tự đăng kí, tên full name, email, 
-- ngày giờ đăng kí, số di động,...
-- * Phân tích:
-- ngày giờ đko: ko bắt nhập, default
-- số thứ tự: nhập vào là bậy ròi!!! tự gán chứ!!!
-- email, phone: ko ho trùng heng, 1 email 1 lần đăng kí
USE DBDESIGN_ONETABLE
/*
CREATE TABLE Registration 
(
	SEQ int PRIMARY KEY, --PHẢI TỰ NHẬP SỐ THỨ TỰ? NO
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50), -- CẤM TRÙNG LÀM SAO???
	Phone varchar(11),
	RegData datetime DEFAULT GETDATE() --LẤY RA THỜI GIAN HIỆN TẠI
										-- CONSTRAINT DEFAULT
			
)
*/
CREATE TABLE Registration 
(
	SEQ int PRIMARY KEY IDENTITY, --PHẢI TỰ NHẬP SỐ THỨ TỰ? NO
								  -- mặc định đi từ 1, nhảy  ++  cho người sau
								  -- ghi rõ IDENTITY(1, 1)
								  -- IDENTITY(1,5), từ 1, 6, 11,...
								  --		bước nhảy
	FirstName nvarchar(10),			
	LastName nvarchar(30),
	Email varchar(50), -- CẤM TRÙNG LÀM SAO???
	Phone varchar(11),
	RegData datetime DEFAULT GETDATE() --LẤY RA THỜI GIAN HIỆN TẠI
										-- CONSTRAINT DEFAULT		
)

--ĐĂNG KÍ EVENT
INSERT INTO Registration VALUES (N'An', N'Nguyễn', '@hihi', '9090')
-- báo lỗi map do không đủ cột, ko tự suy được do mài đưa ko đủ value, m phải nói rõ là đây tui đưa null, ko giá trị, chứ không phải rỗng

INSERT INTO Registration VALUES (N'An', N'Nguyễn', '@hihi', '9090', null)
SELECT * FROM Registration

INSERT INTO Registration(FirstName, LastName, Email, Phone) 
			VALUES (N'Bình', N'Lê', 'binh@hihi', '9090') -- tao không đưa khác t đưa null

-- XOÁ 1 DÒNG CÓ AUTO GENERATED KEY, THÌ TABLE SẼ LŨNG LỖ, DB ENGINE KO LẤY ĐỦ LỖ
-- 1 2 3 4 5 6 XOÁ 5 1 2 3 4 6 7, ĐĂNG KÍ TIẾP - CẦN CON SỐ THÔI MÀ - NHÀ NHIỀU SỐ MÀ LO CHI VIỆC PHẢI LẮP LẠI, ẢNH HƯỞNG ĐẾN PERFORMANCE

