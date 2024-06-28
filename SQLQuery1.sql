Create database QuanLyQuanCafe
go

use QuanLyQuanCafe
go

Create Table TableFood
(
	id int identity primary key,
	name nvarchar(100)not null default N'Ch�a ���t t�n',
	status nvarchar(100)not null default N'Tr��ng'-- Tr��ng || co� ng���i
)
GO

CREATE TABLE Account
(	
	UserName Nvarchar(100) primary key,
	DisplayName Nvarchar(100)not null default N'staff',
	PassWord Nvarchar(1000)not null default 0,
	Type INT not null default 0 -- 1:admin 0:staff
)
Go

CREATE TABLE FoodCategory
(
	id int identity primary key,
	name nvarchar(100)not null default N'Ch�a ��t t�n'
	
)
Go

Create Table Food
(
	id int identity primary key,
	name nvarchar(100)not null default N'Ch�a ���t t�n',
	idCategory int not null,
	price float not null default 0

	foreign key (idCategory) references dbo.FoodCategory(id)
)
go

Create table Bill
(
	id int identity primary key,
	DateCheckIn Date not null default Getdate(),
	DateCheckOut Date ,
	idTable Int not null,
	status int not null default 0 --1: �a� thanh toa�n : 0 ch�a thanh toa�n

	foreign key (idTable) references dbo.TableFood(id)
)
Go

Create table BillInfo
(
	id int identity primary key,
	idBill int not null,
	idFood int not null,
	count Int not null default 0

	foreign key (idBill) references dbo.Bill(id),
	foreign key (idFood) references dbo.Food(id)
)
Go

Insert into dbo.Account
(
	UserName ,
	DisplayName,
	PassWord,
	Type
)
Values (
	N'Huy',
	N'Huy kkk',
	N'1',
	1
)
Insert into dbo.Account
(
	UserName ,
	DisplayName,
	PassWord,
	Type
)
Values (
	N'Staff',
	N'Staff 1',
	N'1',
	0
)

go
Create proc USP_GetAccountByUserName
@userName nvarchar(100)
As
begin
	select * from dbo.Account Where UserName = @userName
end
go

exec USP_GetAccountByUserName @userName =N'huy'


select * from dbo.Account where UserName =N'huy' And PassWord =N'1'

go
create proc USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	Select * from dbo.Account Where  UserName =@userName and PassWord= @passWord
end
go

insert dbo.TableFood
	(name , status)
	values (N'Ba�n 1')
go 
-- th�m ba�n
Declare @i int = 0
While @i <= 10
begin 
insert dbo.TableFood (name) Values (N'Ba�n '+ cast(@i as nvarchar(100)))
	set @i = @i + 1
end

DELETE FROM TableFood WHERE status = N'Tr��ng'
go
select * from dbo.TableFood
go

Create proc USP_GetTableList
As select * from dbo.TableFood
go

Exec dbo.USP_GetTableList
go

update dbo.TableFood set status =N'Co� ng���i' Where Name =N'Ba�n 3'

--th�m category
insert dbo.FoodCategory
	(name )
	values (N'Ha�i Sa�n')
insert dbo.FoodCategory
	(name )
	values (N'N�ng Sa�n')
insert dbo.FoodCategory
	(name )
	values (N'N���c ngo�t')
insert dbo.FoodCategory
	(name )
	values (N'Cafe')
insert dbo.FoodCategory
	(name )
	values (N'Sinh t��')

insert dbo.Food
	(name , idCategory, price )
	values (N'Ha�u t��i',1,100000)
insert dbo.Food
	(name , idCategory, price )
	values (N'Ngh�u h��p xa�',1,120000)
insert dbo.Food
	(name , idCategory, price )
	values (N'D� cha�y to�i',2,150000)
insert dbo.Food
	(name , idCategory, price )
	values (N'La�p x���ng',2,12000)
insert dbo.Food
	(name , idCategory, price )
	values (N'Coca',3,10000)
insert dbo.Food
	(name , idCategory, price )
	values (N'Pepsi',3,10000)
insert dbo.Food
	(name , idCategory, price )
	values (N'7UP',3,10000)
insert dbo.Food
	(name , idCategory, price )
	values (N'Cafe ch��n',4,40000)
insert dbo.Food
	(name , idCategory, price )
	values (N'Cafe mu��i',4,20000)
insert dbo.Food
	(name , idCategory, price )
	values (N'Matcha �a� xay',5,10000)

--Th�m bill
insert dbo.Bill
	(DateCheckIn,
	DateCheckOut,
	idTable,
	status)
values(GETDATE(),
		GETDATE(),
		168676,
		1)
insert dbo.Bill
	(DateCheckIn,
	DateCheckOut,
	idTable,
	status)
values(GETDATE(),
		GETDATE(),
		168676,
		0)
insert dbo.Bill
	(DateCheckIn,
	DateCheckOut,
	idTable,
	status)
values(GETDATE(),
		null,
		168676,
		0)

insert dbo.Bill
	(DateCheckIn,
	DateCheckOut,
	idTable,
	status)
values(GETDATE(),
		null,
		168677,
		0)

--th�m billinfo

Insert dbo.BillInfo
		(idBill,idFood,count)
Values (1 , 1 , 2)

Insert dbo.BillInfo
		(idBill,idFood,count)
Values (1 , 3 , 4)

Insert dbo.BillInfo
		(idBill,idFood,count)
Values (2 , 1 , 2)

Insert dbo.BillInfo
		(idBill,idFood,count)
Values (2 , 3 , 5)

Insert dbo.BillInfo
		(idBill,idFood,count)
Values (3 , 2 , 4)

Insert dbo.BillInfo
		(idBill,idFood,count)
Values (3 , 1 , 2)

select *from TableFood where id = (1 +168676)

select *from BillInfo
select *from Bill where idTable = 168677
select *from Food
select *from FoodCategory

select *from dbo.BillInfo where idBill =1 

Select f.name , bi.count , f.price , f.price*bi.count As totalPrice from dbo.BillInfo as bi , dbo.Food as f, dbo.Bill as b where  bi.idBill = b.id and bi.idFood = f.id and b.idTable =168676
go

Create proc USP_InsertBill
@idTable int
As
begin
	insert into dbo.Bill
	(DateCheckIn, DateCheckOut, idTable ,status)
	values
	(GETDATE(), null, @idTable,0)
end
go

Alter proc USP_InsertBillInfo
@idBill int, @idFood int, @count int
as
begin

	declare @isExitsBillInfo int;
	declare @foodCount int = 1

	select @isExitsBillInfo = id, @foodCount = b.count from dbo.BillInfo as b where idBill = @idBill and idFood = @idFood
	if(@isExitsBillInfo >0)
	begin 
		declare @newCount int = @foodCount + @count
		if(@newCount >0)
		update dbo.BillInfo set count = @foodCount + @count where idFood =@idFood
		else
		delete dbo.BillInfo where idBill = @idBill and idFood = @idFood
	end
	else
	begin
	Insert dbo.BillInfo
		(idBill,idFood,count)
	Values (@idBill , @idFood , @count)
	end
end
go

Select Max(id) from dbo.Bill