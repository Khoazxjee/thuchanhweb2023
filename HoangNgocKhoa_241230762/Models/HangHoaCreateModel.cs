using System.ComponentModel.DataAnnotations;

namespace HoangNgocKhoa_241230762.Models;

public class HangHoaCreateModel
{
    [Range(1, int.MaxValue, ErrorMessage = "Hãy chọn loại hàng.")]
    public int MaLoai { get; set; }

    [Required(ErrorMessage = "Hãy nhập tên hàng.")]
    [StringLength(50, ErrorMessage = "Tên hàng tối đa 50 ký tự.")]
    public string TenHang { get; set; } = "";

    [Required(ErrorMessage = "Hãy nhập giá.")]
    [Range(typeof(decimal), "100", "5000",
        ErrorMessage = "Giá phải nằm trong khoảng 100 đến 5000.")]
    public decimal? Gia { get; set; }

    [Required(ErrorMessage = "Hãy nhập tên file ảnh.")]
    [StringLength(100)]
    [RegularExpression(@"^.+\.(jpg|png|gif|tiff)$",
        ErrorMessage = "Ảnh phải có đuôi .jpg, .png, .gif hoặc .tiff.")]
    public string Anh { get; set; } = "";
}
