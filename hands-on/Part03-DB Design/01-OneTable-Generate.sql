
--GENERATE TỪ ERD TRONG TOOL THIẾT KẾ
CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(50) NOT NULL, 
 PRIMARY KEY (StudentID)); --tự db engine đặt tên cho rb
--DROP TABLE Student
SELECT * FROM Student
INSERT INTO Student VALUES('SE1234', N'Nguyễn', N'An');
-- POWER DESIGNER VS. VISUAL PARADIGM
--			ĐỨC-SAP


-----------------------------------------------------------
-- HỌC THÊM VỀ CÁI CONSTRAINS - TRONG ĐÓ PK CONSTRAINT
-- Ràng buộc là ác ta/db designer ép cell/cột nào đó value phải ntn
-- dặt ra quy tắc/rule cho việc nhập data
-- vì có nhiều quy tắc, nên tránh nhầm lẫn, dễ kiểm soát ta sẽ có quyền
-- đặt tên cho các quy tắc, contraint name
-- ví dụ: Má ở nhà đặt quy tắc/nội quy cho mình
-- Rule#1: vào SG học thật tốt nha con. Tốt: điểm tb >= 8 && ko rớt môn nào
--				&& học kì ra trường &&  đổi chuyên ngành
-- Rule#2: Tối đi chơi về nhà sớm.Sớm: trong tối cùng ngày, trước 10h khuya
-- Rule#3: ???
-- Tên ràng buộc/quy tắc			nội dung/cái data đc gài vào
--		Pk__????							PRIMARY KEY
-- Mặc định các DB Engine nó tự đặt tên cho các RB nó thấy khi bạn gõ câu
-- lệnh DDL
-- DB En cho mình cơ chế tự đặt tên RB
CREATE TABLE StudentV6 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(50) NOT NULL, 
 -- PRIMARY KEY (StudentID)); --tự db engine đặt tên cho rb
 CONSTRAINT PK_STUDENTSV6 PRIMARY KEY (StudentID)
);


-- DÂN PRO ĐÔI KHI CÒN LÀM CÁCH SAU, NGƯỜI TA TÁCH HẲN VIỆC TẠO RB KHOÁ CHÍNH, KHOÁ NGOẠI
-- RA HẲN CẤU TRÚC TABLE, TỨC LÀ CREATE TABLE CHỈ CHỨA TÊN CẤU TRÚC - CỘT - DOMAIN
-- TẠO TABLE XONG RỒI CHỈNH SỬA TABLE - SỬA CÁI TỦ CHỨ KHÔNG PHẢI DATA TRONG TỦ 
-- ALTER: THAY ĐỔI KẾT CẤU CÁI TỦ, TOÀ NHÀ, CHỨ KHÔNG PHẢI DATA
DROP TABLE StudentV7

CREATE TABLE StudentV7 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(50) NOT NULL, 
);
--NẾU TRONG TÌNH HUỐNG CONSTRAINT KEY = NULL NGAY TỪ ĐẦU, THÌ KHÔNG ĐƯỢC PHÉP ALTER TABLE ADD CONTRAINST NX

 -- PRIMARY KEY (StudentID)); --tự db engine đặt tên cho rb
 --CONSTRAINT 
ALTER TABLE StudentV7 ADD CONSTRAINT PK_STUDENTSV7 PRIMARY KEY (StudentID)

-- XOÁ 1 RÀNG BUỘC ĐƯỢC KHÔNG, CHO ADD THÌ CHO T DROP
ALTER TABLE StudentV7 DROP CONSTRAINT PK_STUDENTSV7 