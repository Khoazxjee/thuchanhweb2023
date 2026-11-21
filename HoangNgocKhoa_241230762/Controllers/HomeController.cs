using HoangNgocKhoa_241230762.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace HoangNgocKhoa_241230762.Controllers;

public class HomeController : Controller
{
    private readonly QLHangHoaContext _db;

    public HomeController(QLHangHoaContext db)
    {
        _db = db;
    }

    private async Task NapLoaiHang()
    {
        var danhSach = await _db.LoaiHang
            .AsNoTracking().OrderBy(x => x.MaLoai).ToListAsync();
        ViewBag.DanhSachLoai = danhSach;
        ViewBag.MaLoai = new SelectList(danhSach, "MaLoai", "TenLoai");
    }

    private IQueryable<HangHoa> LayHangHoa(int? maLoai)
    {
        var query = _db.HangHoa.AsNoTracking().Where(x => x.Gia >= 100);
        if (maLoai.HasValue)
        {
            query = query.Where(x => x.MaLoai == maLoai.Value);
        }
        return query.OrderBy(x => x.MaHang);
    }

    private async Task<bool> LoaiHopLe(int? maLoai)
    {
        return !maLoai.HasValue || await _db.LoaiHang.AnyAsync(x => x.MaLoai == maLoai);
    }

    [HttpGet]
    public async Task<IActionResult> Index(int? maLoai)
    {
        if (!await LoaiHopLe(maLoai))
        {
            return NotFound();
        }

        await NapLoaiHang();
        ViewBag.MaLoaiDangChon = maLoai;
        return View(await LayHangHoa(maLoai).ToListAsync());
    }

    [HttpGet]
    public async Task<IActionResult> LocTheoLoai(int? maLoai)
    {
        if (!await LoaiHopLe(maLoai))
        {
            return NotFound();
        }

        var danhSach = await LayHangHoa(maLoai).ToListAsync();
        return PartialView("HoangNgocKhoa_MainContent", danhSach);
    }

    [HttpGet]
    public async Task<IActionResult> Create()
    {
        await NapLoaiHang();
        return View(new HangHoaCreateModel());
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(HangHoaCreateModel model)
    {
        if (!await _db.LoaiHang.AnyAsync(x => x.MaLoai == model.MaLoai))
        {
            ModelState.AddModelError(nameof(model.MaLoai), "Loại hàng không tồn tại.");
        }

        if (!ModelState.IsValid)
        {
            await NapLoaiHang();
            return View(model);
        }

        var hang = new HangHoa
        {
            MaLoai = model.MaLoai,
            TenHang = model.TenHang.Trim(),
            Gia = model.Gia,
            Anh = model.Anh.Trim()
        };
        _db.HangHoa.Add(hang);
        await _db.SaveChangesAsync();
        return RedirectToAction(nameof(Index));
    }
}
