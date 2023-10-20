create database FlokemonStore
go
use FlokemonStore
go

CREATE TABLE Staff 
(StaffID char(5) NOT NULL CHECK(StaffID like 'ST[0-9][0-9][0-9]'), 
StaffName varchar(200) NOT NULL CHECK(len(StaffName) > 7), 
StaffEmail varchar(200) NOT NULL CHECK(StaffEmail like '%.com'), 
StaffPhone varchar(200) NOT NULL, 
StaffGender varchar(200) NOT NULL, 
Salary int NOT NULL, 
PRIMARY KEY (StaffID));

CREATE TABLE Customer 
(CustomerID char(5) NOT NULL CHECK(CustomerID like 'CU[0-9][0-9][0-9]'), 
CustomerName varchar(200) NOT NULL CHECK(len(CustomerName) > 7), 
CustomerPhoneNo varchar(200) NOT NULL, 
CustomerGender varchar(255) NOT NULL CHECK(CustomerGender like 'Male' or CustomerGender like 'Female'), 
CustomerEmail varchar(200) NOT NULL CHECK(CustomerEmail like '%.com'), 
PRIMARY KEY (CustomerID));

CREATE TABLE Supplier 
(SupplierID char(5) NOT NULL CHECK(SupplierID like 'SU[0-9][0-9][0-9]'), 
SupplierName varchar(200) NOT NULL CHECK(len(SupplierName) > 7), 
SupplierEmail varchar(200) NOT NULL CHECK(SupplierEmail like '%.com'), 
SupplierPhoneNo varchar(200) NOT NULL, 
PRIMARY KEY (SupplierID));

CREATE TABLE FlokemonType 
(FlokemonTypeID char(5) NOT NULL CHECK(FlokemonTypeID like 'FT[0-9][0-9][0-9]'), 
FlokemonTypeName varchar(200) NOT NULL, 
PRIMARY KEY (FlokemonTypeID));

CREATE TABLE Flokemon 
(FlokemonID char(5) NOT NULL CHECK(FlokemonID like 'FL[0-9][0-9][0-9]'), 
FlokemonTypeID char(5) FOREIGN KEY REFERENCES FlokemonType(FlokemonTypeID) NOT NULL, 
FlokemonName varchar(200) NOT NULL CHECK(len(FlokemonName) > 5), 
FlokemonDmg int NOT NULL CHECK(FlokemonDmg >= 100), 
FlokemonPrice int NOT NULL CHECK(FlokemonPrice between 10000 and 1000000), 
PRIMARY KEY (FlokemonID));

CREATE TABLE SalesTransaction 
(SalesID char(5) NOT NULL CHECK(SalesID like 'SA[0-9][0-9][0-9]'), 
StaffID char(5) FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL, 
CustomerID char(5) FOREIGN KEY REFERENCES Customer(CustomerID) NOT NULL, 
SalesTransactionDate date NOT NULL CHECK(SalesTransactionDate <= getdate()),
PRIMARY KEY (SalesID));

CREATE TABLE PurchaseTransaction 
(PurchaseID char(5) NOT NULL CHECK(PurchaseID like 'PU[0-9][0-9][0-9]'), 
StaffID char(5) FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
SupplierID char(5) FOREIGN KEY REFERENCES Supplier(SupplierID)NOT NULL, 
PurchasedTransactionDate date NOT NULL CHECK(PurchasedTransactionDate <= getdate()), 
PRIMARY KEY (PurchaseID));

CREATE TABLE SalesTransactionDetail 
(SalesID char(5) FOREIGN KEY(SalesID) REFERENCES SalesTransaction(SalesID), 
FlokemonID char(5) FOREIGN KEY(FlokemonID) REFERENCES Flokemon(FlokemonID), 
SalesQty int NOT NULL CHECK(SalesQty >= 1), 
PRIMARY KEY (SalesID, FlokemonID));

CREATE TABLE PurchaseTransactionDetail 
(PurchaseID char(5) FOREIGN KEY(PurchaseID) REFERENCES PurchaseTransaction(PurchaseID), 
FlokemonID char(5) FOREIGN KEY(FlokemonID) REFERENCES Flokemon(FlokemonID), 
PurchasedQty int NOT NULL CHECK(PurchasedQty >= 1), 
PRIMARY KEY (PurchaseID, FlokemonID));
