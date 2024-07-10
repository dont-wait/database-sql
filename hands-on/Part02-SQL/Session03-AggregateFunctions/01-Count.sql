USE Northwind
------------------------------------------------------------------------------------
-- LÍ THUYẾT
-- B ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàm gom nhóm - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()
-- * CÚ PHÁP CHUẨN
-- SELECT CỘT... HÀM GOM NHÓM()... FROM <TABLE> WHERE...

-- * CÚ PHÁP MỞ RỘNG
-- SELECT CỘT... HÀM HOM NHÓM()... FROM <TABLE>... WHERE... GROUP BY (GOM THEO CỤM CỘT NÀO) HAVING...

-- * HÀM COUNT(???) ĐẾM SỐ LẦN XUẤT HIỆN CỦA 1 CÁI GÌ ĐÓ???
--		 COUNT(*): ĐẾM SỐ DÒNG TRÊN TABLE, ĐẾM TẤT CẢ CÁC DÒNG KO CARE TIÊU CHUẨN NÀO KHÁC
--		 COUNT(*): FROM...WHERE ...
--					CHỌN RA NHỮNG DÒNG THOẢ TIÊU CHÍ WHERE NÀO ĐÓ TRƯỚC ĐÃ, RỒI MỚI ĐẾN
--					FILTER RỒI ĐẾM

--		 COUNT(CỘT NÀO ĐÓ):
------------------------------------------------------------------------------------
-- 1. In ra danh sách các nhân viên
SELECT * FROM Employees

--2. Đếm xem có bao nhiêu nhân viên
SELECT COUNT(*) FROM Employees 
SELECT COUNT(*) AS [Number of employees] FROM Employees 
--3. Có bao nhiêu nv ở London
SELECT COUNT(*) FROM Employees WHERE City = 'London'
SELECT COUNT(*) AS [N of emps in London] FROM Employees WHERE City = 'London'

--4. Có bao nhiêu lượt thành phố xuất hiện - cứ xuất hiện tên thành phố là bố đếm
										   -- ko care lặp
SELECT COUNT(City) FROM Employees --9

--5. Đếm xem có bao nhiêu Region
SELECT COUNT(Region) FROM Employees --5
--PHÁT HIỆN HÀM COUNT(CỘT), NẾU CELL CỦA CỘT CHỨA NULL, KO TÍNH, KO ĐẾM

--6. Đếm xem có bao nhiêu khu vực null, có bao nhiêu thằng null
SELECT COUNT(*) FROM Employees WHERE Region IS NULL --4, đếm sự xuất hiện của dòng chứa Region null

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL --0 NULL KO đếm được, ko value

--7 Có bao nhiêu thành phố trong table nhân viên
SELECT City FROM Employees --9
SELECT DISTINCT City FROM Employees--5
-- tui coi kết quả trên là 1 table, mất quá trời công sức để lọc ra 5 tp

--SUB QUERY MỚI, COI 1 CÂU SELECT LÀ 1 TABLE, BIẾN TABLE NÀY VÀO TRONG MỆNH ĐỀ FROM
--NGÁO
SELECT * FROM (SELECT DISTINCT City FROM Employees) AS Cities
SELECT COUNT(*) FROM (SELECT DISTINCT City FROM Employees) AS Cities --5
--Tại sao cần tên giả???
--ĐẢM BẢO QUY TẮC ĐỊNH DANH TABLE, CÂU LỆNH SELECT ĐƯỢC XEM NHƯ 1 BIỂU THỨC
--GIẢI THÍCH NGUYÊN TẮC FROM <TABLE>
-- KO CÓ THÌ MỐT KHÔNG CÓ CÁI THỂ THAM CHIẾU

SELECT COUNT(*) FROM Employees --9 NV
SELECT COUNT(City) FROM Employees --9 CITY

SELECT COUNT(DISTINCT City) FROM Employees --5 CITY

--8. Đếm xem MỖI thành phố có bao nhiêu nhân viên
--KHI CÂU HỎI CÓ TÍNH TOÁN GOM DATA (HÀM AGGREGATE) LẠI CHỨA TỪ KHOÁ MỖI...
--GẶP TỪ "MỖI", CHÍNH LÀ CHIA ĐỂ ĐẾM, CHIA ĐỂ TRỊ, CHIA ĐỂ GOM ĐẾM
SELECT * FROM Employees

--Seatle 2 | Tacoma 1 | Kirkland 1 | Redmond 1 | London 4 | 
-- Sự xuất hiện của nhóm
-- Đếm theo sự xh của nhóm, count++ trong nhóm hoy, sau đó reset ở nhóm mới
SELECT COUNT(City)FROM Employees GROUP BY City--ĐẾM VALUE CỦA CITY NHƯNG ĐẾM THEO NHÓM
											   --CHIA CITY THÀNH NHÓM, RỒI ĐẾM TRONG NHÓM
SELECT City, COUNT(City) AS [N of employees ]FROM Employees GROUP BY City, EmployeeID

SELECT EmployeeID, City, COUNT(City) AS [N of employees ]FROM Employees GROUP BY City, EmployeeID
--VÔ NGHĨA, CHIA NHÓM THEO KEY, MSSV VÔ NGHĨA



--CHỐT HẠ: KHIA XÀI HÀM GOM NHÓM, BẠN CÓ QUYỀN LIỆT KÊ TÊN CỘT LẺ Ở SELECT 
--		   NHƯNG CỘT LẺ ĐÓ BẮT BUỘC PHẢI XUẤT HIỆN TRONG MỆNH ĐỀ GROUP BY
--		   ĐỀ ĐẢM BẢO LOGIC: CỘT HIỂN THỊ | SỐ LƯỢNG ĐI KÈM, ĐẾM GOM THEO CỘT HIỂN THỊ MỚI LOGIC
-- CỨ THEO CỘT CITY MÀ GOM, CỘT CITY NẰM Ở SELECT HỢP LÍ
-- MUỐN HIỂN THỊ SỐ LƯỢNG CỦA AI ĐÓ, GÌ ĐÓ, GOM NHÓM THEO CÁI GÌ ĐÓ

-- NẾU BẠN GOM THEO KEY/PK, VÔ NGHĨA HENG, VÌ KEY HOK TRÙNG, MỖI THẰNG 1 NHÓM, ĐẾM CÁI GÌ???

-- MÃ SỐ SV --- ĐẾM CÁI GÌ??? VÔ NGHĨA
-- MÃ CHUYÊN NGÀNH -- ĐẾM SỐ SINH VIÊN THUỘC TỪNG CHUYÊN NGÀNH!!!
-- MÃ QUỐC GIA --- ĐẾM SỐ ĐƠN HÀNG
-- ĐIỂM THI --- ĐẾM SỐ LƯỢNG SV ĐẠT ĐC ĐIỂM ĐÓ
-- CÓ CỘT ĐỂ GOM NHÓM, CỘT ĐÓ SẼ DÙNG ĐỂ HIỂN THỊ SỐ LƯỢNG KẾT QUẢ

--IN RA MÃ NV
--1 London 1
--2 Seatle 1
--3        1
--4
--5


SELECT City, COUNT(City) AS [N of employees ]FROM Employees GROUP BY City

-- 9. HÃY CHO TUI BIẾT TP NÀO CÓ 2 NV TRỞ LÊN
-- 2 chặng làm
-- 9.1 Các thành phố có bao nhiêu nhân viên
-- 9.2 Đếm xông mỗi thành phố, ta bắt đầu lặp lại kết quả sau đếm
-- FILTER SAU ĐẾM, WHERE SAU ĐẾM, WHERE SAU KHI ĐÃ GOM NHÓM, AGGREGATE THÌ GỌI LÀ HAVING


SELECT City, COUNT(City) AS [N of employees ]FROM Employees GROUP BY City
SELECT City, COUNT(*) AS [N of employees ]FROM Employees GROUP BY City
															HAVING COUNT(*) >= 2
--10. Đếm số nhân viên của 2 thành phố Seattle và London
SELECT * FROM Employees
SELECT COUNT(*) FROM Employees WHERE City IN('Seattle', 'London') --6 đứa sai ròiiiiiii
SELECT COUNT(*) FROM Employees WHERE City IN('Seattle', 'London') GROUP BY City
SELECT City, COUNT(*) FROM Employees WHERE City IN('Seattle', 'London') GROUP BY City -- 2 4

--11. Trong 2 tp, tp noà có nhiều hơn 3 nv
SELECT City, COUNT(*) FROM Employees 
					  WHERE City IN('Seattle', 'London') 
					  GROUP BY City 
					  HAVING COUNT(*) >= 3

--12. Đếm xem có bao nhiêu đơn hàng đã bán ra
SELECT * FROM Orders
SELECT COUNT(*) AS [No Orders] FROM Orders --830 ĐẾM DÒNG
SELECT COUNT(OrderID) AS [No Orders] FROM Orders --830 ĐẾM GIÁ TRỊ
--830 mã đơn khác nhau, đếm mã đơn hay đếm cả đơn là như nhau
--nếu cột mà có value null thì vỡ mặt
--12.1 Nước Mỹ có bao nhiêu đơn hàng
--đi tìm Mĩ mà đếm, lọc mĩ rồi tính típ, where Mĩ
--KO PHẢI LÀ CÂU GOM CHIA NHÓM, HOK CÓ MỖI QUỐC GIA BAO NHIÊU ĐƠN,
-- MỖI QG BAO NHIÊU ĐƠN -> GROUP BY QUỐC GIA
SELECT COUNT(OrderID) AS [No USA orders] FROM Orders WHERE ShipCountry = 'USA' --122

--12.2 MỸ ANH PHÁP chiếm tổng cộng bao nhiêu đơn hàng
SELECT COUNT(OrderID) AS [No USA, France, UK Orders] FROM Orders 
													 WHERE ShipCountry IN ('USA', 'France', 'UK') --255 CHO CẢ 3

--12.3 mỸ ANH PHÁP, MỖI QUỐC GIA CÓ BAO NHIÊU ĐƠN HÀNG
SELECT ShipCountry, COUNT(OrderID) AS [No USA, France, UK Orders] 
								   FROM Orders 
								   WHERE ShipCountry IN ('USA', 'France', 'UK')
								   GROUP BY ShipCountry
--12.4 Trong 3 Quốc gia Anh PHáp Mỹ quốc gia nào có từ 100 đơn hàng trở lên
SELECT ShipCountry, COUNT(OrderID) AS [No Orders]
								   FROM Orders 
								   WHERE ShipCountry IN ('USA', 'France', 'UK')
								   GROUP BY ShipCountry
								   HAVING COUNT(OrderID) >= 100
--13. Đếm xem có bao nhiêu mặt hàng có trong kho
--14. Đếm xem có bao nhiêu lượt quốc gia đã mua hàng
--15. Đếm xem có bao nhiêu quốc gia đã mua hàng (mỗi quốc gia đếm 1 lần)
--16. Đếm số lượng đơn hàng của mỗi quốc gia
--17. Quốc gia nào có từ 10 đơn hàng trở lên
--18. Đếm xem mỗi chủng loại(loại hàng) có bao nhiêu mặt hàng
--19. Trong Anh Pháp Mỹ Quốc gia nào có nhiều đơn hàng nhất
--20. Thành phố nào có nhiều nhân viên nhất???
--21. Trong 3 quốc gia ANH PHÁP MỸ có nhiều đơn hàng nhất
