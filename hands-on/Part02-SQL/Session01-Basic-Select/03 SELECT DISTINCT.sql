USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- Dùng  lệnh SELECT để xem, in dữ liệu từ table, cx hiển thị dưới dạng table
-- CÚ PHÁP CHUẨN: SELECT * FROM <TÊN-TABLE>
--						 * đại diện cho việc tui mún lấy all of colums
-- CÚ PHÁP MỞ RỘNG
--				SELECT TÊN CÁC CỘT MUỐN LẤY, CÁCH-NHAU-DẤU-PHẨY FROM <TÊN-TABLE>
--				SELEC CÓ THỂ DÙNG CÁC HÀM XỬ LÍ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ
--				FROM <TÊN-TABLE
-- KHI TA SELECT ÍT CỘT TỪ TABLE GỐC thì có nguy cơ dữ liệu sẽ bị trùng lặp
-- Không phải ta bị sai, không phải người thiết kế table và người nhập liệu bị sai
-- Do chúng ta có nhiều INFo trùng nhau/đặc điểm trùng nhau, nếu chỉ tập trung vào data này
-- trùng nhau là chắc chắn xảy ra
-- 100 triệu người dân VN đc quản lí info bao gồm: ID, tên, DOB,... Tỉnh thành sinh sống
--												   <>					63 Tỉnh
--												   <>				    63 tỉnh
-- LỆNH SELECT HỖ TRỢ LOẠI TRỪ DÒNG TRÙNG NHAU/TRÙNG 100%
-- SELECT DISTINCT TÊN-CÁC-CỘT FROM <TÊN-TABLE>
---------------------------------------------------------
------------------------------------------------
--1. Liệt kê danh sách nhân viên
SELECT * FROM Employees
-- Phan tích: 9 người nhưng chỉ có 4 title. ~~~ 100 triệu dân chỉ có 63 tỉnh thành
SELECT TitleOfCourtesy From Employees -- 9 cái nhưng thật chất chỉ có 4
SELECT DISTINCT TitleOfCourtesy From Employees -- 4

SELECT DISTINCT EmployeeID, TitleOfCourtesy From Employees -- 4
-- NẾU DISTINCT ĐI KÈM VỚI ID/KEY, NÓ VÔ DỤNG, KEY SAO TRÙNG MÀ LOẠI TRỪ

--2. In ra thông tin khách hàng
SELECT * FROM Customers --92 rows

--3. Có bao nhiêu quốc gia xuất hiện trong thông tin khách hàng
SELECT  Country FROM Customers --in hết 92

SELECT  DISTINCT Country FROM Customers