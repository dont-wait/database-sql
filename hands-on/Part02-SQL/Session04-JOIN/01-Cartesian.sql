CREATE DATABASE Cartesian
--DB ~~~ KHO ~~ TỦ ~~~ THÙNG CHỨA DATA BÊN TRONG
--DATA BÊN TRONG CẤT DƯỚI DẠNG KỆ CÓ NGĂN - TABLE

USE Cartesian
CREATE TABLE EnDict					--DDL (1 Nhánh của SQL
									--Data Definition Language
(
	Nmbr int,
	EnDesc varchar(30)
)
--Từ điển tiếng anh  số đếm
--1 one
--2 two

SELECT * FROM EnDict --DML Data Manipulation Language

INSERT INTO EnDict VALUES(1, 'One') --DML
INSERT INTO EnDict VALUES(2, 'Two')
INSERT INTO EnDict VALUES(3, 'Three')

--DROP TABLE EnDict

-- PHẦN NÀY THÊM CHO OUTER JOIN
INSERT INTO EnDict VALUES (4, 'Four')

CREATE TABLE VnDict					--DDL (1 Nhánh của SQL
									--Data Definition Language
(
	Nmbr int,
	VnDesc nvarchar(30) --nvarchar() String lưu tiếng việt, PHáp, Trung
						--varchar() String lưu tiếng anh
)

INSERT INTO VnDict VALUES(1, N'Một') --DML
INSERT INTO VnDict VALUES(2, N'Hai')
INSERT INTO VnDict VALUES(3, N'Ba')
INSERT INTO VnDict VALUES(5, N'Năm')

SELECT * FROM VnDict
SELECT * FROM EnDict
--BÔI ĐEN CẢ 2 LỆNH NÀY CHẠY, THÌ NÓ KHÔNG PHẢI LÀ JOIN, NÓ LÀ 2 CÂU RIÊNG BIỆT CHẠY CÙNG LÚC
--CHO 2 TẬP KẾT QUẢ RIÊNG BIỆT!!!
--JOIN LÀ GỘP CHUNG 1 THÀNH 1 BẢNG TẠM TRONG RAM, KO ẢNH HƯỞNG DỮ LIỆU GỐC CỦA MỖI
--TABLE
--JOIN LÀ SELECT 1 LÚC NHIỀU TABLE

SELECT * FROM EnDict, VnDict --sinh table mới, tạm thời lúc chạy hoy
							 --số cột = tổng 2 bên
							 --số dòng = tích 2 bên

SELECT * FROM EnDict, VnDict ORDER BY EnDesc --KO ĐỤNG TÊN,  DÙNG TRỰC TIẾP
SELECT * FROM EnDict, VnDict ORDER BY Nmbr   --BỐI RỐI TRÙNG TÊN
--GHÉP TABLE, JOIN BỊ TRÙNG TÊN CỘT, DÙNG ALIAS (AS), ĐẶT TÊN GIẢ ĐỂ THAM CHIẾU
--									 CHỈ ĐỊNH CỘT THUỘC TABLE TRÁNH NHẦM
SELECT * FROM VnDict, EnDict ORDER BY VnDict.Nmbr --tham chiếu cột qua tên table
SELECT * FROM VnDict vn, EnDict en ORDER BY en.Nmbr --đặt tên ngắn/giả cho table
													--dùng tham chiếu cho các cột
SELECT vn.Nmbr, vn.VnDesc, en.EnDesc FROM VnDict vn, EnDict en ORDER BY en.Nmbr 
SELECT vn.*, en.EnDesc FROM VnDict vn, EnDict en ORDER BY en.Nmbr
SELECT vn.*, en.* FROM VnDict vn, EnDict en ORDER BY en.Nmbr 

--CÚ PHÁP VIẾT THỨ 2
SELECT vn.*, en.* FROM VnDict vn CROSS JOIN EnDict en ORDER BY en.Nmbr

--TUI BIẾT RẰNG CÓ CẶP GHÉP XÀI ƯỢC, VÌ CÓ SỰ TƯƠNG HỢP TRONG 1 CÁI CELL NÀO ĐÓ, HERE NUMBRR

SELECT vn.*, en.EnDesc FROM VnDict vn, EnDict en
				  WHERE vn.Nmbr = en.Nmbr				--rút từ 3x3 = 9 xuống còn 3
				  --GHÉP CÓ CHỌN LỌC KHI TÌM TƯƠNG QUAN CỘT/CELL ĐỂ GHÉP -> INNER JOIN/OUTER
				                     --EQUI JOIN
									 --ĐA PHẦN TƯƠNG QUAN THEO TOÁN TỬ =
									 --CÒN CÓ THỂ GHÉP THEO > >= < <= !=
SELECT vn.*, en.EnDesc FROM VnDict vn JOIN EnDict en 
                       ON vn.Nmbr = en.Nmbr