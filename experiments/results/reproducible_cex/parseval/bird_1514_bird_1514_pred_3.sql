-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 't3__f50da1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'dlttil', 't3__f50da1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'zbuo4nrqrof', 't3__f50da1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'cgsk9', '8c4p');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'p6luhvdlttil', 'n');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'c4ecigce', '76nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'ut', 'iqa');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'x58pz0f8jeg', 'd21vy9uxj4hw');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, 247012447, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 429706943, 'rmdp', 'siie');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1408123494, '4', 'ecigce376n');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1871297066, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 462974032, 'posiie5unw6k', 'fa9');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, -443340271, 'uo4nrqrofqy', '5s5b');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, -314162272, 'ytoo3o9', 'l7');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 244829661, 'jsl', 'b4yp5qi');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, -2050247126, 'lph2gn', 'q');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '16:25:00', 1, 1644814318, 1, 1465859724, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', '16:25:00', 1, -45536098, 1, 1861536320, 44952191, 768.216462);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', '16:25:00', 1, 1620389964, 1, 546571701, 947159877, 963.351729);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', '16:25:00', 1, 1313172851, 3, -761141909, 283598170, 452.706544);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', '16:25:00', 3, 373262291, 1, -472966518, -921187550, 718.756092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', '16:25:00', 1, -2070843029, 3, 328305758, -751275471, 186.190286);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2012-08-24', '16:25:00', 3, 1673584235, 1, -2118135981, 2074205376, 274.580687);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2012-08-24', '16:25:00', 1, 274769912, 3, -188151580, 226938182, 187.343342);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-24', '16:25:00', 3, 90119032, 1, -1438850342, -305670381, 144.777217);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', '16:25:00', 1, -453362185, 1, 481163439, 2123196517, 920.013763);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', '16:25:00', 1, 364869063, 1, -953437896, -1097120355, 326.912005);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2024-06-15', '16:25:00', 1, 244829661, 1, -1362461264, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2012-08-24', 't1__43fa05', 1, 1692174491, 1, -1025564911, -227162283, 164.583726);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-24', NULL, 3, -55602865, 3, -59984348, -664303813, 833.684115);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 't1__98148f', 4, 700293388, 4, 906324270, 1908028688, 994.117864);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-06-15', NULL, 5, 1620389964, 5, 546571701, 947159877, 963.351729);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, NULL, '16:25:00', 6, 2107872094, 6, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, 't1__98148f', 7, 1178636309, 7, -1390245819, 1055976837, 913.303855);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, NULL, 8, -227162283, 8, 2056419640, 222415430, 263.638479);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
('t3__f50da1',)
('t3__f50da1',)
('t3__f50da1',)
('t3__f50da1',)
('8c4p',)
('t3__f50da1',)
('8c4p',)
('t3__f50da1',)
('8c4p',)
('t3__f50da1',)
('t3__f50da1',)
*/

-- Prediction Query
SELECT customers.Currency FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-24' AND transactions_1k."Time" = '16:25:00' AND customers.Segment = 'SME';

/*
Prediction Result:
*/