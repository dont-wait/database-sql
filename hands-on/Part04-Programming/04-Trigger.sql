--TRIGGER: CÒ SÚNG
-- TRIGGER LÀ 1 HÀM VOID, KO NHẬN THAM SỐ, KO TRẢ VỀ
-- NÓ LÀM NHIỆM VỤ GÁC CỔNG 1 TABLE NÀO ĐÓ. NẾU AI ĐÓ CÓ SỰ THAY ĐỔI DATA TRONG TABLE 
-- NÓ SẼ TỰ ĐỘNG ĐƯỢC THỰC THI, CHẠY
-- DÙNG ĐỂ KIỂM TRA/HAY ĐẢM BẢO TÍNH TOÀN VẸN/NHẤT/CONSISTENCY QUÁN CỦA DỮ LIỆU 
-- HOẶC DÙNG ĐỂ KIỂM TRA CÁC RÀNG BUỘC MÀ SQL CHUẨN KO THỂ CUNG CẤP ĐỦ
-- CHỈ TỰ GỌI LIÊN QUAN ĐẾN TABLE NÀO ĐÓ VÀ LIÊN QUAN ĐẾN 3 LỆNH INSERT, UPDATE, DELETE
-- GẮN CHẶT VỚI 1 TABLE, NHƯNG KO CẤM CODE CỦA NÓ CAN THIỆP TABLE KHÁC
-- 1 TABLE KO ÉP PHẢI CÓ TRIGGER

CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(30) NOT NULL
)
SELECT * FROM Event

GO

CREATE TRIGGER TR_CheckInsertionOnEvent ON [Event]
FOR INSERT
AS 
BEGIN
	PRINT 'You have just insertd a record in Event table'
END

GO

EXEC PR_InsertEvent N'Blockchain & Game' -- kiểm tra xem có thông báo không khi insert 1 Event
select * from Event



--PHÁ HÔI: KO CHO INSERT VÀO TABLE EVENT
GO
CREATE TRIGGER TR_ForbidInsertionEvent ON [Event]
FOR INSERT
AS 
BEGIN
	PRINT 'You have just insertd a record in Event table. Sorry'
	ROLLBACK -- cấm, undo những gì đã xảy ra khi insert
END
GO
EXEC PR_InsertEvent N'Thổi nến và Tài chính 4.0' -- kiểm tra xem có thông
SELECT * FROM Event
DROP TRIGGER TR_ForbidInsertionEvent
DROP TRIGGER TR_CheckInsertionOnEvent

--KIỂM TRA KO CHO INSERT QUÁ 5 RECORDS/EVENT
--SQL CÓ THỂ ĐẾM, QUYẾT ĐỊNH ĐẾM XONG LÀM GÌ TIẾP -> LẬP TRÌNH!! -> TRIGGER CHẶN KHÔNG CHO VÀO

--DROP TRIGGER TR_CheckInserttionLimitationEvent
GO

CREATE TRIGGER TR_CheckInserttionLimitationEvent ON [Event]
FOR INSERT
AS
BEGIN
	-- XEM THỬ NGƯỜI TA CHÈN CÁI EVENT GÌ VÀO TABLE???
	
	SELECT * FROM INSERTED
	ROLLBACK
END

EXEC PR_InsertEvent N'Thổi nến và Tài chính 4.0' -- kiểm tra xem 
SELECT * FROM Event

GO
-- LƯU Ý KHI CHƠI TRIGGER
-- DB ENGINE SẼ TỰ TẠO RA 2 TABLE "ẢO" LÚC RUNTIME LIÊN QUAN ĐẾN TRIGGER
-- CÂU LỆNH INSERT VÀO TABLE -> DB E. TẠO RA 1 TABLE ẢO TÊN LÀ INSERTED
-- CHỨA RECORD VAUWF ĐƯA VÀO TỪ CÂU LỆNH INSERT

-- CÁC LỆNH DELETE FROM -> DB E. TẠO RA 1 TABLE 'ẢO' TÊN LÀ DELETED
-- CHỨA NHỮNG DÒNG VỪA BỊ XOÁ!!!

-- CÂU LỆNH UPDATE EVENT SET NAME = 'ĐỔI TÊN SỰ KIỆN' -> DB. TẠO 2 TABLE ẢO
-- INSERTED CHỨA VALUE MỚI ĐƯA VÀO
-- DELETED CHỨA VALUE CŨ/BỊ GHI DÈ



GO
CREATE TRIGGER TR_CheckInserttionLimitationEvent ON [Event]
FOR INSERT
AS
BEGIN
	-- KIỂM TRA XEM TRONG TABLE EVENT KO CHO VƯỢT QUÁ 5
	-- IF SỐ SỰ KIỆN > 5 THÌ ROLLBACK!!!
	-- PHẢI ĐẾM SỐ SỰ SỰ KIỆN ĐANG CÓ!!!
	-- LẤY ĐC SỐ SK RA ĐỂ IF, TỨC LÀ KHAI BÁO BIẾN
	-- NHỚ LỆNH COUNT(*) TRONG SELECT TRẢ VỀ 1 TABLE, HOK TRẢ VỀ 1 BIẾN, TA PHẢI
	DECLARE @noEvents int
	SELECT @noEvents = COUNT(*) FROM Event
	--SELECT @noEvents
	IF @noEvents > 5
	BEGIN
		PRINT 'To much events. No more 5 events!!!'
		ROLLBACK
	END
	--SELECT * FROM INSERTED
END

SELECT * FROM Event
EXEC PR_InsertEvent N'Làm sao sống sót ở FU'
EXEC PR_InsertEvent N'Thổi nến và Tài chính'



-- LIÊN QUAN ĐẾN TABLE, CÓ 2 LOẠI TRIGGER CƠ BẢN:
-- CHẶN TRƯỚC KHI DỮ LIỆU ĐƯA VÀO TABLE, LÚC NÀY DỮ LIỆU MỚI VÀO INSERTED (BEFORE)

-- CHẶN SAU KHI ĐÃ VÀO INSERTED VÀ ĐỒNG THỜI VÀO LUÔN TABLE RỒI (AFTER)

-- ví dụ về before: mời khách vào nha, nay ko gặp -> về
-- ví dụ về after: khách vào nha rồi, ông chủ ốm ko gặp -> về
-- đi làm thêm: bạn đc vào làm nhưng một thời gian ngân sách kh đủ cần cắt giảm nhân sự -> trigger after