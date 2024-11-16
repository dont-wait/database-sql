-- HÀM: 1 NHÓM CÂU LỆNH ĐC ĐẶT 1 TÊN, NHÓM LỆNH NÀY LÀM 1 VIỆC 
-- GÌ ĐÓ. HÀM DÙNG ĐỂ RE-USE
-- HÀM CĂN BẬC 2, LẤY CĂN
-- TRONG LẬP TRÌNH CÓ 2 LOẠI HÀM:
-- HÀM VOID: KO TRẢ VỀ 1 GIÁ TRỊ NÀO CẢ
-- HÀM CÓ TRẢ VỀ 1 GIÁ TRỊ (CHỈ 1): LỆNH RETURN

-- R.DBMS (CSDL DỰA TRÊN RELATION/TABLE) TA CÓ 2 LOẠI HÀM
-- STORED PROCEDURE ~~~~ VOID
-- FUNCTION  ~~~~ RETURN 

-- C: void f(int* a, int* b) {

--	}
-- gọi hàm f()
-- int x = 10, y = 11;
-- f(&x, &y), khi trong hàm f mà làm gì với x và y thì x y ở khai báo ở trên, bên ngoài bị ảnh hưởng luôn
-- hàm thay đổi 2 giá trị x y ở bên ngoài, void mà lại đưa data ra ngoài qua con trỏ, truyền tham chiếu pass by references

-- VIẾT HÀM IN RA CÂU CHÀO!!!
--CREATE PROCEDURE PR_Hello() {...}
CREATE DATABASE DBDESIGN_PROGRAMMING
USE DBDESIGN_PROGRAMMING
GO
CREATE PROCEDURE PR_Hello
AS
	PRINT N'Xin chào - Welcome to my own first procedure'
GO

-- DÙNG PROCEDURE - HÀM VOID, GỌI TÊN EM LÀ ĐỦ
GO
PR_Hello
dbo.PR_Hello
GO
EXECUTE PR_Hello -- TUI MÚN THỰC THI, CHẠY THỦ TỤC, NHÓM LỆNH ĐÃ ĐẶT TÊN
GO
CREATE PROC PR_Hello_1
AS
	PRINT N'Xin chào - Welcome to my own 2nd procedure'
EXECUTE PR_Hello_1
GO

--------------------------------------------------
-- HÀM, PHẢI TRẢ VỀ GIÁ TRỊ!!! QUA LỆNH RETURN
GO

-- int f() {...code...}

DROP FUNCTION FN_Hello
CREATE FUNCTION FN_Hello() RETURNS varchar(50)
AS
BEGIN
	RETURN N'Xin chào - Welcome to my own first function in T/SQL'
END

GO
-- LƯU Ý - Y CHANG BÊN LẬP TRÌNH. HÀM TRẢ VỀ GIÁ TRỊ THÌ ĐƯỢC QUYỀN DÙNG TRONG CÁC CÂU LỆNH KHÁC
-- GỌI HÀM MÀ KO KÈM TRÊN GÌ KHÁC, ĐỪNG CÓ HỎI TẠI SAO MÀN HÌNH KO THẤY GÌ
-- NHIỆM VỤ HÀM LÀ TRẢ VỀ GIÁ TRỊ, IN ÉO PHẢI VIỆC CỦA HÀM, VIỆC KHÁC CUNGS
-- IN XEM HÀM XỬ LÍ RA SAO, THÌ PHẢI KÈM LỆNH IN VÀ LỆNH GỌI HÀM
-- sqrt(4); -> ko kết quả khi chạy
-- Math.sqrt(4);
-- sout(Math.sqrt(4)) -> có kết quả chạy hàm

PRINT dbo.FN_Hello() --bắt buộc phải có dbo.tên-hàm
--ko ép cho thằng stored procedure
SELECT dbo.FN_Hello() -- HÀM DÙNG XỬ LÍ TRẢ VỀ KQ, PHẢI DÙNG KQ TRONG LỆNH NÀO ĐÓ
SELECT GETDATE()

--GETDATE() -- báo lỗi, phải ghép vào lệnh khác

PRINT dbo.FN_Hello()

----------------------------------------------------------
-- VIẾT HÀM - PROCEDURE ĐỔI TỪ ĐỘ C SANG ĐỘ F, F = C * 1.8 + 32
-- THAM SỐ/ĐẦU VÀO/ARGUMENT
GO
CREATE PROC PR_C2F
@CDegree float
AS
BEGIN
	DECLARE @fDegree float = @cDegree * 1.0 + 32
	PRINT @fDegree 
END
GO

EXECUTE PR_C2F @CDegree = 37
EXEC PR_C2F 37

---------------------------------
GO
CREATE FUNCTION FN_C2F(@cDegree float)
RETURNS float
AS 
BEGIN
	RETURN @cDegree * 1.8 + 32
END

GO
-- sử dụng hàm, hàm là phải viết kèm với lệnh khác
PRINT N'37 độ C là: ' + CAST(dbo.FN_C2F(37) AS varchar(10)) + N' độ F'

-- PROCEDURE LÀM ĐC NHIỀU VIỆC KHÁC:
-- VIẾT 1 PROCEDURE IN RA DANH SÁCH CÁC NHÂN VIÊN QUÊ Ở ĐÂU ĐÓ, ĐÂU ĐÓ ĐƯA VÀO PROC
-- VIEW: IN RA AI Ở LONDON
-- VIEW: IN RA AI ĐÓ Ở KIRKLAND,...
-- MỖI VIEW LÀ 1 SÊLECT VÀ LÀ 1 TABLE ĐỂ REUSE
-- PROCEDURE IN RA KẾT QUẢ NHƯ VIEW, KO REUSE LẠI (CHỈ IN RA) NHƯNG LẠI NHẬN ĐƯỢC THAM SỐ
USE Northwind
GO

CREATE PROC PR_EmployeeListByCity
@city nvarchar(30)
AS
	SELECT * FROM Employees WHERE City = @city

GO

SELECT * FROM Employees WHERE City = 'Redmond'

EXEC PR_EmployeeListByCity @city = 'Redmond'

EXEC PR_EmployeeListByCity 'Seattle'

-- ỨNG DỤNG THÊM CỦA PROCEDURE, VIẾT PROC INSERT DATA
USE DBDESIGN_PROGRAMMING
CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(30) NOT NULL
)
INSERT INTO [Event] VALUES(N'Lời nói dối chân thân')
SELECT * FROM Event

GO

CREATE PROC PR_InsertEvent
@name nvarchar(30)
AS
INSERT INTO [Event] VALUES(@name)

GO	

EXEC PR_InsertEvent @name = N'Bí quyết dùng source ở FE'
EXEC PR_InsertEvent @name = N'Hồ Sen chờ ai'

SELECT * FROM Event