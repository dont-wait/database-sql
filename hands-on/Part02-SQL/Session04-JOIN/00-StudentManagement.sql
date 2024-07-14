DROP DATABASE StudentManagement

CREATE DATABASE StudentManagement

USE StudentManagement

CREATE TABLE Major
(
	MajorID char(2) PRIMARY KEY,         -- PK Primary Key - Khóa chính
	MajorName varchar(30),
	Hotline varchar(11)
)

INSERT INTO Major VALUES('SE', 'Software Engineering', '090x')
INSERT INTO Major VALUES('IA', 'Information Assurance', '091x')
INSERT INTO Major VALUES('GD', 'Graphic Design', '092x')
INSERT INTO Major VALUES('JP', 'Japanese', '093x')
INSERT INTO Major VALUES('KR', 'Korean', '094x')

SELECT * FROM Major

DROP TABLE Student
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,          -- PK Primary Key - Khóa chính
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50), 
	MajorID char(2) REFERENCES Major(MajorID)  -- FK Foreign Key - Khóa ngoại
)

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE1', N'Nguyễn', N'Một', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE2', N'Lê', N'Hai', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE3', N'Trần', N'Ba', 'SE');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE4', N'Phạm', N'Bốn', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE5', N'Lý', N'Năm', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE6', N'Võ', N'Sáu', 'IA');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD7', N'Đinh', N'Bảy', 'GD');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD8', N'Huỳnh', N'Tám', 'GD');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('JP9', N'Ngô', N'Chín', 'JP');

SELECT * FROM Student

-- TỪ TỪ HÃY THÊM VÀO ĐỂ XEM FULL-OUTER JOIN RA SAO
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('UNK', N'Đặng', N'Mười', NULL);


SELECT * FROM Major
SELECT * FROM Student

--1. In ra thông tin chi tiết của SV kèm thông tin chuyên ngành
SELECT * FROM Student --info viết tắt của chuyên ngành
SELECT * FROM Major	  --chỉ có info chuyên ngành, thiếu info sv
-- JOIN cầm chắc rồi, lấy info đang nằm ở bên kia ghép thêm vào theo chiều ngang
SELECT * FROM Student s, Major m
         WHERE s.MajorID = m.MajorID --dư cột MajorID

SELECT s.*, m.MajorName, m.Hotline 
		 FROM Student s, Major m
         WHERE s.MajorID = m.MajorID

SELECT s.*, m.MajorName, m.Hotline 
		 FROM Student s INNER JOIN Major m
         ON s.MajorID = m.MajorID

--2. In ra thông tin chi tiết của sv kèm info chuyên ngành. Chỉ quan tâm sv SE và IA
SELECT s.*, m.MajorName, m.Hotline 
		 FROM Student s INNER JOIN Major m
         ON s.MajorID = m.MajorID
		 WHERE m.MajorID IN ('SE', 'IA') --6 GHÉP XOG ĐI ĐÃ GÒI FILTER --> ƯU TIÊN CÁCH NÀY VÌ MẶT TƯ DUY

SELECT s.*, m.MajorID, m.MajorName, m.Hotline 
		 FROM Student s, Major m
         WHERE s.MajorID = m.MajorID AND m.MajorID IN ('SE', 'IA') --GHÉP HẾT MỊA IK RÒI CHỌN LỌC SAU

--3. In ra thông tin các sinh viên kèm chuyên ngành. Chuyên ngành nào không có sinh viên cx in nốt
-- phân tích: căn theo sv mà in, Thì Hàn Quốc tèo ko xuất hiện
SELECT s.*, m.MajorName, m.Hotline 
		 FROM Student s RIGHT JOIN Major m --MajorID bị NULL vì đó là MajorID của Student KO phải của Table Major
         ON s.MajorID = m.MajorID

SELECT s.*, m.* 
		 FROM Student s RIGHT JOIN Major m
         ON s.MajorID = m.MajorID	--10 dòng

SELECT s.*, m.* 
		 FROM Major m LEFT JOIN Student s
         ON s.MajorID = m.MajorID	--10 dòng KR FA NULL

SELECT s.*, m.* 
		 FROM Student s LEFT JOIN Major m 
         ON s.MajorID = m.MajorID --9 dòng Lấy SV làm trọng

--4. Có bao nhiêu chuyên ngành???
SELECT * FROM Major
SELECT * FROM Student
SELECT COUNT(*) FROM Major
SELECT COUNT(MajorID) AS [No majors] FROM Major

--5. Mỗi chuyên ngành có bao nhiêu sinh viên???
--output 0: số lượng sv đang theo học của từng chuyên  ngành
--output 1: Mã chuyên ngành | số lượng sv đang theo học
--phân tích: hỏi sinh viên, bao nhiêu sinh viên, đếm sinh viên sure!!!
--			 gặp thêm từ MỖI!!!
--		     mỗi cn có 1 con số đếm, đếm theo cn, chia nhóm cn mà đếm
SELECT MajorID, COUNT(*) AS [No students] FROM Student GROUP BY MajorID
SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID

--6. CHuyên ngành nào có từ 3 sv trở lên
--phân tích: chia chặng rồi
--			 đầu tiên phải đếm chuyên ngành đã, quét qua bảng 1 lần để đếm ra sv
--			 đếm xog, dợt lại kết quả, lọc thêm cái từ 3 sv trở lên
--			 phải đếm xong từng chuyên ngành rồi mới tính tiếp

SELECT MajorID, COUNT(MajorID) AS [No students] 
							   FROM Student 
							   GROUP BY MajorID
							   HAVING COUNT(MajorID) >= 3

--7. CHuyên ngành nào có ít sv nhất  
SELECT MajorID, COUNT(MajorID) AS [No students] 
                               FROM Student 
							   GROUP BY MajorID
							   HAVING COUNT(MajorID) = 1 --ăn đòn
SELECT MajorID, COUNT(MajorID) AS [No students] 
                               FROM Student 
							   GROUP BY MajorID
							   HAVING COUNT(MajorID) <= ALL ( 
													SELECT COUNT(MajorID) AS [No students] 
													                      FROM Student 
																		  GROUP BY MajorID
												    )
--8. Đếm sv của chuyên ngành SE
--phân tích: câu này éo hỏi đếm các chuyên ngành
--CỨ TÌM SE MÀ ĐẾM, ĐẾM TẤT CẢ LÀM GÌ
SELECT MajorID, COUNT(*) AS [No students] FROM Student GROUP BY MajorID
										  HAVING MajorID = 'SE'	--CÂU NÀY CHẬM
SELECT MajorID, COUNT(*) AS [No students] FROM Student 
                                          WHERE MajorID = 'SE' 
										  GROUP BY MajorID --chỉ còn lại 1 nhóm, do bị ăn câu WHERE trước

--9 ĐẾM SỐ SV CỦA MỖI CN
--OUTPUT: mã chuyên ngành, tên cn, sl sinh viên
--phân tích: đáp án cần có info của 2 table
--			 đếm trên 2 table
--			 đếm trong Major thì hok có info SV
--			 đếm trong SV chỉ có được mã chuyên ngành
--		     mún có mã cn, tên cn, số lượng sv -> join 2 bảng rồi mới đếm
SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID

SELECT s.StudentID, s.FirstName, m.MajorID, m.MajorID FROM Student s INNER JOIN Major m
			            ON s.MajorID = m.MajorID

SELECT  m.MajorID, m.MajorName, COUNT(*) AS [No Students] 
						FROM Student s INNER JOIN Major m
			            ON s.MajorID = m.MajorID
						GROUP BY m.MajorID, m.MajorName

--10. Câu 10 điểm nè
--THẾ CÒN TRÒ CHƠI CON MỰC??
--CHUYÊN NGÀNH HÀN QUỐC ĐÂU
SELECT  m.MajorID, m.MajorName 
						FROM Student s RIGHT JOIN Major m
			            ON s.MajorID = m.MajorID

SELECT  m.MajorID, m.MajorName, COUNT(*) AS [No Students] 
						FROM Student s RIGHT JOIN Major m
			            ON s.MajorID = m.MajorID
						GROUP BY m.MajorID, m.MajorName			--SAI VÌ CÓ 1 DÒNG HQ FA, NULL VẾ SV
																--COUNT(*) LÀ ĐẾM DÒNG FA, HQ CÓ 1 SV NULL
						
SELECT  m.MajorID, m.MajorName, COUNT(StudentID) AS [No Students] 
						FROM Student s RIGHT JOIN Major m
			            ON s.MajorID = m.MajorID
						GROUP BY m.MajorID, m.MajorName --COUNT NULL LẠI ĐÚNG TRONG TRƯỜNG HỢP NÀY
														--VÌ MÃ SV LÀ NULL ỨNG VỚI SV CHUYÊN NGÀNH HÀN QUỐC
														--COUNT(*) CHỈ CẦN CÓ DÒNG LÀ RA 1, CHẤP DÒNG CÓ NHIỀU NULL HAY KHÔNG

														--ĐẾM CELL THÌ CELL NULL -> 0 DO NÓ ỨNG VỚI MAJOR NAME NHEN, KHÔNG CHIA NHÓM THÌ NÓ ẾU RA ÂU
						--DASH BOARD MÀN HÌNH THỐNG KÊ CỦA ADMIN WEBSITE TUYỂN SINH