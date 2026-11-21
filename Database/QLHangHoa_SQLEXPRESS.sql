USE master;
GO
IF DB_ID(N'QLHangHoa') IS NULL
    EXEC(N'CREATE DATABASE QLHangHoa');
GO
USE QLHangHoa;
GO

IF OBJECT_ID(N'dbo.LoaiHang', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.LoaiHang
    (
        MaLoai int IDENTITY(1,1) NOT NULL CONSTRAINT PK_LoaiHang PRIMARY KEY,
        TenLoai nvarchar(50) NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.HangHoa', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HangHoa
    (
        MaHang int IDENTITY(1,1) NOT NULL CONSTRAINT PK_HangHoa PRIMARY KEY,
        MaLoai int NOT NULL,
        TenHang nvarchar(50) NOT NULL,
        Gia numeric(18,0) NULL,
        Anh nvarchar(100) NULL,
        CONSTRAINT FK_HangHoa_LoaiHang FOREIGN KEY (MaLoai)
            REFERENCES dbo.LoaiHang(MaLoai)
    );
END;
GO

IF OBJECT_ID(N'dbo.tblAccount', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tblAccount
    (
        Uid int IDENTITY(1,1) NOT NULL CONSTRAINT PK_tblAccount PRIMARY KEY,
        Username nchar(10) NULL,
        Password nchar(10) NULL
    );
END;
GO

SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.LoaiHang ON;
INSERT INTO dbo.LoaiHang (MaLoai, TenLoai)
SELECT v.MaLoai, v.TenLoai
FROM (VALUES
    (1, N'Điện thoại'), (2, N'Máy tính'), (3, N'Ti vi'),
    (4, N'Tủ lạnh'), (5, N'Phụ kiện')
) AS v(MaLoai, TenLoai)
WHERE NOT EXISTS (SELECT 1 FROM dbo.LoaiHang AS l WHERE l.MaLoai = v.MaLoai);
SET IDENTITY_INSERT dbo.LoaiHang OFF;

SET IDENTITY_INSERT dbo.HangHoa ON;
INSERT INTO dbo.HangHoa (MaHang, MaLoai, TenHang, Gia, Anh)
SELECT v.MaHang, v.MaLoai, v.TenHang, v.Gia, v.Anh
FROM (VALUES
    (1, 1, N'Samsung J8', 1000, N'Img_1.jpg'),
    (2, 1, N'Iphone 8', 2000, N'Img_2.jpg'),
    (3, 1, N'Nokia 8', 1500, N'Img_3.jpg'),
    (4, 2, N'Dell xps', 2500, N'Img_4.jpg'),
    (5, 2, N'Sony SVT', 2000, N'Img_5.jpg'),
    (6, 3, N'Sony S1393', 1800, N'Img_6.jpg'),
    (7, 3, N'Hang moi', 1000, N'Img_1.jpg'),
    (8, 3, N'ghjk', 1500, N'Img_2.jpg'),
    (9, 1, N'Hang moi', 1200, N'Img_3.jpg'),
    (10, 1, N'xxxx', 1400, N'Img_4.jpg'),
    (16, 2, N'akjdf;lakj', 1200, N'Img_5.jpg'),
    (23, 5, N'Ốp điện thoại', 100, N'Img_1.jpg'),
    (24, 1, N'Hang moi', 150, N'img_2.jpg'),
    (25, 1, N'Honda', NULL, N'Img_1.jpg')
) AS v(MaHang, MaLoai, TenHang, Gia, Anh)
WHERE NOT EXISTS (SELECT 1 FROM dbo.HangHoa AS h WHERE h.MaHang = v.MaHang);
SET IDENTITY_INSERT dbo.HangHoa OFF;

SET IDENTITY_INSERT dbo.tblAccount ON;
INSERT INTO dbo.tblAccount (Uid, Username, Password)
SELECT v.Uid, v.Username, v.Password
FROM (VALUES (1, N'dzlm', N'123456'), (2, N'abc', N'123456')) AS v(Uid, Username, Password)
WHERE NOT EXISTS (SELECT 1 FROM dbo.tblAccount AS a WHERE a.Uid = v.Uid);
SET IDENTITY_INSERT dbo.tblAccount OFF;

COMMIT TRANSACTION;
GO
