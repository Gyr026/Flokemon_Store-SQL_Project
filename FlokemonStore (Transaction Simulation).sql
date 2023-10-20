use FlokemonStore
go

--there is a new type of flokemon called 'Keldeo' and 'Flikachu'
insert into Flokemon values
('FL026','FT003','Keldeo','500','500000'),
('FL027','FT005','Flikachu','600','750000')

--currently the flokemon store wants to buy these 2 new flokemon from the supplier
--below is the staff buying the flokemon 'Keldeo'
insert into PurchaseTransaction values
('PU016','ST005','SU006','2018-04-15')
insert into PurchaseTransactionDetail values
('PU016','FL026','5')

--below is the staff buying the flokemon 'Flikachu'
insert into PurchaseTransaction values
('PU017','ST007','SU006','2018-04-15')
insert into PurchaseTransactionDetail values
('PU017','FL027','10')

--The customer then buys the new flokemon from the staff
--below is the customer buying the flokemon 'Keldeo'
insert into SalesTransaction values
('SA016','ST010','CU002','2020-04-16')
insert into SalesTransactionDetail values
('SA016','FL026','3')

--below is the customer buying the flokemon 'Flikachu'
insert into SalesTransaction values
('SA017','ST001','CU009','2020-04-18')
insert into SalesTransactionDetail values
('SA017','FL027','8')
