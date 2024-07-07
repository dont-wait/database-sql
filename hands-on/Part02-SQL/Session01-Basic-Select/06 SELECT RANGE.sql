USE Northwind
------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- KHI CẦN LỌC DỮ LIỆU TRONG 1 ĐOẠN CHO TRƯỚC, THAY VÌ DÙNG >= AND <= ...., TA CÓ THỂ THAY THẾ
-- BẰNG MỆNH DỀ BETWEEN, IN 
-- * Cú pháp: CỘT BETWEEN VALUE-1 AND VALUE-2
--						  >>>>>>> BETWEEN THAY THẾ CHO 2 MĐ <= >= AND
-- * Cú pháp: CỘT IN (MỘT tập các giá trị được tập hợp trong 1 dấu phẩy)
--								>>>>>>> IN SẼ THAY THẾ CHO 1 LOẠT OR
------------------------------------------------
-- 1. Liệt kê danh sách nhân viên sinh trong nằm 1960...1970
SELECT * FROM Employees WHERE YEAR(BIRTHDate) >= 1960 AND YEAR(BIRTHDATE) <= 1970 
						ORDER BY BirthDate DESC
SELECT * FROM Employees WHERE YEAR(BIRTHDate) BETWEEN 1960 AND 1970 
						ORDER BY BirthDate DESC
-- 2. Liệt kê các đơn hàng có trọng lượng từ 100 đến 500
SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 500
-- 3. Liệt kê các đơn hàng gửi tới ANH PHÁP MĨ
SELECT * FROM Orders WHERE ShipCountry = 'USA' 
						OR ShipCountry = 'France' 
						OR ShipCountry = 'UK'
SELECT * FROM Orders WHERE ShipCountry IN ('USA', 'France', 'UK')
-- 4. Liệt kê các đơn hàng ko gửi tới ANH PHÁP MĨ
SELECT * FROM Orders WHERE NOT(ShipCountry = 'USA' 
						OR ShipCountry = 'France' 
						OR ShipCountry = 'UK')
SELECT * FROM Orders WHERE ShipCountry != 'USA' 
						AND ShipCountry != 'France' 
						AND ShipCountry != 'UK'
SELECT * FROM Orders WHERE ShipCountry NOT IN ('USA', 'France', 'UK')
-- 5. Liệt kê các đơn hàng xuất hiện trong năm 1996 ngoại trừ các tháng 6 7 8 9
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1996 
					 AND MONTH(OrderDate) NOT IN(6, 7, 8, 9) --82
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1996 
					 AND MONTH(OrderDate) NOT BETWEEN 6 AND 9 --82

-- LƯU Ý IN: CHỈ KHI TA LIỆT KÊ ĐC TẬP GIÁ TRỊ THÌ MỚI CHƠI IN
-- KHOẢNG SỐ THỰC THÌ KHÔNG LÀM ĐƯỢC

-- 6. Liệt kê các đơn hàng có trọng lượng từ 100..110
SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 110 ORDER BY Freight DESC