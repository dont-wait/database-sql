-- Kiểu dữ liệu- datatype là cách ta lưu loại dữ liệu
-- nào đó số(nguyên, thực), 
-- chữ ,câu/đoạn, ngày tháng, tiền($...)
-- 1 NNLT sẽ hỗ trợ nhiều loại dữ liệu khác nhau - data type

-- Khi lập trình trong SQL Server, vì câu lệnh sẽ nằm trên nhiều dòng...
-- mình cần nhắc Tool này 1 câu: ĐỪNG NHÌN LỆNH MỘT CÁCH RIÊNG LẼ(NHIỀU DÒNG) MÀ HÃY NHÌN NGUYÊN CỤM LỆNH MỚI CÓ Ý NGHĨA (BATCH)
-- Ta dùng lệnh GO để gom 1 cụm lệnh lập trình lại thành một đơn vị có ý nghĩa

-- KHAI BÁO BIẾN
GO
DECLARE @msg1 nvarchar(30)
DECLARE @msg nvarchar(30) = N'Xin chào - Welcome to T-SQL'

--IN BIẾN CÓ 2 LỆNH
PRINT @msg -- IN RA KẾT QUẢ BÊN CỬA SỔ CONSOL GIỐNG TRONG LẬP TRÌNH

SELECT @msg -- IN RA KẾT QUẢ DƯỚI DẠNG TABLE

DECLARE @yob int --= 2003

-- GÁN GIÁ TRỊ CHO BIẾN
SET @yob = 2004
SELECT @yob = 2005 -- SELECT DÙNG 2 CÁCH: GÁN GIÁ TRỊ CHO BIẾN, IN GIÁ TRỊ CHO BIẾN
PRINT @yob

IF @yob > 2003
	BEGIN --{
		PRINT 'HEY, BOY/GIRL'
		PRINT 'HELLO GEN Z'
	END   --}
ELSE 
	PRINT 'HELLO LADY & GENTLEMENT'
GO