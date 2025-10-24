create database Clinic

use Clinic
drop table Patient
drop table Doctor
create table Patient(
	patientId int primary key identity(1,1),
	patientName varchar(25) not null,
	dateOfBirth date,
	phoneNo varchar(20) not null, check(len(phoneNo)=10 and phoneNo like '[6-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email varchar(30) not null,check(email like '%_@_%.__%')
)

exec sp_help Patient

create table Doctor(
	doctorId int primary key,
	doctorName varchar(25) not null,
	specialization varchar(40) not null,
	phoneNo varchar(20) not null check(len(phoneNo)=10 and phoneNo like '[6-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email varchar(30) not null ,check(email like '%_@_%.__%')
)



	CREATE TABLE ClinicSchedule (
		scheduleId INT PRIMARY KEY IDENTITY(1,1),
		dayOfWeek NVARCHAR(20) NOT NULL,
		startTime TIME NOT NULL,
		endTime TIME NOT NULL
	);

drop table ClinicSchedule

create table Appointment(
	appointmentId int primary key identity(1,1),
	patientId int not null,
	appointmentDateTime datetime not null,
	status varchar(20) not null,check(status in('Scheduled','Canceled','Completed')),
	reasonForVisit varchar(255) ,
	foreign key(patientId) references Patient(patientId)	
)

drop table  Appointment
insert into Doctor(doctorId,doctorName,specialization,phoneNo,email) values
(1,'Dr.Harry Potter','Dermatologist','6387878787','xyz@gmail.com')

exec sp_help Doctor

select * from Doctor

update Doctor 
set email='harry@gmail.com'

insert into Patient(patientName,dateOfBirth,phoneNo,email)values
	('Krish','1889-03-04','7676898765','krish@gmail.com'),
	('Iron Man','1989-03-04','9976898765','iron@gmail.com'),
	('Spider Man','1980-03-04','8876898765','spider@gmail.com')

select * from Patient
select * from Doctor
delete from Patient

INSERT INTO ClinicSchedule (dayOfWeek, startTime, endTime)
VALUES
('Monday', '09:00:00', '17:00:00'),
('Tuesday', '09:00:00', '17:00:00'),
('Wednesday', '09:00:00', '13:00:00'),
('Friday', '09:00:00', '17:00:00');

select * from ClinicSchedule
use Clinic
select * from Patient



create database SmartMeter

use SmartMeter
CREATE TABLE [User](  
  UserId         BIGINT IDENTITY PRIMARY KEY,  
  Username       NVARCHAR(100) NOT NULL UNIQUE,  
  PasswordHash   VARBINARY(256) NOT NULL,  
  DisplayName    NVARCHAR(150) NOT NULL,  
  Email          NVARCHAR(200) NULL,  
  Phone          NVARCHAR(30) NULL,  
  LastLoginUtc   DATETIME2(3) NULL,  
  IsActive       BIT NOT NULL DEFAULT 1);
 
CREATE TABLE OrgUnit (
  OrgUnitId INT IDENTITY PRIMARY KEY,
  Type VARCHAR(20) NOT NULL CHECK (Type IN ('Zone','Substation','Feeder','DTR')),
  Name NVARCHAR(100) NOT NULL,
  ParentId INT NULL REFERENCES OrgUnit(OrgUnitId)
);
 
CREATE TABLE Tariff (
  TariffId INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(100) NOT NULL,
  EffectiveFrom DATE NOT NULL,
  EffectiveTo DATE NULL,
  BaseRate DECIMAL(18,4) NOT NULL,
  TaxRate DECIMAL(18,4) NOT NULL DEFAULT 0
);
 
CREATE TABLE TodRule (
  TodRuleId      INT IDENTITY PRIMARY KEY,
  TariffId       INT NOT NULL REFERENCES Tariff(TariffId),
  Name           NVARCHAR(50) NOT NULL,
  StartTime      TIME(0) NOT NULL,
  EndTime        TIME(0) NOT NULL,
  RatePerKwh     DECIMAL(18,6) NOT NULL
);
 
 
CREATE TABLE TariffSlab (
  TariffSlabId   INT IDENTITY PRIMARY KEY,
  TariffId       INT NOT NULL REFERENCES Tariff(TariffId),
  FromKwh        DECIMAL(18,6) NOT NULL,
  ToKwh          DECIMAL(18,6) NOT NULL,
  RatePerKwh     DECIMAL(18,6) NOT NULL,
  CONSTRAINT CK_TariffSlab_Range CHECK (FromKwh >= 0 AND ToKwh > FromKwh)
);
 
CREATE TABLE Consumer (
  ConsumerId BIGINT IDENTITY PRIMARY KEY,
  Name NVARCHAR(200) NOT NULL,
  Address NVARCHAR(500) NULL,
  Phone NVARCHAR(30) NULL,
  Email NVARCHAR(200) NULL,
  OrgUnitId INT NOT NULL REFERENCES OrgUnit(OrgUnitId),
  TariffId INT NOT NULL REFERENCES Tariff(TariffId),
  Status VARCHAR(20) NOT NULL DEFAULT 'Active' CHECK (Status IN ('Active','Inactive')),
  CreatedAt DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL DEFAULT 'system',
  UpdatedAt DATETIME2(3) NULL,
  UpdatedBy NVARCHAR(100) NULL
);
 
CREATE TABLE Meter (
  MeterSerialNo NVARCHAR(50) NOT NULL PRIMARY KEY,
  IpAddress NVARCHAR(45) NOT NULL,
  ICCID NVARCHAR(30) NOT NULL,
  IMSI NVARCHAR(30) NOT NULL,
  Manufacturer NVARCHAR(100) NOT NULL,
  Firmware NVARCHAR(50) NULL,
  Category NVARCHAR(50) NOT NULL,
  InstallTsUtc DATETIME2(3) NOT NULL,
  Status VARCHAR(20) NOT NULL DEFAULT 'Active'
           CHECK (Status IN ('Active','Inactive','Decommissioned')),
  ConsumerId BIGINT NULL REFERENCES Consumer(ConsumerId)
);





 
 select * from OrgUnit


 -- Entry 1: Residential tariff starting in 2024
INSERT INTO Tariff (Name, EffectiveFrom, EffectiveTo, BaseRate, TaxRate)
VALUES ('Residential 2024', '2024-01-01', '2024-12-31', 6.5000, 0.0500);

-- Entry 2: Commercial tariff, currently active (no end date)
INSERT INTO Tariff (Name, EffectiveFrom, EffectiveTo, BaseRate, TaxRate)
VALUES ('Commercial Standard', '2024-03-15', NULL, 8.2500, 0.0800);

-- Entry 3: Off-peak tariff with a lower rate
INSERT INTO Tariff (Name, EffectiveFrom, EffectiveTo, BaseRate, TaxRate)
VALUES ('Off-Peak 2025', '2025-01-01', '2025-12-31', 4.1000, 0.0500);

-- Entry 4: A historical, expired tariff
INSERT INTO Tariff (Name, EffectiveFrom, EffectiveTo, BaseRate, TaxRate)
VALUES ('Historical Residential 2023', '2023-01-01', '2023-12-31', 6.0000, 0.0400);

-- Entry 5: A promotional tariff with a high tax rate
INSERT INTO Tariff (Name, EffectiveFrom, EffectiveTo, BaseRate, TaxRate)
VALUES ('Promotional High-Tax', '2025-10-01', '2025-12-31', 5.5000, 0.1000);




INSERT INTO TodRule (TariffId, Name, StartTime, EndTime, RatePerKwh)
VALUES
    (2, 'Commercial Peak', '09:00:00', '17:00:00', 8.250000),
    (2, 'Commercial Off-Peak', '22:00:00', '06:00:00', 4.100000),
    (1, 'Residential Day', '07:00:00', '21:00:00', 6.500000),
    (2, 'Summer Peak', '13:00:00', '15:00:00', 9.500000),
    (4, 'Fixed Historical Rate', '00:00:00', '23:59:59', 6.000000);



INSERT INTO TariffSlab (TariffId, FromKwh, ToKwh, RatePerKwh)
VALUES
    (1, 0.000000, 100.000000, 5.000000),      -- First 100 units at a base rate
    (1, 100.000001, 250.000000, 7.500000),   -- Next 150 units at a higher rate
    (1, 250.000001, 500.000000, 9.000000),   -- Next 250 units at an even higher rate
    (1, 500.000001, 1000.000000, 11.250000), -- High usage slab
    (1, 1000.000001, 999999.999999, 13.000000); -- Top-tier usage slab


INSERT INTO Meter (MeterSerialNo, IpAddress, ICCID, IMSI, Manufacturer, Firmware, Category, InstallTsUtc, Status, ConsumerId)
VALUES
    ('MTR-001', '192.168.1.10', '8900000000000000010', '001010000000010', 'Manufacturer A', 'v1.1.0', 'Smart Residential', '2025-09-01 10:00:00.000', 'Active', NULL),
    ('MTR-002', '192.168.1.11', '8900000000000000011', '001010000000011', 'Manufacturer B', 'v2.5.3', 'Commercial Industrial', '2025-09-02 11:30:00.000', 'Active', NULL),
    ('MTR-003', '192.168.1.12', '8900000000000000012', '001010000000012', 'Manufacturer A', 'v1.1.0', 'Smart Residential', '2025-09-05 14:45:00.000', 'Inactive', NULL),
    ('MTR-004', '192.168.1.13', '8900000000000000013', '001010000000013', 'Manufacturer C', 'v3.0.1', 'Smart Residential', '2025-09-08 09:15:00.000', 'Active', NULL),
    ('MTR-005', '192.168.1.14', '8900000000000000014', '001010000000014', 'Manufacturer B', NULL, 'Commercial Industrial', '2025-09-10 16:20:00.000', 'Decommissioned', NULL);



	INSERT INTO [User] (Username, PasswordHash, DisplayName, Email, Phone, LastLoginUtc, IsActive)
VALUES
    ('admin_user', HASHBYTES('SHA2_512', 'Admin@123'), 'System Administrator', 'admin@example.com', NULL, '2025-10-09 16:30:00.000', 1),
    ('john.doe', HASHBYTES('SHA2_512', 'Password123'), 'John Doe', 'john.doe@example.com', '123-456-7890', '2025-10-09 16:35:00.000', 1),
    ('jane.smith', HASHBYTES('SHA2_512', 'SecurePass456'), 'Jane Smith', 'jane.smith@example.com', '987-654-3210', '2025-10-08 10:00:00.000', 1),
    ('inactive_user', HASHBYTES('SHA2_512', 'OldPassword789'), 'Inactive User', 'inactive@example.com', NULL, '2024-05-20 08:00:00.000', 0),
    ('new_user', HASHBYTES('SHA2_512', 'TestUser@123'), 'New User', 'new.user@example.com', '555-123-4567', NULL, 1);


INSERT INTO Consumer (Name, Address, Phone, Email, OrgUnitId, TariffId, Status)
VALUES
    ('Alice Johnson', '123 Main St, Anytown', '555-1234', 'alice.j@email.com', 1, 1, 'Active'),
    ('Bob Williams', '456 Oak Ave, Anycity', '555-5678', NULL, 2, 2, 'Active'),
    ('Charlie Brown', '789 Pine Ln, Anyville', '555-9012', 'charlie.b@email.com', 3, 1, 'Inactive'),
    ('Diana Prince', '101 Elm Blvd, Anytown', '555-3456', 'diana.p@email.com', 4, 2, 'Active'),
    ('Edward Nygma', '321 Riddler Rd, Gotham', '555-7890', NULL, 1, 4, 'Active');




--List all active users
select *
from [User] 
where IsActive=1

--Show all consumers with their tariff names
SELECT
  c.Name AS ConsumerName,
  t.Name AS TariffName
FROM Consumer AS c
INNER JOIN Tariff AS t
  ON c.TariffId = t.TariffId;

--Count total meters by status
SELECT
  Status,
  COUNT(MeterSerialNo) AS TotalMeters
FROM Meter
GROUP BY
  Status;

--Show all ToD rules for a given Tariff name
SELECT
  tr.Name AS RuleName,
  tr.StartTime,
  tr.EndTime,
  tr.RatePerKwh
FROM TodRule AS tr
INNER JOIN Tariff AS t
  ON tr.TariffId = t.TariffId
WHERE
  t.Name = 'Commercial Standard';


--Get top 5 most recently installed meters
select top(5) *
from Meter 
order by InstallTsUtc desc

--List consumers without an assigned meter
SELECT
  c.Name AS ConsumerName,
  c.ConsumerId
FROM Consumer AS c
LEFT JOIN Meter AS m
  ON c.ConsumerId = m.ConsumerId
WHERE
  m.ConsumerId IS NULL;


--Find tariffs that have expired
SELECT
  TariffId,
  Name,
  EffectiveFrom,
  EffectiveTo
FROM Tariff
WHERE
  EffectiveTo IS NOT NULL AND EffectiveTo < GETDATE();




use Clinic
select * from Patient
select * from Appointment



use Employee

exec sp_help Employee
select * from Employee
select * from employee

create index idx_name
on employee(First_Name)

select * from employee


drop index idx_name on employee

set statistics time on SELECT * FROM employee WHERE FIRST_NAME = 'Josh' and LAST_NAME = 'Morter3';

insert into employee(EMP_ID,FIRST_NAME,LAST_NAME,BIRTH_DATE,SEX,SALARY,DEPT_ID,SUPER_ID) values
(107,'Josh','Morter1','1999-09-09','F',44555,4,NULL),
(108,'Josh','Morter2','1999-09-09','F',44555,4,NULL),
(109,'Josh','Morter3','1999-09-09','F',44555,4,NULL),
(110,'Josh','Morter4','1999-09-09','F',44555,4,NULL)


CREATE NONCLUSTERED INDEX idx ON Sales.Invoices (CustomerID);


-- scaler subquery
SELECT product_name, (SELECT AVG(price) FROM products) AS avg_price FROM products;

select * from employee

--single row subquery
select *
from employee 
where (select avg(salary) from employee)<SALARY


--multiple column subqueries


-- table subqueries(Multiple rows and columns)

select * from STUDENT
select * from Employee

--inner join
select *
from Employee as e1
inner join Employee as e2 
on e1.EMP_ID=e2.EMP_ID

--left join
select *
from Employee as e1
left join Employee as e2 
on e1.EMP_ID=e2.EMP_ID


--right join
select *
from Employee as e1
right join Employee as e2 
on e1.EMP_ID=e2.FIRST_NAME


-- full outer join
select *
from Employee as e1
full outer join Employee as e2 
on e1.EMP_ID=e2.SUPER_ID


--select * from Employee Natural join DEPARTMENT

select * fro	m DEPARTMENT
select * from Employee  join Employee

select e.EmpName,m.managerId
from Employee as e 
left join Employee as m
on e.managerId = m.ManagerId

select *
from Employee 
cross join
Depart


CREATE VIEW ActiveCustomers AS
SELECT EMP_ID, FIRST_NAME, SALARY 
FROM Employee 
WHERE DEPT_ID=4;

select * from ActiveCustomers




-- E-Commerce order management
create database if not exists OnlineStore

create database OnlineStore
use OnlineStore
drop database OnlineStore
create table Customers(
	CustomerID int primary key,
	FirstName varchar(20),
	LastName varchar(20),
	Email varchar(50) check(email like '%_@_%.__%')
)
drop table Customers

create table Products(
	ProductID int primary key,
	ProductName varchar(50),
	Price decimal(10,2),
	StockQuantity int
)

create table Orders(
	OrderID int primary key identity(1,1),
	CustomerID int, 
	OrderDate datetime,
	TotalAmount decimal(10,2),
	foreign key(CustomerID) references Customers(CustomerID)
)
drop table Orders

create table OrderItems(
	OrderItemID int primary key identity(1,1),
	OrderID int ,
	ProductID int,
	Quantity int,
	UnitPrice decimal(10,2),
	foreign key(OrderID) references Orders(OrderID),
	foreign key(ProductID) references Products(ProductID)
)
drop table OrderItems

--Process single product order
create procedure usp_PlaceNewOrder @CustomerID int,@ProductID int,@Quantity int
as
	declare @NewOrderID int; 
	--new order created
	insert into Orders(CustomerID,OrderDate,TotalAmount) values
		(@CustomerID,GETDATE(),0.0);

	set @NewOrderID = SCOPE_IDENTITY();

	--new order add in orderItem
	insert into OrderItems(OrderID,ProductID,Quantity,UnitPrice) values
		(@NewOrderID,@ProductID,@Quantity,20);
	-- we can insert more item in orderItem table

	--quantity of the product is deduct
	update Products
	set StockQuantity-=@Quantity
	where ProductID = @ProductID;

	update Orders
	set TotalAmount += 20
	where OrderID = @NewOrderID;
GO;


exec usp_PlaceNewOrder @CustomerID=101,@ProductID=1,@Quantity=25


insert into Products(ProductID,ProductName,Price,StockQuantity) values
	(1,'P1',20,50),
	(2,'P2',30,50),
	(3,'P3',40,50),
	(4,'P4',50,50),
	(5,'P5',100,50)

insert into Customers(CustomerID,FirstName,LastName,Email) values
	(101,'Tony','Stark','tony@gmail.com')








drop type MyOrderProduct
--passing list in stored procedure
create type MyOrderProduct as table
(
	ProductID int,
	Quantity int
);
GO



--Process multiple product order
create procedure usp_PlaceNewMultipleOrder 
	@CustomerID int, 
	@ProductList MyOrderProduct readonly
as
BEGIN
	if exists(
		select 1
		from @ProductList pl 
		inner join Products p on pl.ProductID = p.ProductID
		where pl.Quantity>p.StockQuantity
	)
	begin
		raiserror('Insufficient stock');
		return;
	end



	declare @totalAmount decimal(10,0);

	select @totalAmount = sum(pl.Quantity*p.Price)
	from @ProductList pl
	inner join Products p on pl.ProductID = p.ProductID


	declare @NewOrderID int; 
	--new order created
	insert into Orders(CustomerID,OrderDate,TotalAmount) values
		(@CustomerID,GETDATE(),@totalAmount);

	set @NewOrderID = SCOPE_IDENTITY();

		insert into OrderItems(OrderID,ProductID,Quantity,UnitPrice)
		select @NewOrderID,pl.ProductID,pl.Quantity,p.Price
		from @ProductList pl inner join Products p
		on pl.ProductID = p.ProductID


	--quantity of the product is deduct
	update Products
	set StockQuantity = p.StockQuantity - pl.Quantity
	from Products p
	inner join @ProductList pl on pl.ProductID = p.ProductID;
END
GO



CREATE PROCEDURE usp_PlaceNewMultipleOrder 
    @CustomerID INT, 
    @ProductList MyOrderProduct READONLY
AS
BEGIN
    -- Check stock availability
    IF EXISTS(
        SELECT 1
        FROM @ProductList pl 
        INNER JOIN Products p ON pl.ProductID = p.ProductID
        WHERE pl.Quantity > p.StockQuantity
    )
    BEGIN
        RAISERROR('Insufficient stock', 16, 1);
        RETURN;
    END

    DECLARE @totalAmount DECIMAL(10,2);
    
    SELECT @totalAmount = SUM(pl.Quantity * p.Price)
    FROM @ProductList pl
    INNER JOIN Products p ON pl.ProductID = p.ProductID;

    DECLARE @NewOrderID INT; 
    
    -- Create new order
    INSERT INTO Orders(CustomerID, OrderDate, TotalAmount) 
    VALUES (@CustomerID, GETDATE(), @totalAmount);

    SET @NewOrderID = SCOPE_IDENTITY();

    -- Insert order items
    INSERT INTO OrderItems(OrderID, ProductID, Quantity, UnitPrice)
    SELECT @NewOrderID, pl.ProductID, pl.Quantity, p.Price
    FROM @ProductList pl 
    INNER JOIN Products p ON pl.ProductID = p.ProductID;

    -- Update stock quantities
    UPDATE Products
    SET StockQuantity = p.StockQuantity - pl.Quantity
    FROM Products p
    INNER JOIN @ProductList pl ON pl.ProductID = p.ProductID;
END
GO
	--Execute in one set tvp is like a variable
-----------------------------------------------
declare @ProductList as MyOrderProduct

insert into @ProductList(ProductID,Quantity) values
	(2,1),
	(3,1),
	(4,1);


----------------------------------------------------

EXEC usp_PlaceNewMultipleOrder 
    @CustomerID = 101, 
    @ProductList = @ProductList;


select * from @ProductList

	SP_HELP Orders;



CREATE FUNCTION MaximumProductPrice(
    @ProductID INT, 
    @Price DECIMAL(10,2)
) 
RETURNS INT
AS
BEGIN
    RETURN @ProductID;
END;
GO

SELECT ProductID, ProductName, dbo.MaximumProductPrice(ProductID, Price) AS MaxPrice
FROM Products;


select * from Customers 
select * from Orders 
select * from OrderItems 
select * from Products







--JSON data

create database OfflineStore
use OfflineStore


create table Products(
	ProductID int identity(1,1) primary key,
	ProductName varchar



