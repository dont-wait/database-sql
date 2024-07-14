USE Cartesian

--1. Liệt kê cho tôi cấc cặp từ điển Anh-Việt
SELECT * FROM EnDict e, VnDict v 
		 WHERE e.Nmbr = v.Nmbr
		 --CÓ BẰNG CELL THÌ MỚI GHÉP
SELECT * FROM EnDict e INNER JOIN VnDict v
         ON e.Nmbr = v.Nmbr
		 --hãy ghép đi, trên cột này có cell/value này = cell/value bên kia
SELECT * FROM EnDict e JOIN VnDict v
         ON e.Nmbr = v.Nmbr
-- 3 câu tương đương kết quả

--2. Hụt mất của tui từ 4 -four và 5 năm ko thấy xuất hiện!!!
-- mún xh 4Four và 5Nam thì tích Đề-các
SELECT * FROM EnDict e, VnDict v

SELECT * FROM VnDict
SELECT * FROM EnDict

--3. Tui mún xh lấy tiếng Anh làm chuẩn, tìm các nghĩa tiếg Việt tương đương
-- Nếu ko có tương đương vẫn phải hiện ra
SELECT * FROM EnDict e LEFT JOIN VnDict v
         ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e LEFT OUTER JOIN VnDict v
         ON e.Nmbr = v.Nmbr

--4. Tui mún lấy tiếng Việt làm mốc
SELECT * FROM VnDict e LEFT OUTER JOIN EnDict v
         ON e.Nmbr = v.Nmbr

--Vẫn lấy TV làm đầu, nhưng mà lại để tiếng Việt bên tay phải cơ
SELECT * FROM EnDict e RIGHT JOIN VnDict v
         ON e.Nmbr = v.Nmbr

--5. Dù chung và riêng của mỗi bên, lấy tất, chấp nhận FA ở một vế
SELECT * FROM EnDict e FULL OUTER JOIN VnDict v
         ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e FULL JOIN VnDict v
         ON e.Nmbr = v.Nmbr

--FULL OUTER JOIN, THỨ TỰ TABLE KO QUAN TRỌNG, VIẾT TRƯỚC SAU ĐỀU ĐƯỢC
--LEFT, RIGHT JOIN THỨ TỰ TABLE LÀ CÓ CHUYỆN KHÁC NHAU

SELECT * FROM EnDict e LEFT JOIN VnDict v
		 ON e.Nmbr = v.Nmbr		--SHOW 4 NULL

SELECT * FROM  VnDict v LEFT JOIN EnDict e
		 ON e.Nmbr = v.Nmbr		--SHOW 5 Năm

-- OUTER JOIN SINH RA ĐỂ ĐẢM BẢO VIỆC KẾT NỐI GHÉP BẢNG
-- KO BỊ MẤT MÁT DATA!!!
-- DO INNER JOIN, JOIN = CHỈ TÌM CÁI CHUNG  2 BÊN

-- SAU KHI TÌM RA ĐƯỢC DATA CHUNG RIÊNG, TA CÓ QUYỀN FILTER TIẾP
-- CELL NÀO ĐÓ, WHERE NHƯ BÌNH THƯỜNG

--6. In ra bộ từ điển Anh Việt (Anh làm chuẩn) của những con số
-- từ 3 trở lên
SELECT * FROM EnDict e LEFT JOIN VnDict v
		 ON e.Nmbr = v.Nmbr
		 WHERE e.Nmbr >= 3

--7. In ra bộ từ điển Anh Việt VIỆT ANH(Anh làm chuẩn) của những con số
-- từ 3 trở lên
SELECT * FROM EnDict e FULL JOIN VnDict v
		 ON e.Nmbr = v.Nmbr
		 WHERE e.Nmbr >= 3 -- toang, mất mẹ nó số 5 của VN:D
SELECT * FROM EnDict e FULL JOIN VnDict v
		 ON e.Nmbr = v.Nmbr
		 WHERE v.Nmbr >= 3 --có 5 mất 4

SELECT * FROM EnDict e FULL JOIN VnDict v
		 ON e.Nmbr = v.Nmbr
		 WHERE v.Nmbr >= 3 OR e.Nmbr >= 3