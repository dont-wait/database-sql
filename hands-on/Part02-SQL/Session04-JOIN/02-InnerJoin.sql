USE Cartesian
SELECT * FROM VnDict, EnDict -- tích Đề-các

SELECT * FROM VnDict CROSS JOIN EnDict -- tích Đề-các

SELECT * FROM VnDict vn, EnDict en --TÍCH ĐỀ-CÁC XONG THÌ FILTER LẠI
		 WHERE vn.Nmbr = en.Nmbr   --THỰC DỤNG, CỨ TÍCH ĐI RỒI T MỚI LẤY PHẦN CHUNG

SELECT * FROM VnDict, EnDict
				WHERE Nmbr = Nmbr --BỔI RỐI TÊN

SELECT * FROM VnDict, EnDict 
			WHERE VnDict.Nmbr = EnDict.Nmbr -- NÊN DÙNG ALIAS THÌ SẼ GIÚP NGẮN GỌN CÂU LỆNH

--CHUẨN THẾ GIỚI
SELECT * FROM VnDict INNER JOIN EnDict				--NHÌN SÂU VÀO TABLE RỒI GHÉP, KO GHÉP BỪA BÃI 
			         ON VnDict.Nmbr = EnDict.Nmbr	--GHÉP CÓ TƯƠNG QUAN BÊN TRONG, THEO ĐIỂM CHUNG

SELECT * FROM VnDict JOIN EnDict		
			         ON VnDict.Nmbr = EnDict.Nmbr
--CÓ THỂ DÙNG THÊM WHERE DC HAY KO??? KHI XÀI INNER, JOIN
--JOIN CHỈ LÀ THÊM DATA ĐỂ TÍNH TOÁN, GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TOÀN BỘ
--KIẾN THỨC SELECT ĐÃ HỌC

-- THÍ NGHIỆM THÊM CHO INNER JOIN, GHÉP NGANG XEM XÉT MÔN ĐĂNG HỘ ĐỐI HAY KO???
SELECT * FROM VnDict
SELECT * FROM EnDict

SELECT * FROM EnDict e, VnDict v
		 WHERE e.Nmbr > v.Nmbr				--GHÉP CÓ CHỌN LỌC, HOK XÀI DẤU =
--2Two 1Mot							        --MÀ DÙNG DẤU > >= < <= !=
--3Three 1Mot								--NON-EQUI JOIN		
--3Three 2Hai

SELECT * FROM EnDict e, VnDict v		-- THỰC DỤNG
		 WHERE e.Nmbr != v.Nmbr

SELECT * FROM EnDict e JOIN VnDict v	-- CHUẨN MỰC
		 ON e.Nmbr != v.Nmbr