USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- MỘT DB là nơi chứa data (bán hàng, thư viện, qlsv,...)
-- DATA đc lưu dưới dạng TABLE, tách thành nhiều TABLE (nghệ thuật design db, NF)
-- Dùng  lệnh SELECT để xem, in dữ liệu từ table, cx hiển thị dưới dạng table
-- CÚ PHÁP CHUẨN: SELECT * FROM <TÊN-TABLE>
--						 * đại diện cho việc tui mún lấy all of colums
-- CÚ PHÁP MỞ RỘNG
--				SELECT TÊN CÁC CỘT MUỐN LẤY, CÁCH-NHAU-DẤU-PHẨY FROM <TÊN-TABLE>
--				SELEC CÓ THỂ DÙNG CÁC HÀM XỬ LÍ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ
--				FROM <TÊN-TABLE
-- DATA trả về có cell/ô có NULL, hiểu rằng chưa xác định value/giá trị, chưa có, chưa biết
-- từ từ cập nhật sau. Ví dụ sv kí tên vào danh sách thi, cột điểm ngay lúc kí tên
-- gọi là NULL, mang trạng thái chưa xác định
------------------------------------------------

--1. Xem thông tin của tất cả các khách hàng đang giao dịch với mình
SELECT * FROM Customers
INSERT INTO Customers(CustomerID, CompanyName, ContactName)
					VALUES('ALFKI', 'HUIT', 'Xuân Trọng')
					--bị chửi vì trùng PK
INSERT INTO Customers(CustomerID, CompanyName, ContactName)
					VALUES('KKKKH', 'HUIT', 'Xuân Trọng')
					--oke					
--2. Xem thông tin nhân viên, xem hết các cột lun
SELECT * FROM Employees

--3. Xem các sản phẩm đang có trong kho
SELECT * FROM Products

--4. Mua hàng, thì thông tin sẽ nằm ở table Order và OrderDetails
SELECT * FROM Orders	--830 bill

--5. Xem thông tin công ty giao hàng
SELECT * FROM Shippers
INSERT INTO Shippers(CompanyName, Phone) VALUES ('Fedex Vietnam', '(080)90...')		
--6. XEM CHI TIẾT MUA HÀNG	
SELECT * FROM Orders			-- PHẦN TRÊN CỦA BILL SIÊU THỊ
SELECT * FROM [Order Details]	-- PHẦN TABLE KẺ GIÓNG LỀ NHỮNG MÓN HÀNG ĐÃ MUA
--7. In ra thông tin khách hàng, chr gồm cột Id, ComName, ContactName, Country
SELECT CustomerID, CompanyName, ContactName, Country FROM Customers
--8. In thông tin nhân viên, chỉ cân Id, Last, First, Title, DOB
-- Tên người tách thàn Last & First: dành cho mục tiêu sort theo tiêu chí tên, họ. In ra
-- tên theo quy ước mọi quốc gia
SELECT * FROM Employees
SELECT EmployeeID, LastName, FirstName, Title, BirthDate FROM Employees

--9. In ra thông tin nhân viên, ghép tên co đẹp/gộp cộ, tín luôn tuổi giùm tui
SELECT LastName + ' '+ FirstName + CONVERT(CHAR, YEAR(BirthDate)) FROM Employees
SELECT LastName + ' '+ FirstName AS [FULL NAME], CONVERT(CHAR, YEAR(BirthDate)) AS YOB FROM Employees
SELECT LastName + ' '+ FirstName AS [FULL NAME], BirthDate,CONVERT(CHAR, YEAR(BirthDate)) AS YOB, CONVERT(CHAR, (YEAR(GETDATE()) - YEAR(BirthDate))) AS Age FROM Employees

--10. In ra thông tin chi tiết khách hàng
SELECT * FROM [Order Details]
SELECT *, UnitPrice * Quantity [Tạm Tính] From [Order Details]
--CÔNG THỨC TÍH TỔNG IỀN PHẢI TRẢ TỪNG MÓN, CÓ TRƯ ĐI GIẢM GIÁ, PHẦN TRĂM
--SL * ĐG - GIẢM GIÁ ==> PHẢI TRẢ
--SL * ĐG - SL * ĐG * DISCOUNT (%) == PHẢI TRẢ

--SL * ĐG (1 - DISCOUNT %) ==> TIỀN PHẢI TRẢ
SELECT *, UnitPrice * Quantity [Tam Tinh], UnitPrice * Quantity * (1 - Discount) AS SubTotal From [Order Details]
