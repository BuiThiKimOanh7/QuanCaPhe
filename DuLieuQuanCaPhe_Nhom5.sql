use master 
go 
create database DuLieuQuanCaPhe
go
use DuLieuQuanCaPhe
go 
create table QuanCafe
(
Idquan varchar(20) primary key,
SDT nvarchar(20),
DiaChiQuan nvarchar(200) not null,
NgayBatDau date,
Trangthai bit default 1,
GhiChu nvarchar(250)
)
go
create table CaLamNhanVien
(
MaCa nvarchar(10)  primary key ,
CaLam nvarchar(50) ,
GhiChu nvarchar(250),
)
go 
 CREATE TABLE ChucVuNhanVien
 (
 IDChucVu varchar(10) primary key ,
TenChucVu nvarchar(30) NULL,
MoTa nvarchar(250) NULL,
)
create table NhanVien
(
IDNhanVien varchar(10) primary key ,
HoTen nvarchar(30)  not null,
GioiTinh nvarchar(10),
NgaySinh date ,
DiaChi nvarchar(50),
SDT varchar(20),
Cmnd varchar(30),
Anh nvarchar(255),
IDChucVu varchar(10),
Email varchar(50),
MaCa nvarchar(10),
NgayVaoLam date default getdate(),
GhiChu nvarchar(250), 
constraint fk_MaCaNhanVien 
foreign key (MaCa)
references CaLamNhanVien(MaCa),
 constraint fk_ChucVuNhanVien 
foreign key (IDChucVu)
references ChucVuNhanVien(IDChucVu)
)
go 
create table QuyenUser 
(
IDQuyen int primary key identity(1,1),
TenQuyen nvarchar(30) unique not null ,
MoTa nvarchar(250),
QuanLiUser bit default 0,
QuanLiSanPham bit default 0,
QuanLiKhachHang bit default 0,
QuanLiNhanVien  bit default 0,
QuanLiHoaDon bit default 0,
QuanLiUuDaiSanPham bit default 0,
QuanLiUuDaiKhachHang bit default 0,
QuanLiUuDaiHoaDon bit default 0,
QuanLiBanHang bit default 0,
QuanLiPhieuChi bit default 0,
QuanLiBienBan bit default 0,
ThongKe bit default 0
)
go
create table QLUser
(
IDDangNhap int primary key identity(1,1),
TenDangNhap varchar(50) not null unique,
MatKhau varchar(50) not null ,
IDChucVu varchar(10),
TrangThai bit not null  default 1 ,
IDQuyen int ,
GhiChu varchar(250),
constraint fk_tendangnhap 
foreign key(IDDangNhap )
references QLUser(IDDangNhap),
constraint fk_ChucVuNhanVien1 
foreign key (IDChucVu)
references ChucVuNhanVien(IDChucVu)
)
go
alter table QLUser
add constraint check_TenDangNhap check(isnumeric(substring(TenDangNhap,1,2))=0)
go 
create table KhachHang
(
SDTKH varchar(30)  primary key,
Hoten nvarchar(30),
GioiTinh nvarchar(10), 
DiaChi nvarchar(50),
SoLanSuDungDV int default 0,
ThoiGian date default getdate(),
GhiChu nvarchar(250)
)
go
create table UuDaiSanPham
(
IDUDSP int primary key identity(1,1),
TenUDSP nvarchar(30) unique not null,
SoPhanTramGiam int not null, 
NgayBD datetime not null default getdate(),
NgayKT datetime not null default getdate(), 
GhiChu nvarchar(250)
)
go
alter table UuDaiSanPham
add constraint check_NgayUuDaiSp check(NgayKT>NgayBD)

go
create table UuDaiHoaDon 
(
IDUDHD  int primary key identity(1,1),
TenUDHD nvarchar(30) unique not null,
SoTien decimal(18,2) not null,
SoPhanTramGiam int not null, 

NgayBD datetime not null default getdate(),
NgayKT datetime not null default getdate(), 
GhiChu nvarchar(250)
)
go
alter table UuDaiHoaDon
add constraint check_NgayUuDaiHD check(NgayKT>NgayBD)
go
create table UuDaiKhachHang 
(
IDUDKH int primary key identity(1,1),
TenUDKH nvarchar(30) unique not null,
SoLanKHSDDV int not null, 
SoPhanTramGiam int not null, 
NgayBD datetime not null default getdate(),
NgayKT datetime not null default getdate(),
GhiChu nvarchar(250)
)
go
alter table UuDaiKhachHang
add constraint check_NgayUuDaiKH check(NgayKT>NgayBD)
go 
create table DanhMuc
(
IDDanhMuc int primary key identity(1,1),
TenDanhMuc nvarchar(30) unique not null ,
MoTa nvarchar(max), 
)

go 
create table SanPham
(
IDSanPham varchar(20) primary key,
TenSanPham nvarchar(30) unique not null,
GiaTien money not null,
AnhSanPham varchar(50),
IDUDSP int,
TrangThai bit not null default 1,
GhiChu nvarchar(50),
constraint fk_idudsp
foreign key(IDUDSP)
references UuDaiSanPham(IDUDSP)
)
go 
create table DanhMuc_SanPham
(
IDDanhMuc int,
IDSanPham varchar(20),
constraint pk_DanhMuc_SanPham
PRIMARY KEY (IDDanhMuc, IDSanPham),
constraint fk_IDSanPhamDM_SP
foreign key(IDSanPham )
references SanPham(IDSanPham),
constraint fk_IDDanhMucDM_SP
foreign key(IDDanhMuc)
references DanhMuc(IDDanhMuc)
)
go
create table HoaDon
(
OrderID int primary key identity(1,1),
SDTKH varchar(30) , 
GiaTien money not null,
ThoiGian datetime default getdate(),
PTThanhToan nvarchar(30) , 
IDUDHD int,
IDUDKH int,
Thue int default 10,
GhiChu nvarchar(250),
constraint fk_idkhachhanghd 
foreign key(SDTKH)
references KhachHang(SDTKH),
constraint fk_idudhd1  
foreign key(IDUDHD)
references UuDaiHoaDon(IDUDHD),
constraint fk_idudhd 
foreign key(IDUDKH)
references UuDaiKhachHang(IDUDKH)
)
go 
create table ChiTietHoadon
(
OrderID int , 
IDSanPham varchar(20) ,
SoLuong int,
GhiChu nvarchar(250),
constraint pk_ChiTietHoaDon 
primary key(OrderID,IDSanPham),
constraint fk_OrderID
foreign key (OrderID)
references HoaDon(OrderID),
constraint fk_IDSanPhamCTHD 
foreign key (IDSanPham)
references SanPham(IDSanPham)
)
go 
create table HoaDonTam
(
OrderID int primary key identity(1,1),
SDTKH varchar(30) , 
GiaTien money not null,
ThoiGian datetime default getdate(),
PTThanhToan nvarchar(30) , 
IDUDHD int,
IDUDKH int,
Thue int default 10,
GhiChu nvarchar(250),
constraint fk_idkhachhanghdTam 
foreign key(SDTKH)
references KhachHang(SDTKH),
constraint fk_idudhd1Tam  
foreign key(IDUDHD)
references UuDaiHoaDon(IDUDHD),
constraint fk_idudhdTam
foreign key(IDUDKH)
references UuDaiKhachHang(IDUDKH)
)
go 
create table ChiTietHoadonTam
(
OrderID int , 
IDSanPham varchar(20) ,
SoLuong int,
GhiChu nvarchar(250),
constraint pk_ChiTietHoaDonTam 
primary key(OrderID,IDSanPham),
constraint fk_OrderIDTam
foreign key (OrderID)
references HoaDonTam(OrderID),
constraint fk_IDSanPhamCTHDTam
foreign key (IDSanPham)
references SanPham(IDSanPham)
)
go 
create table BienBanNhanVien 
(
IDBienBanNV int primary key identity(1,1),
TenBBNV nvarchar(50) not null ,
IDNhanVien varchar(10) ,
NgayViPham date default getdate(),
LoiViPham nvarchar(50) not null , 
GhiChu nvarchar(250),
constraint fk_IDNhanVienBBNV 
foreign key (IDNhanVien)
references NhanVien(IDNhanVien)
)
go 
create table PhieuChi 
(
IDPhieuChi int primary key identity(1,1), 
TenPhieChi nvarchar(50),
SDTKH varchar(30),
LiDo nvarchar(max) not null ,
SoTien money not null , 
Ngay Date default getdate(), 
GhiChu nvarchar(250),
constraint fk_IDKhachHang  
foreign key (SDTKH)
references KhachHang(SDTKH)
)
go 
if object_id('Get5Product') IS NOT NULL
     drop proc Get5Product
go    
 create proc Get5Product( @fromDate date, @toDate date)
as
begin 
  set nocount on 
  set dateformat dmy 
  declare @BangKQ table (
    TenSanPham nvarchar(100),
    Q int
  )
  insert into @BangKQ (TenSanPham, Q)
  select top 5 s.TenSanPham, sum(c.SoLuong) as Q
  from ChiTietHoadon c 
  inner join SanPham s on s.IDSanPham = c.IDSanPham
  inner join HoaDon h on h.OrderID = c.OrderID
  where h.ThoiGian between @fromDate and @toDate
  group by s.TenSanPham
  order by Q desc 
  select * from @BangKQ
end
go
USE [DuLieuQuanCaPhe]
GO
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'chieutoi', N'Ca chiều đến ca tối', N'15h-23h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'full', N'Cả ngày', N'7h - 23h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'sang', N'Ca sáng', N'7h - 11h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'sang_chieu', N'Ca sáng đếnn ca chiều', N'7h - 19h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'sangtrua', N'Ca sáng và ca trưa', N'7h - 15h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'toi', N'Ca tối', N'19h - 23h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'trua_toi', N'Ca trưa đến ca tối', N'11h - 23h')
INSERT [dbo].[CaLamNhanVien] ([MaCa], [CaLam], [GhiChu]) VALUES (N'truachieu', N'Ca trưa và ca chiều', N'11h - 19h')
GO
INSERT [dbo].[ChucVuNhanVien] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'ChuQuan', N'Chủ Quán ', N'Quản lí cửa hàng ')
INSERT [dbo].[ChucVuNhanVien] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'NhanVien', N'Nhân viên', N'Thực hiện đưa món ra bàn')
INSERT [dbo].[ChucVuNhanVien] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'QuanLy', N'Quản Lý ', N'Thực hiện quản lí cửa hàng ')
INSERT [dbo].[ChucVuNhanVien] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'ThuNgan', N'Thu ngân ', N'Thực hiện thanh toán hóa đơn cho khách hàng ')
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV1', N'Ngô Thị Khuê', N'Nữ', CAST(N'2023-03-16' AS Date), N'Địa chỉ', N'0897451127', N'125489647523', N'empyee3.png', N'NhanVien', NULL, N'sang', CAST(N'2023-03-16' AS Date), N'')
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV10', N'Thái Thị Huyền Trang', N'Nữ', CAST(N'2005-06-03' AS Date), N'HCM', N'0746952315', N'458554236962', N'employee2.jpg', N'NhanVien', N'huyentrang123@gmail.com', N'chieutoi', CAST(N'2021-10-01' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV11', N'Võ Thị Diễm My', N'Nữ', CAST(N'2004-05-09' AS Date), N'HCM', N'0635567786', N'597412254689', N'employee4.jpg', N'NhanVien', N'diemmy0905@gmail.com', N'toi', CAST(N'2022-03-01' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV2', N'Lê Ngọc Thắm', N'Nữ', CAST(N'2002-06-04' AS Date), N'HCM', N'0426764238', N'268459226', N'employee4.jpg', N'NhanVien', N'LeNgocTham@gmail.com', N'sang', CAST(N'2022-04-30' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV3', N'Bùi Văn Thành', N'Nam', CAST(N'2004-07-03' AS Date), N'HCM', N'0757469235', N'236778521', N'employee1.jpg', N'NhanVien', N'Thanh123@gmail.com', N'sang', CAST(N'2023-01-15' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV4', N'Đỗ Thị Kim Chi', N'Nữ', CAST(N'2001-06-11' AS Date), N'HCM', N'0888359251', N'568995412', N'employee2.jpg', N'NhanVien', N'ChiDo@gmail.com', N'sangtrua', CAST(N'2022-05-09' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV5', N'Nguyễn Thị Kim Ngân', N'Nữ', CAST(N'2003-10-09' AS Date), N'HCM', N'0632567786', N'569541236', N'employee4.jpg', N'NhanVien', N'NganNguyen@gmail.com', N'sang_chieu', CAST(N'2022-12-14' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV6', N'Lê Thị Phương Thảo', N'Nữ', CAST(N'2002-05-16' AS Date), N'HCM', N'0469523754', N'597568542111', N'empyee3.png', N'NhanVien', N'Thao1605@gmail.com', NULL, CAST(N'2022-06-16' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV7', N'Trương Văn Ninh', N'Nam', CAST(N'2004-11-29' AS Date), N'HCM', N'0794635125', N'756235985425', N'employee4.jpg', N'NhanVien', N'NinhTruongVan@gmail.com', N'truachieu', CAST(N'2022-04-14' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV8', N'Nguyễn Văn Mạnh', N'Nam', CAST(N'2001-06-12' AS Date), N'HCM', N'0846952261', N'456895235', N'employee1.jpg', N'NhanVien', N'VanManh@gmail.com', N'trua_toi', CAST(N'2021-05-30' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'NV9', N'Phan Thị Tuyết Loan', N'Nữ', CAST(N'1999-12-11' AS Date), N'HCM', N'0897454127', N'653692158745', N'employee2.jpg', N'NhanVien', N'Loan1112@gmail.com', NULL, CAST(N'2022-10-14' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'QL1', N'Lê Ngọc Bích', N'Nữ', CAST(N'1994-09-05' AS Date), N'HCM', N'0489764238', N'688523524', N'employee4.jpg', N'QuanLy', N'bichngoc1994@gmail.com', N'full', CAST(N'2019-01-14' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'QL2', N'Vũ Thị Thu Hương', N'Nữ', CAST(N'1996-04-05' AS Date), N'HCM', N'0937582468', N'236489563', N'empyee3.png', N'QuanLy', N'thuhuong@gmail.com', N'sangtrua', CAST(N'2021-07-15' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'QL3', N'Hồ Trọng Duy', N'Nam', CAST(N'1994-05-10' AS Date), N'HCM', N'0667489537', N'264589652188', N'employee1.jpg', N'QuanLy', N'duy1994@gmail.com', N'full', CAST(N'2022-05-28' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'QL4', N'Đặng Văn Sơn', N'Nam', CAST(N'1997-12-07' AS Date), N'HCM', N'0495554111', N'265458962352', N'employee4.jpg', N'QuanLy', N'son712@gmail.com', N'trua_toi', CAST(N'2021-08-14' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'QL5', N'Trần Văn Vượng', N'Nam', CAST(N'2022-10-03' AS Date), N'Địa chỉ', N'0489371444', N'689534256', NULL, N'ChuQuan', NULL, N'full', CAST(N'2023-03-16' AS Date), N'')
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'TN1', N'Cao Đức Cường', N'Nam', CAST(N'2002-11-07' AS Date), N'HCM', N'0746953356', N'768549856', N'employee2.jpg', N'ThuNgan', N'caoduccuong@gmail.com', N'sangtrua', CAST(N'2023-04-16' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'TN2', N'Võ Gia Hân', N'Nữ', CAST(N'1999-06-08' AS Date), N'HCM', N'0489371456', N'635895412', N'employee2.jpg', N'ThuNgan', N'vogiahan@gmail.com', N'chieutoi', CAST(N'2022-11-15' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'TN3', N'Trần Ngọc Quế', N'Nữ', CAST(N'1998-09-07' AS Date), N'HCM', N'0497554112', N'125487675', N'empyee3.png', N'ThuNgan', N'ngocque@gmail.com', N'full', CAST(N'2021-09-10' AS Date), NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTen], [GioiTinh], [NgaySinh], [DiaChi], [SDT], [Cmnd], [Anh], [IDChucVu], [Email], [MaCa], [NgayVaoLam], [GhiChu]) VALUES (N'TN4', N'Tô Nữ Huyền Trinh', N'Nữ ', CAST(N'2000-09-10' AS Date), N'HCM', N'0471548892', N'478953557', N'employee1.jpg', N'ThuNgan', N'vogiahan@gmail.com', N'full', CAST(N'2023-01-15' AS Date), NULL)
GO
SET IDENTITY_INSERT [dbo].[QLUser] ON 

INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (1, N'ChuQuan', N'1241ef445797564ce44f77913ab8146a', N'QuanLy', 1, 1, N'hico')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (2, N'QuanLi1', N'd3150a4c75fdb9f5d6e7edaae4c4f608', N'QuanLy', 1, 0, N'ql1')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (3, N'NhanVien1', N'b81fbabe373a8a0a80df5da5602e702e', N'ThuNgan', 1, 0, N'nv1')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (5, N'NhanVien2', N'30ad3d7bd534c1131f298bad4513b177', N'NhanVien', 1, 1, N'nv2')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (6, N'QuanLi2', N'843af659ec9e32eda9eeabfefd849c3d', N'QuanLy', 1, 1, N'ql2')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (10, N'NhanVien3', N'b05711d9019c314ada2f9a6213407989', N'ThuNgan', 1, 1, N'nv3')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (11, N'NhanVien4', N'faad049ab8be3994e5fb35081a2db139', N'NhanVien', 1, 0, N'nv4')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (13, N'NhanVien5', N'a2dde742d683ce6f9c1aba8d14e9d7d4', N'NhanVien', 1, 1, N'nv5')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (14, N'NhanVien6', N'99d93d38beb422b132842360276d58a5', N'NhanVien', 1, 1, N'nv6')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (15, N'NhanVien7', N'a541ade7c784e73e5812f7d13657736b', N'ThuNgan', 1, 1, N'nv7')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (16, N'NhanVien8', N'e3450ff3f1e7cfbc53374d65fc63d173', N'NhanVien', 1, 0, N'nv8')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (18, N'NhanVien9', N'517f1314d696d08d2b6f2cb9fe0832ed', N'ThuNgan', 1, 1, N'nv9')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (19, N'NhanVien10', N'34bc69df9ecd2b71ec219ad2f20c4162', N'NhanVien', 1, 0, N'nv10')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (20, N'QuanLi3', N'fbec5efcb7642dfeaae8372d472cbd7f', N'QuanLy', 1, 0, N'ql3')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (21, N'QuanLi4', N'09f7e4db9ed3baf91dc6e9e17f0fb80b', N'QuanLy', 1, 1, N'ql4')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (22, N'QuanLi5', N'e89424490866dd7760d87a8e8954df67', N'QuanLy', 1, 0, N'ql5')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (24, N'NhanVien11', N'8fd04cde7e1d9edd880d07e8235e281a', N'NhanVien', 1, 1, N'nv11')
INSERT [dbo].[QLUser] ([IDDangNhap], [TenDangNhap], [MatKhau], [IDChucVu], [TrangThai], [IDQuyen], [GhiChu]) VALUES (25, N'ahihi', N'202cb962ac59075b964b07152d234b70', N'ChuQuan', 0, 1, N'')
SET IDENTITY_INSERT [dbo].[QLUser] OFF
GO
SET IDENTITY_INSERT [dbo].[BienBanNhanVien] ON 

INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (1, N'ViPhamNoiQui1', N'NV3', CAST(N'2023-04-16' AS Date), N'Đi trễ', N'abc')
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (2, N'ViPhamNoiQui2', N'NV8', CAST(N'2023-03-07' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (5, N'ViPhamNoiQui3', N'NV5', CAST(N'2023-04-06' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (6, N'ViPhamNoiQui4', N'NV1', CAST(N'2023-04-10' AS Date), N'Sai đồng phục', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (9, N'ViPhamNoiQui1', N'NV2', CAST(N'2023-04-16' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (10, N'ViPhamNoiQui2', N'NV4', CAST(N'2023-03-02' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (12, N'ViPhamNoiQui2', N'NV7', CAST(N'2023-04-07' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (13, N'ViPhamNoiQui3', N'NV9', CAST(N'2023-04-10' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (15, N'ViPhamNoiQui3', N'NV8', CAST(N'2023-04-11' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (17, N'ViPhamNoiQui4', N'NV3', CAST(N'2023-04-15' AS Date), N'Sai đồng phục', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (18, N'ViPhamNoiQui3', N'NV2', CAST(N'2023-03-09' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (20, N'ViPhamNoiQui1', N'NV10', CAST(N'2023-03-04' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (22, N'ViPhamNoiQui2', N'NV11', CAST(N'2023-03-28' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (23, N'ViPhamNoiQui3', N'NV6', CAST(N'2023-03-17' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (24, N'ViPhamNoiQui4', N'NV4', CAST(N'2023-03-20' AS Date), N'Sai đồng phục', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (25, N'ViPhamNoiQui3', N'NV1', CAST(N'2023-04-06' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (26, N'ViPhamNoiQui1', N'NV3', CAST(N'2023-04-04' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (27, N'ViPhamNoiQui1', N'NV4', CAST(N'2023-03-19' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (28, N'ViPhamNoiQui2', N'NV5', CAST(N'2023-04-16' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (29, N'ViPhamNoiQui4', N'NV9', CAST(N'2023-04-02' AS Date), N'Sai đồng phục', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (30, N'ViPhamNoiQui2', N'NV1', CAST(N'2023-03-01' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (31, N'ViPhamNoiQui3', N'NV11', CAST(N'2023-02-27' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (32, N'ViPhamNoiQui1', N'NV9', CAST(N'2023-02-09' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (33, N'ViPhamNoiQui2', N'NV4', CAST(N'2023-02-16' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (34, N'ViPhamNoiQui2', N'NV7', CAST(N'2023-02-08' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (35, N'ViPhamNoiQui4', N'NV11', CAST(N'2023-02-22' AS Date), N'Sai đồng phục', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (36, N'ViPhamNoiQui3', N'NV4', CAST(N'2023-02-24' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (39, N'ViPhamNoiQui3', N'NV9', CAST(N'2023-02-11' AS Date), N'Bể ly', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (40, N'ViPhamNoiQui1', N'NV6', CAST(N'2023-02-09' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (41, N'ViPhamNoiQui2', N'NV7', CAST(N'2023-04-07' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (43, N'ViPhamNoiQui2', N'NV3', CAST(N'2023-03-13' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (44, N'ViPhamNoiQui1', N'NV10', CAST(N'2023-03-03' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (45, N'ViPhamNoiQui2', N'NV9', CAST(N'2023-03-08' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (47, N'ViPhamNoiQui4', N'NV6', CAST(N'2023-02-02' AS Date), N'Sai đồng phục', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (49, N'ViPhamNoiQui2', N'NV11', CAST(N'2023-04-05' AS Date), N'Order sai', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (50, N'ViPhamNoiQui1', N'NV8', CAST(N'2023-03-18' AS Date), N'Đi trễ', NULL)
INSERT [dbo].[BienBanNhanVien] ([IDBienBanNV], [TenBBNV], [IDNhanVien], [NgayViPham], [LoiViPham], [GhiChu]) VALUES (51, N'ViPhamNoiQui1', N'NV7', CAST(N'2023-04-26' AS Date), N'jhgf', N'')
SET IDENTITY_INSERT [dbo].[BienBanNhanVien] OFF
GO
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0123659621', N'Trương Văn Phát', N'Nữ', N'', 9, CAST(N'2023-04-16' AS Date), N'')
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0246879439', NULL, NULL, NULL, 14, CAST(N'2023-04-16' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0255878645', NULL, NULL, NULL, 5, CAST(N'2023-04-05' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0346851548', N'Phan Thị Thu Hà', N'Nữ', NULL, 4, CAST(N'2023-04-03' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0375942757', NULL, NULL, NULL, 2, CAST(N'2023-04-09' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0452457127', N'Thái Thị Mai', N'Nữ', NULL, 54, CAST(N'2023-04-10' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0454587878', N'Lê Minh Anh', N'Nữ', NULL, 62, CAST(N'2023-04-15' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0456456841', NULL, NULL, NULL, 11, CAST(N'2023-04-12' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0456846176', N'Phạm Văn Khương', N'Nam', NULL, 7, CAST(N'2023-04-13' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0546846566', N'Đỗ Thị Hương', N'Nữ', NULL, 67, CAST(N'2023-04-14' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0547857855', N'Lê Ngọc Minh Châu', N'Nữ', NULL, 87, CAST(N'2023-03-17' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0634896972', N'Nguyễn Thị Thanh Hà', N'Nữ', NULL, 89, CAST(N'2023-02-16' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0658559642', NULL, NULL, NULL, 2, CAST(N'2023-03-16' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0659451547', NULL, NULL, NULL, 12, CAST(N'2023-04-05' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0679523458', N'Ngô Văn Duy', N'Nam', NULL, 47, CAST(N'2023-04-02' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0689532547', N'Lý Thị Lan', N'Nữ', NULL, 45, CAST(N'2023-04-01' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0785447849', N'Lý Thị Bình Minh', N'Nữ', NULL, 81, CAST(N'2023-01-01' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0785758787', NULL, NULL, NULL, 6, CAST(N'2023-01-25' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0845676794', N'Nguyễn Thị Thanh Hồng', N'Nữ', NULL, 42, CAST(N'2023-02-18' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'087672358', N'Võ Thị Kim Lan', N'Nữ', NULL, 43, CAST(N'2023-03-16' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0888379513', NULL, NULL, NULL, 12, CAST(N'2023-04-03' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0937664646', N'Đặng Văn Luận', N'Nam', NULL, 12, CAST(N'2023-04-16' AS Date), NULL)
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0987654321', N'', N'Nữ', N'', 1, NULL, N'')
INSERT [dbo].[KhachHang] ([SDTKH], [Hoten], [GioiTinh], [DiaChi], [SoLanSuDungDV], [ThoiGian], [GhiChu]) VALUES (N'0987698776', N'', N'Nữ', N'', 0, NULL, N'')
GO
SET IDENTITY_INSERT [dbo].[UuDaiHoaDon] ON 

INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (1, N'HD>250k', CAST(250.00 AS Decimal(18, 2)), 5, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (3, N'HD>300k', CAST(300.00 AS Decimal(18, 2)), 7, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (4, N'HD>350k', CAST(350.00 AS Decimal(18, 2)), 10, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (5, N'HD>400k', CAST(400.00 AS Decimal(18, 2)), 12, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (6, N'HD>450k', CAST(450.00 AS Decimal(18, 2)), 15, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (8, N'HD>500k', CAST(500.00 AS Decimal(18, 2)), 17, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (12, N'HD>550k', CAST(550.00 AS Decimal(18, 2)), 20, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (13, N'HD>600k', CAST(600.00 AS Decimal(18, 2)), 22, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (14, N'HD>650k', CAST(650.00 AS Decimal(18, 2)), 25, CAST(N'2023-02-12T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (15, N'HD > 700k', CAST(700.00 AS Decimal(18, 2)), 27, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (16, N'HD>750k', CAST(750.00 AS Decimal(18, 2)), 30, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (17, N'HD>800k', CAST(800.00 AS Decimal(18, 2)), 32, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (21, N'HD>850k', CAST(850.00 AS Decimal(18, 2)), 35, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (22, N'HD>900k', CAST(900.00 AS Decimal(18, 2)), 37, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (24, N'HD>1000k', CAST(1000.00 AS Decimal(18, 2)), 40, CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiHoaDon] ([IDUDHD], [TenUDHD], [SoTien], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (25, N'BuiTienPhat', CAST(1000.00 AS Decimal(18, 2)), 100, CAST(N'2023-04-16T18:10:34.267' AS DateTime), CAST(N'2023-09-23T18:10:34.000' AS DateTime), N'toi nho ngu iu toiii')
SET IDENTITY_INSERT [dbo].[UuDaiHoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[UuDaiKhachHang] ON 

INSERT [dbo].[UuDaiKhachHang] ([IDUDKH], [TenUDKH], [SoLanKHSDDV], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (1, N'lv1', 25, 5, CAST(N'2023-01-01T23:00:00.000' AS DateTime), CAST(N'2023-12-31T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiKhachHang] ([IDUDKH], [TenUDKH], [SoLanKHSDDV], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (4, N'lv2', 50, 10, CAST(N'2023-01-01T23:00:00.000' AS DateTime), CAST(N'2023-12-31T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiKhachHang] ([IDUDKH], [TenUDKH], [SoLanKHSDDV], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (6, N'lv3', 100, 15, CAST(N'2023-01-01T23:00:00.000' AS DateTime), CAST(N'2023-12-31T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiKhachHang] ([IDUDKH], [TenUDKH], [SoLanKHSDDV], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (8, N'lv4', 150, 20, CAST(N'2023-01-01T23:00:00.000' AS DateTime), CAST(N'2023-12-31T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiKhachHang] ([IDUDKH], [TenUDKH], [SoLanKHSDDV], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (10, N'lv5', 200, 25, CAST(N'2023-01-01T23:00:00.000' AS DateTime), CAST(N'2023-12-31T23:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[UuDaiKhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (2, NULL, 980.0000, CAST(N'2023-04-16T07:09:40.050' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (5, NULL, 660.0000, CAST(N'2023-04-16T07:12:40.057' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (6, N'0785758787', 825.0000, CAST(N'2023-04-16T07:15:46.010' AS DateTime), N'Ví điện tử', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (8, NULL, 770.0000, CAST(N'2023-04-16T07:23:49.710' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (9, N'0679523458', 1839.0000, CAST(N'2023-04-16T07:24:58.500' AS DateTime), N'Thẻ tín dụng', NULL, 1, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (10, N'0785447849', 2079.0000, CAST(N'2023-04-16T07:29:18.860' AS DateTime), N'Tiền mặt', NULL, 4, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (11, NULL, 1430.0000, CAST(N'2023-04-16T07:37:05.817' AS DateTime), N'Ví điện tử', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (14, N'0454587878', 315.0000, CAST(N'2023-04-16T08:09:00.790' AS DateTime), N'Ví điện tử', 4, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (16, N'0785447849', 923.1000, CAST(N'2023-04-16T17:09:30.190' AS DateTime), N'Tiền mặt', NULL, 4, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (18, NULL, 770.0000, CAST(N'2023-04-10T08:07:09.000' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (20, NULL, 119.0000, CAST(N'2023-04-01T21:00:50.090' AS DateTime), N'Ví điện tử', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (21, N'0634896972', 348.0000, CAST(N'2023-04-02T14:00:00.010' AS DateTime), N'Th? tín d?ng', 5, 4, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (22, NULL, 396.0000, CAST(N'2023-04-08T18:14:25.340' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (23, NULL, 660.0000, CAST(N'2023-04-10T16:40:00.000' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (24, NULL, 2810.0000, CAST(N'2023-04-25T12:18:02.340' AS DateTime), N'Thẻ tín dụng', 25, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (26, NULL, 446.5000, CAST(N'2023-04-25T13:17:18.653' AS DateTime), N'Tiền mặt', 6, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (27, NULL, 2811.0000, CAST(N'2023-04-25T13:19:50.507' AS DateTime), N'Tiền mặt', 25, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (28, NULL, 2808.0000, CAST(N'2023-04-25T13:23:28.083' AS DateTime), N'Ví điện tử ', 25, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (29, N'0987654321', 392.0000, CAST(N'2023-04-26T10:31:22.770' AS DateTime), N'Tiền mặt', 5, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (30, N'0987654321', 44.0000, CAST(N'2023-04-26T10:36:00.680' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDon] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (31, N'0987654321', 184.8000, CAST(N'2023-04-26T10:37:31.000' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDonTam] ON 

INSERT [dbo].[HoaDonTam] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (1, N'0375942757', 825.0000, CAST(N'2023-04-16T07:08:50.387' AS DateTime), N'Ví điện tử', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDonTam] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (2, NULL, 98.0000, CAST(N'2023-04-16T07:09:40.050' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDonTam] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (5, NULL, 660.0000, CAST(N'2023-04-16T07:12:40.057' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDonTam] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (6, N'0785758787', 825.0000, CAST(N'2023-04-16T07:15:46.010' AS DateTime), N'Ví điện tử', NULL, NULL, 10, NULL)
INSERT [dbo].[HoaDonTam] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (7, N'0634896972', 981.0000, CAST(N'2023-04-16T07:20:58.950' AS DateTime), N'Tiền mặt', NULL, 6, 10, NULL)
INSERT [dbo].[HoaDonTam] ([OrderID], [SDTKH], [GiaTien], [ThoiGian], [PTThanhToan], [IDUDHD], [IDUDKH], [Thue], [GhiChu]) VALUES (8, NULL, 77.0000, CAST(N'2023-04-16T07:23:49.710' AS DateTime), N'Tiền mặt', NULL, NULL, 10, NULL)
SET IDENTITY_INSERT [dbo].[HoaDonTam] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuChi] ON 

INSERT [dbo].[PhieuChi] ([IDPhieuChi], [TenPhieChi], [SDTKH], [OrderID], [LiDo], [SoTien], [Ngay], [GhiChu]) VALUES (4, N'PC1', N'0123659621', NULL, N'Sai mon', 500000.0000, CAST(N'2023-04-25' AS Date), N'')
SET IDENTITY_INSERT [dbo].[PhieuChi] OFF
GO
SET IDENTITY_INSERT [dbo].[UuDaiSanPham] ON 

INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (1, N'Valentine_10', 10, CAST(N'2023-02-13T07:00:00.000' AS DateTime), CAST(N'2023-02-14T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (2, N'Summer_vacation_15', 15, CAST(N'2023-03-02T07:00:00.000' AS DateTime), CAST(N'2023-06-30T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (4, N'QuocKhanh_10', 10, CAST(N'2023-04-30T07:00:00.000' AS DateTime), CAST(N'2023-05-01T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (5, N'Healthy_10', 10, CAST(N'2023-04-01T07:00:00.000' AS DateTime), CAST(N'2023-04-30T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (11, N'HAPPYHOUR_20', 20, CAST(N'2023-04-15T07:00:00.000' AS DateTime), CAST(N'2023-04-15T09:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (12, N'FRESHDRINKS_10', 10, CAST(N'2023-03-01T07:00:00.000' AS DateTime), CAST(N'2023-03-15T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (13, N'TEA_20', 20, CAST(N'2023-03-28T07:00:00.000' AS DateTime), CAST(N'2023-03-31T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (14, N'5OFFSUMMER_5', 5, CAST(N'2023-05-15T07:00:00.000' AS DateTime), CAST(N'2023-05-30T23:00:00.000' AS DateTime), NULL)
INSERT [dbo].[UuDaiSanPham] ([IDUDSP], [TenUDSP], [SoPhanTramGiam], [NgayBD], [NgayKT], [GhiChu]) VALUES (15, N'COFFEEFAN_10', 10, CAST(N'2023-02-15T07:00:00.000' AS DateTime), CAST(N'2023-02-20T23:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[UuDaiSanPham] OFF
GO
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'CPDen', N'Cafe Đen', 28.0000, N'iceBacHa.jpg', 1, 1, N'123459gvc')
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'CPSocola', N'Cafe Chocolate', 40.0000, N'cafeChocolate.jpg', 15, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'DXBacHa', N'Đá xay bạc hà', 40.0000, N'iceBacHa.jpg', 2, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'LTBerry', N'Latte Berry', 40.0000, N'latteBery.jpg', 11, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'LTHibiscus', N'Latte Hibiscus', 40.0000, N'latteHibiscus.jpg', 11, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'NECaChua', N'Nước ép Cà chua', 30.0000, N'juiceCaChua.jpg', 5, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'NECam', N'Nước ép Cam', 30.0000, N'juiceCam.jpg', 5, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'SDBerry', N'Soda Berry', 35.0000, N'sodaBery.jpg', 14, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'SDKiwi', N'Soda Kiwi', 35.0000, N'sadaKiwi.jpg', 14, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'STBo', N'Sinh Tố Bơ', 45.0000, N'smothieBo.jpg', 5, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'STChuoi', N'Sinh Tố Chuối', 40.0000, N'smothieChuoi.jpg', 5, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'TRDao', N'Trà Đào', 30.0000, N'teaDao.jpg', 13, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [TenSanPham], [GiaTien], [AnhSanPham], [IDUDSP], [TrangThai], [GhiChu]) VALUES (N'TRDau', N'Trà Dâu', 30.0000, N'teaDau.jpg', 13, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[DanhMuc] ON 

INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (1, N'Cà Phê', NULL)
INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (2, N'Đá xay', NULL)
INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (3, N'Nước ép', NULL)
INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (4, N'Latte', NULL)
INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (5, N'Soda', NULL)
INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (6, N'Sinh Tố', NULL)
INSERT [dbo].[DanhMuc] ([IDDanhMuc], [TenDanhMuc], [MoTa]) VALUES (7, N'Trà', NULL)
SET IDENTITY_INSERT [dbo].[DanhMuc] OFF
GO
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (1, N'CPSocola')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (2, N'DXBacHa')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (3, N'NECaChua')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (3, N'NECam')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (4, N'LTBerry')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (4, N'LTHibiscus')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (5, N'STBo')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (5, N'STChuoi')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (6, N'SDBerry')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (6, N'SDKiwi')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (7, N'TRDao')
INSERT [dbo].[DanhMuc_SanPham] ([IDDanhMuc], [IDSanPham]) VALUES (7, N'TRDau')
GO
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (2, N'CPDen', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (2, N'CPSocola', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (5, N'TRDao', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (5, N'TRDau', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (6, N'NECam', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (6, N'STBo', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (8, N'LTBerry', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (8, N'TRDao', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (9, N'CPDen', 2, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (9, N'DXBacHa', 3, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (10, N'LTHibiscus', 3, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (10, N'STBo', 2, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (11, N'STChuoi', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (14, N'LTHibiscus', 5, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (14, N'NECam', 5, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (16, N'CPDen', 2, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (18, N'NECaChua', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (18, N'NECam', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (20, N'CPDen', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (20, N'LTBerry', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (20, N'STBo', 2, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (21, N'CPDen', 3, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (22, N'NECam', 5, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (22, N'SDBerry', 2, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (22, N'SDKiwi', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (22, N'STBo', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (22, N'STChuoi', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (23, N'TRDao', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (23, N'TRDau', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (24, N'CPDen', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (24, N'DXBacHa', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (24, N'NECaChua', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (24, N'NECam', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (26, N'DXBacHa', 9, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (26, N'LTBerry', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (26, N'LTHibiscus', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (26, N'NECaChua', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (27, N'CPDen', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (27, N'DXBacHa', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (27, N'LTBerry', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (27, N'NECaChua', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (28, N'CPDen', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (28, N'CPSocola', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (28, N'LTBerry', 1, NULL)
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (29, N'DXBacHa', 1, N'')
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (29, N'LTBerry', 9, N'20% đường')
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (30, N'LTBerry', 1, N'')
INSERT [dbo].[ChiTietHoadon] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (31, N'CPDen', 6, N'')
GO
INSERT [dbo].[ChiTietHoadonTam] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (1, N'LTBerry', 1, NULL)
INSERT [dbo].[ChiTietHoadonTam] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (2, N'CPDen', 1, NULL)
INSERT [dbo].[ChiTietHoadonTam] ([OrderID], [IDSanPham], [SoLuong], [GhiChu]) VALUES (2, N'STBo', 1, NULL)
GO
INSERT [dbo].[QuanCafe] ([Idquan], [SDT], [DiaChiQuan], [NgayBatDau], [Trangthai], [GhiChu]) VALUES (N'HICO_CF', N'012345678', N'371 Nguyễn Kiệm, Phường 3, Gò Vấp, Thành phố Hồ Chí Minh', CAST(N'2023-03-03' AS Date), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[QuyenUser] ON 

INSERT [dbo].[QuyenUser] ([IDQuyen], [TenQuyen], [MoTa], [QuanLiUser], [QuanLiSanPham], [QuanLiKhachHang], [QuanLiNhanVien], [QuanLiHoaDon], [QuanLiUuDaiSanPham], [QuanLiUuDaiKhachHang], [QuanLiUuDaiHoaDon], [QuanLiBanHang], [QuanLiPhieuChi], [QuanLiBienBan], [ThongKe]) VALUES (1, N'ChuQuan', N'gồm tất cả các quyền ', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[QuyenUser] ([IDQuyen], [TenQuyen], [MoTa], [QuanLiUser], [QuanLiSanPham], [QuanLiKhachHang], [QuanLiNhanVien], [QuanLiHoaDon], [QuanLiUuDaiSanPham], [QuanLiUuDaiKhachHang], [QuanLiUuDaiHoaDon], [QuanLiBanHang], [QuanLiPhieuChi], [QuanLiBienBan], [ThongKe]) VALUES (2, N'QuanLi', N'gồm tất cả các quyền ngoại trừ quản lí user', 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[QuyenUser] ([IDQuyen], [TenQuyen], [MoTa], [QuanLiUser], [QuanLiSanPham], [QuanLiKhachHang], [QuanLiNhanVien], [QuanLiHoaDon], [QuanLiUuDaiSanPham], [QuanLiUuDaiKhachHang], [QuanLiUuDaiHoaDon], [QuanLiBanHang], [QuanLiPhieuChi], [QuanLiBienBan], [ThongKe]) VALUES (3, N'NhanVien1', N'NhanVien1', 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0)
INSERT [dbo].[QuyenUser] ([IDQuyen], [TenQuyen], [MoTa], [QuanLiUser], [QuanLiSanPham], [QuanLiKhachHang], [QuanLiNhanVien], [QuanLiHoaDon], [QuanLiUuDaiSanPham], [QuanLiUuDaiKhachHang], [QuanLiUuDaiHoaDon], [QuanLiBanHang], [QuanLiPhieuChi], [QuanLiBienBan], [ThongKe]) VALUES (4, N'NhanVien2', N'quyền quản lý bán hàng, quản lí hoá đơn, quản lí khách hàng', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[QuyenUser] ([IDQuyen], [TenQuyen], [MoTa], [QuanLiUser], [QuanLiSanPham], [QuanLiKhachHang], [QuanLiNhanVien], [QuanLiHoaDon], [QuanLiUuDaiSanPham], [QuanLiUuDaiKhachHang], [QuanLiUuDaiHoaDon], [QuanLiBanHang], [QuanLiPhieuChi], [QuanLiBienBan], [ThongKe]) VALUES (5, N'NhanVien3', N'quyền quản lý bán hàng, quản lí khách hàng', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[QuyenUser] ([IDQuyen], [TenQuyen], [MoTa], [QuanLiUser], [QuanLiSanPham], [QuanLiKhachHang], [QuanLiNhanVien], [QuanLiHoaDon], [QuanLiUuDaiSanPham], [QuanLiUuDaiKhachHang], [QuanLiUuDaiHoaDon], [QuanLiBanHang], [QuanLiPhieuChi], [QuanLiBienBan], [ThongKe]) VALUES (6, N'', N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[QuyenUser] OFF
GO

