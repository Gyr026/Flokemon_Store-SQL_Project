use FlokemonStore
go

--no 1
select c.CustomerName, s.StaffName,
[Total Transaction] = count(st.SalesID)
from Customer c
join SalesTransaction st on c.CustomerID = st.CustomerID
join Staff s on st.StaffID = s.StaffID
where c.CustomerName like '%a%'
and year(st.SalesTransactionDate) = 2020
group by c.CustomerName, s.StaffName

--no 2
select f.FlokemonName, ft.FlokemonTypeName,
[Total Purchased Flokemon] = sum(ptd.PurchasedQty)
from FlokemonType ft
join Flokemon f on ft.FlokemonTypeID = f.FlokemonTypeID
join PurchaseTransactionDetail ptd on f.FlokemonID = ptd.FlokemonID
where len(f.FlokemonName) > 5
and ft.FlokemonTypeName like '%a%'
group by f.FlokemonName, ft.FlokemonTypeName

--no 3
select ft.FlokemonTypeName, 
[Average Price] = concat('Rp. ',avg(f.FlokemonPrice)),
[Total Sales Flokemon] = sum(std.SalesQty)
from FlokemonType ft
join Flokemon f on ft.FlokemonTypeID = f.FlokemonTypeID
join SalesTransactionDetail std on f.FlokemonID = std.FlokemonID
where ft.FlokemonTypeName like 'p%'
and f.FlokemonDmg > 1000
group by ft.FlokemonTypeName
order by ft.FlokemonTypeName

--no 4
select c.CustomerName,
[Total Transaction] = count(st.SalesID),
[Total Flokemon Bought] = count(std.SalesQty)
from Customer c
join SalesTransaction st on c.CustomerID = st.CustomerID
join SalesTransactionDetail std on st.SalesID = std.SalesID
where month(st.SalesTransactionDate) = 10
and std.SalesQty > 10
and c.CustomerName like '%a%'
group by c.CustomerName

--no 5
select st.SalesID, c.CustomerName, s.StaffName,
[Transaction Day] = datename(weekday, st.SalesTransactionDate)
from Staff s
join SalesTransaction st on s.StaffID = st.StaffID
join Customer c on st.CustomerID = c.CustomerID,
(
	select [Average] = avg(s2.Salary)
	from Staff s2
) as AvgSalary
where s.Salary > AvgSalary.Average
and datename(month, st.SalesTransactionDate) = 'February'
group by st.SalesID, c.CustomerName, s.StaffName, st.SalesTransactionDate

--no 6
select [StaffName] = upper(s.StaffName),
f.FlokemonName,
[Transaction Year] = year(pt.PurchasedTransactionDate)
from Staff s
join PurchaseTransaction pt on s.StaffID = pt.StaffID
join PurchaseTransactionDetail ptd on pt.PurchaseID = ptd.PurchaseID
join Flokemon f on ptd.FlokemonID = f.FlokemonID,
(
	select [Average] = avg(ptd2.PurchasedQty)
	from PurchaseTransactionDetail ptd2
) as AvgPurchasedQty
where ptd.PurchasedQty > AvgPurchasedQty.Average
and year(pt.PurchasedTransactionDate) = 2018
and s.StaffName like '%s%'
group by upper(s.StaffName), f.FlokemonName, year(pt.PurchasedTransactionDate)

--no 7
select [Transaction Date] = st.SalesTransactionDate,
[Max Flokemon Sales] = concat(max(std.SalesQty), ' Flokemon')
from SalesTransaction st
join SalesTransactionDetail std on st.SalesID = std.SalesID,
(
	select [Year] = year(st2.SalesTransactionDate)
	from SalesTransaction st2
	where year(st2.SalesTransactionDate) = 2020
) as YearConstraint
where year(st.SalesTransactionDate) = YearConstraint.Year
and month(st.SalesTransactionDate) between 7 and 12
group by st.SalesTransactionDate

-- no 8
select [Transaction Date] = pt.PurchasedTransactionDate,
[Max Flokemon Purchased] = concat(max(ptd.PurchasedQty), ' Flokemon')
from Staff s
join PurchaseTransaction pt on s.StaffID = pt.StaffID
join PurchaseTransactionDetail ptd on pt.PurchaseID = ptd.PurchaseID,
(
	select [Year] = year(pt2.PurchasedTransactionDate)
	from PurchaseTransaction pt2
	where year(pt2.PurchasedTransactionDate) = 2018
) as YearConstraint
where year(pt.PurchasedTransactionDate) = YearConstraint.Year
and month(pt.PurchasedTransactionDate) between 1 and 10
and s.StaffName like '%o%'
group by pt.PurchasedTransactionDate

-- no 9
create view PurchaseView 
as
select 
s.SupplierName,
[Supplier Phone]= replace(s.SupplierPhoneNo,'0','+62'),
[Total Transaction]= count(ptd.PurchasedQty),
[Total Flokemon Bought]= sum(ptd.PurchasedQty)
from Supplier s
join PurchaseTransaction pt on s.SupplierID= pt.SupplierID
join PurchaseTransactionDetail ptd on pt.PurchaseID = ptd.PurchaseID
where ptd.PurchasedQty between 1 and 5
and len(s.SupplierName) < 15
group by s.SupplierName, replace(s.SupplierPhoneNo,'0','+62')

--10
create view StaffSalesView
as
Select
s.StaffName,
[Total Transaction]= count(std.SalesQty),
[Total Flokemon Sold]= sum(std.SalesQty)
From Staff s
join SalesTransaction st on s.StaffID= st.StaffID
join SalesTransactionDetail std on st.SalesID = std.SalesID
where len(s.StaffName) < 15 
and std.SalesQty > 10
group by s.StaffName
