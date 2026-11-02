-- Schema DDL
CREATE TABLE account (account_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, district_id INTEGER DEFAULT 0 NOT NULL, frequency TEXT NOT NULL, date DATE NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE card (card_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, disp_id INTEGER NOT NULL, type TEXT NOT NULL, issued DATE NOT NULL, FOREIGN KEY (disp_id) REFERENCES disp (disp_id));

CREATE TABLE client (client_id INTEGER NOT NULL PRIMARY KEY, gender TEXT NOT NULL, birth_date DATE NOT NULL, district_id INTEGER NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE disp (disp_id INTEGER NOT NULL PRIMARY KEY, client_id INTEGER NOT NULL, account_id INTEGER NOT NULL, type TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (client_id) REFERENCES client (client_id));

CREATE TABLE district (district_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, A2 TEXT NOT NULL, A3 TEXT NOT NULL, A4 TEXT NOT NULL, A5 TEXT NOT NULL, A6 TEXT NOT NULL, A7 TEXT NOT NULL, A8 INTEGER NOT NULL, A9 INTEGER NOT NULL, A10 REAL NOT NULL, A11 INTEGER NOT NULL, A12 REAL NULL, A13 REAL NOT NULL, A14 INTEGER NOT NULL, A15 INTEGER NULL, A16 INTEGER NOT NULL);

CREATE TABLE loan (loan_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, date DATE NOT NULL, amount INTEGER NOT NULL, duration INTEGER NOT NULL, payments REAL NOT NULL, status TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE "order" (order_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, bank_to TEXT NOT NULL, account_to INTEGER NOT NULL, amount REAL NOT NULL, k_symbol TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE trans (trans_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER DEFAULT 0 NOT NULL, date DATE NOT NULL, type TEXT NOT NULL, operation TEXT NULL, amount INTEGER NOT NULL, balance INTEGER NOT NULL, k_symbol TEXT NULL, bank TEXT NULL, account INTEGER NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Dist1', 'Reg1', '10000', '10', '5', '2', 1, 1, 50.0, 8000, 1.5, 2.0, 100, 1000, 1200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Dist5', 'Reg5', '20000', '20', '10', '4', 2, 2, 60.0, 9000, 2.5, 3.0, 110, 2000, 2200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (9, 'Dist9', 'Reg9', '30000', '30', '15', '6', 3, 3, 70.0, 10000, 3.5, 4.0, 120, 3000, 3200);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 1, 'POPLATEK TYDNE', '1993-01-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 1, 'POPLATEK MESICNE', '1997-02-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (300, 5, 'POPLATEK TYDNE', '1997-03-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (400, 5, 'POPLATEK TYDNE', '1997-04-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (500, 5, 'POPLATEK TYDNE', '1995-06-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (900, 9, 'POPLATEK TYDNE', '1997-05-20');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (10, 100, '1997-01-10', 2000, 12, 100.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (20, 200, '1997-04-10', 100, 12, 10.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (30, 300, '1996-12-31', 200, 12, 20.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (40, 400, '1998-01-01', 300, 12, 30.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (50, 500, '1997-06-15', 1000, 36, 500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (51, 500, '1997-08-20', 8000, 48, 600.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (90, 900, '1997-11-20', 3000, 60, 900.0, 'A');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1000, 'M', '1970-01-01', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1000, 1000, 100, 'OWNER');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 100, 'AB', 12345, 50.0, 'SIPO');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 100, '1997-02-01', 'PRIJEM', 'VKLAD', 50, 1000, 'UROK', 'AB', 12345);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(500,)
*/

-- Prediction Query
SELECT "a"."account_id" FROM "account" AS "a" INNER JOIN "loan" AS "l" ON "a"."account_id" = "l"."account_id" WHERE STRFTIME('%Y', "l"."date") = '1997' AND "a"."frequency" = 'POPLATEK TYDNE' AND "l"."amount" = (SELECT MIN("amount") FROM "loan" AS "l2" WHERE STRFTIME('%Y', "l2"."date") = '1997' AND "l2"."account_id" = "l"."account_id");

/*
Prediction Result:
(100,)
(500,)
(900,)
*/