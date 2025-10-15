
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




