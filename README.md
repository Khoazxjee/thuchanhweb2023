# HoangNgocKhoa_241230762

Bài làm theo đề mẫu Lập trình Web 2023, dùng ASP.NET Core MVC (.NET 8), Entity Framework Core Database First và SQL Server Express.

## Mở và chạy bài

1. Mở `HoangNgocKhoa_241230762.sln` bằng Visual Studio hỗ trợ .NET 8. Visual Studio 2026 cũng có thể mở file `.slnx` cùng tên.
2. Kết nối SSMS đến `localhost\SQLEXPRESS` bằng Windows Authentication.
3. Database của bài là `QLHangHoa`. Trên máy hiện tại database đã được tạo với dữ liệu mẫu của đề.
4. Chọn project `HoangNgocKhoa_241230762` làm Startup Project, chọn profile **http**, nhấn **Ctrl + F5**.
5. Nếu trình duyệt không tự mở, truy cập `http://localhost:5238`.

Các gói EF Core SqlServer, Design và Tools 8.0.33 đã được tham chiếu trong project. Các model và DbContext đã được sinh từ database; không cần scaffold lại để chạy bài.

Nếu chuyển máy, chạy [Database/QLHangHoa_SQLEXPRESS.sql](Database/QLHangHoa_SQLEXPRESS.sql) trong SSMS rồi kiểm tra tên server tại `HoangNgocKhoa_241230762/appsettings.json`. Script giữ schema và dữ liệu mẫu, kiểm tra trước khi tạo/chèn, không xóa database. Script không tự chuyển đổi một database đã có cấu trúc khác.

## Phần bài làm

| Yêu cầu | File hoặc vị trí thực hiện |
|---|---|
| Project theo HoTen_MaSV | HoangNgocKhoa_241230762 |
| Tách Layout, Header, Footer, MainContent theo họ tên | Views/Shared/HoangNgocKhoa_*.cshtml |
| Ghép các phần giao diện | Layout gọi Header/Footer và RenderBody; Index render MainContent |
| CSS, ảnh, font và JavaScript của template | wwwroot/Content và wwwroot/Script |
| Entity Framework Database First | Models/HangHoa.cs, LoaiHang.cs, tblAccount.cs, QLHangHoaContext.cs |
| Menu lấy từ LoaiHang, Home là họ tên | HomeController.NapLoaiHang và HoangNgocKhoa_Header |
| Danh sách hàng có Gia >= 100, tiêu đề là họ tên | HomeController.LayHangHoa và HoangNgocKhoa_MainContent |
| Lọc theo loại bằng AJAX | LocTheoLoai và Views/Home/Index.cshtml |
| Thêm hàng và lưu database | HomeController.Create và Views/Home/Create.cshtml |
| Annotations kiểm tra giá, đuôi ảnh | Models/HangHoaCreateModel.cs |

Họ tên trên giao diện là **Hoàng Ngọc Khoa**, mã sinh viên **241230762**.

Form nhận giá là số từ **100 đến 5000**, gồm cả hai giá biên. Trường ảnh nhập tên file có đuôi **.jpg, .png, .gif hoặc .tiff**, ví dụ `Img_1.jpg`. Muốn hiển thị ảnh, file đó cần có trong `wwwroot/Content/images`. TIFF hợp lệ theo đề nhưng có thể không được trình duyệt hiển thị trực tiếp.

Tên hàng bắt buộc, tối đa 50 ký tự theo cột database. MaHang là IDENTITY, SQL Server tự cấp mã khi thêm. Thêm hợp lệ sẽ lưu bằng SaveChangesAsync và trở về danh sách.

Với dữ liệu ban đầu, trang chủ hiển thị **13 hàng hóa**. Khi chọn loại: Điện thoại 6, Máy tính 3, Ti vi 3, Tủ lạnh 0, Phụ kiện 1. Hàng Honda có giá NULL không hiển thị. Tiêu đề vẫn là họ tên sinh viên.

Các mục giỏ hàng, tìm kiếm và liên kết trong footer giữ giao diện template. Bài chỉ triển khai các chức năng của đề; không có đăng nhập, giỏ hàng, sửa, xóa hoặc upload ảnh.

## Tự kiểm tra trước khi nộp

- Build solution thành công.
- Trang chủ có đủ menu, CSS, ảnh và tên sinh viên.
- Bấm từng loại đổi danh sách bằng AJAX, không tải lại toàn trang.
- Form sai giá, đuôi ảnh hoặc tên hàng có thông báo và không lưu.
- Thêm hàng hợp lệ lưu được vào bảng HangHoa.
- Nộp video ghi quá trình thực hiện riêng theo yêu cầu giảng viên.

Xem [hướng dẫn chi tiết bài 2023](https://github.com/Khoazxjee/huong-dan-tkw-2023) để hiểu từng file và cách tách layout từ template.

Template Home Shoppe lấy từ bộ tài nguyên được cung cấp. CSS gốc ghi tác giả W3layouts và giấy phép CC BY 3.0; giữ các thông tin đó trong tài nguyên.

## Kết quả kiểm tra

- Build Release: 0 lỗi, 0 cảnh báo.
- 42 kiểm tra trên Chrome: giao diện, ảnh, menu, AJAX, dropdown và validation.
- 104 kiểm tra HTTP: danh sách, partial, tài nguyên, 13 trường hợp form sai, lưu thật bốn đuôi ảnh hợp lệ và giá biên 100/5000.
- Các phép thử thêm dữ liệu chạy trên database tạm riêng. Database QLHangHoa của bài giữ nguyên 5 loại, 14 hàng hóa, 2 tài khoản mẫu.
- Chạy bằng profile http và appsettings.json thật: trang chủ trả HTTP 200, hiển thị 13 hàng hóa.

File ZIP bài nộp chứa solution, project, mã nguồn, tài nguyên, SQL và README; không chứa bin, obj hoặc các chương trình kiểm tra.
