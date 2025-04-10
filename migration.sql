-- Table: tram
CREATE TABLE tram (
    ma_tram VARCHAR(255) PRIMARY KEY,
    ten_tram VARCHAR(255) NOT NULL
);

-- Table: xe
CREATE TABLE xe (
    ma_xe VARCHAR(255) PRIMARY KEY
);

-- Table: tuyen
CREATE TABLE tuyen (
    ma_tuyen VARCHAR(255) PRIMARY KEY,
    ten_tuyen VARCHAR(255) NOT NULL
);

-- Table: chi_tiet_tuyen
CREATE TABLE chi_tiet_tuyen (
    id SERIAL PRIMARY KEY,
    ma_tuyen VARCHAR(255) NOT NULL references tuyen,
    thu_tu_tram VARCHAR(255) NOT NULL,
    ma_tram VARCHAR(255) NOT NULL references tram,
    tien_phi INTEGER
);

-- Tạo bảng profile để lưu thông tin người dùng  
create table public.profiles (
  id uuid not null references auth.users on delete cascade,
  name text,
  role text,
  primary key (id)
);

alter table public.profiles enable row level security;

-- Table: chuyen_xe
CREATE TABLE chuyen_xe (
    ma_chuyen VARCHAR(255) PRIMARY KEY,
    ma_tuyen VARCHAR(255) NOT NULL,
    ma_tai_xe uuid NOT NULL references profiles,
    ma_xe VARCHAR(255) NOT NULL references xe,
    luot_di TIME NOT NULL,
    luot_ve TIME NOT NULL,
    tinh_trang VARCHAR(255) NOT NULL
);

-- Table: bang_don_tra
CREATE TABLE bang_don_tra (
    id SERIAL PRIMARY KEY,
    ma_chuyen VARCHAR(255) NOT NULL references chuyen_xe,
    ma_khach_hang uuid NOT NULL references profiles,
    ma_tram_di VARCHAR(255) NOT NULL references tram,
    ma_tram_dich VARCHAR(255) NOT NULL references tram,
    hoan_thanh BOOLEAN NOT NULL,
    trang_thai_thanh_toan VARCHAR(255),
    tien_phi VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    so_luong INTEGER,
    chieu VARCHAR(255),
    ten_khach_hang VARCHAR(255)
);


-- inserts a row into public.profiles
create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, name, role)
  values (new.id, new.raw_user_meta_data ->> 'name',  new.raw_user_meta_data ->> 'role');
  return new;
end;
$$;
-- trigger the function every time a user is created
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();


-- Insert data into xe
INSERT INTO xe (ma_xe)
VALUES ('XE001'), ('XE002'), ('XE003');

-- Insert data into tuyen
INSERT INTO tuyen (ma_tuyen, ten_tuyen)
VALUES ('T01', 'Tuyến A'), ('T02', 'Tuyến B'), ('T03', 'Tuyến C');

-- Insert data into tram
INSERT INTO tram (ma_tram, ten_tram)
VALUES ('TRAM01', 'Trạm 1'), 
       ('TRAM02', 'Trạm 2'), 
       ('TRAM03', 'Trạm 3'), 
       ('TRAM04', 'Trạm 4');

-- Insert data into chi_tiet_tuyen
INSERT INTO chi_tiet_tuyen (ma_tuyen, thu_tu_tram, ma_tram, tien_phi)
VALUES ('T01', '1', 'TRAM01', 10000),
       ('T01', '2', 'TRAM02', 12000),
       ('T02', '1', 'TRAM02', 15000),
       ('T02', '2', 'TRAM03', 18000),
       ('T03', '1', 'TRAM03', 20000),
       ('T03', '2', 'TRAM04', 22000);

-- Insert data into chuyen_xe
INSERT INTO chuyen_xe (ma_chuyen, ma_tuyen, ma_tai_xe, ma_xe, luot_di, luot_ve, tinh_trang)
VALUES ('CX01', 'T01', 101, 'XE001', '07:30', '18:00', 'Đang hoạt động'),
       ('CX02', 'T02', 102, 'XE002', '08:00', '18:30', 'Đang bảo trì'),
       ('CX03', 'T03', 103, 'XE003', '08:30', '19:00', 'Đang hoạt động');
