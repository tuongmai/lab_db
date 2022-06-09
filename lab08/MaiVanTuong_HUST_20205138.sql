CREATE TABLE Customer (
CustomerID varchar(255) PRIMARY KEY,
FullName Nvarchar(255),
PhoneNumber varchar(255),
Company Nvarchar(255)
);
CREATE TABLE House (
HouseID varchar(255) PRIMARY KEY,
Address Nvarchar(255),
Price money,
Host Nvarchar(255)
);



CREATE TABLE Contract (
HouseID varchar(255),
CustomerID varchar(255),
StartDate date,
EndDate date,
CONSTRAINT PK_Contract PRIMARY KEY (HouseID,CustomerID),
CONSTRAINT FK_Contract1 FOREIGN KEY (HouseID)
REFERENCES House(HouseID),
CONSTRAINT FK_Contract2 FOREIGN KEY (CustomerID)
REFERENCES Customer(CustomerID)
);



INSERT INTO Customer
Values
('KH1',N'Nghiêm Đình Minh','0358193936','HUST'),
('KH2',N'Mai Văn Tường','0358193932','DUT'),
('KH3',N'Nguyễn Thành Đạt','0358193933','VNU'),
('KH4',N'Vũ Thùy Ngân','0358193934','HUS'),
('KH5',N'Nghiêm Thị Thủy','0358193935','PTIT'),
('KH6',N'Nguyễn Hồng Thái','0358193936','MKA'),
('KH7',N'Bùi Thanh Tùng','0358193937','TLU'),
('KH8',N'Tạ Hải Tùng','0358193938','TLA'),
('KH9',N'Lê Thị Nguyệt','0358193939','TMU'),
('KH10',N'Trình Lê Hào Quang','0358193930','FTU'),
('KH11',N'Đinh Văn Hùng','0358193931','NEU'),
('KH12',N'Nguyễn Thị Diệu Linh','0358193941','HUST'),
('KH13',N'Nguyễn Thị Thu','0358193942','HUST'),
('KH14',N'Ngô Thị Hồng Hạnh','0358193943','HUST'),
('KH15',N'Nguyễn Đức Tuân','0358193944','HUST');



INSERT INTO House
Values ('N1',N'Hoàng Mai','15000000',N'Nông Văn Dền'),
('N2',N'Nam Từ Liêm','20000000',N'Shark Hưng'),
('N3',N'Hai Bà Trưng','10000000',N'Kang Tê Mô'),
('N4',N'Tân Mai','25000000',N'Park Hang Seo'),
('N5',N'Triều Khúc','15000000',N'CR7'),
('N6',N'Giải Phóng','20000000',N'Leo Messi'),
('N7',N'Nguyễn Chí Thanh','12000000',N'Phạm Nhật Vượng'),
('N8',N'Mai Dịch','17000000',N'Lý Tiểu Long'),
('N9',N'Lê Thanh Nghị','4000000',N'Vũ Trí Ba Tái Trợ'),
('N10',N'Trần Đại Nghĩa','6000000',N'Monkey D.Luffy');



INSERT INTO Contract
Values
('N1', 'KH5' ,'2020-10-12' ,'2020-12-12'),
('N2', 'KH6' ,'2021-10-30' ,'2021-12-30'),
('N3', 'KH2' ,'2021-01-22' ,'2021-05-22'),
('N4', 'KH4' ,'2022-06-25' ,'2022-09-25'),
('N5', 'KH8' ,'2021-04-28' ,'2021-06-28'),
('N6', 'KH9' ,'2021-07-30' ,'2021-09-30'),
('N7', 'KH10' ,'2020-03-21' ,'2020-04-21'),
('N8', 'KH11' ,'2022-08-15' ,'2022-12-15'),
('N9', 'KH15' ,'2019-06-18' ,'2019-09-18'),
('N10', 'KH12' ,'2020-01-14' ,'2020-12-14');


SELECT Address,Host
FROM House
WHERE Price > 10000000;



SELECT Customer.CustomerID,FullName,Company
FROM Customer
JOIN Contract ON Customer.CustomerID = Contract.CustomerID
JOIN House ON Contract.HouseID = House.HouseID
WHERE House.Host = N'Nông Văn Dền';



SELECT * FROM House
WHERE HouseID NOT IN (
SELECT HouseID FROM Contract
);



SELECT Price as MaxPrice FROM House
WHERE Price >= ALL ( Select Price FROM House
WHERE HouseID IN (SELECT DISTINCT HouseID FROM Contract) );



CREATE INDEX index_Company
ON Customer (Company);



CREATE INDEX index_Host
ON House (Host);



SELECT * FROM Customer
WHERE Company = 'HUST';



SELECT Host,Count(HouseID) as HouseNumber
FROM House
Group BY Host;


GO
CREATE PROCEDURE ListContract @Money money
AS
SELECT * FROM Contract
JOIN House ON Contract.HouseID = House.HouseID
WHERE Price >= @Money;
GO



EXEC ListContract @Money = 10000000;



GO
CREATE PROCEDURE TotalConTract @Money money
AS
with foo as(
select DATEDIFF (month,StartDate,EndDate) as RentMonth ,CustomerID from Contract
Group BY CustomerID,StartDate,EndDate
)
SELECT Customer.CustomerID,Customer.FullName,Customer.PhoneNumber,Customer.Company FROM Customer
JOIN foo ON Customer.CustomerID = foo.CustomerID
JOIN Contract ON foo.CustomerID = Contract.CustomerID
JOIN House ON Contract.HouseID = House.HouseID
GROUP BY Customer.CustomerID,Customer.FullName,Customer.PhoneNumber,Customer.Company 
HAVING SUM(House.Price*RentMonth) >= @Money;
GO



EXEC TotalContract @Money = 20000000;