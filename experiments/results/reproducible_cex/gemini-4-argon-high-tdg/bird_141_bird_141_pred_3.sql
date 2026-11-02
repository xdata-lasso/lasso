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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Dist1', 'Reg1', '10000', '10', '10', '10', 1, 1, 50.0, 8500, 1.2, 2.3, 100, 150, 200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Dist2', 'Reg2', '20000', '20', '20', '20', 2, 2, 60.0, 9000, 1.5, 2.5, 110, 160, 210);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Dist3', 'Reg3', '30000', '30', '30', '30', 3, 3, 70.0, 9500, 1.8, 2.8, 120, 170, 220);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1995-01-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 2, 'POPLATEK MESICNE', '1995-02-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (301, 3, 'POPLATEK MESICNE', '1995-03-15');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1001, 101, '1997-03-10', 'PRIJEM', 'VKLAD', 6000, 2000, 'UROK', 'AB', 1111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1002, 101, '1997-07-20', 'PRIJEM', 'VKLAD', 6000, 2000, 'UROK', 'AB', 1111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (2001, 201, '1997-04-12', 'PRIJEM', 'VKLAD', 6000, 15000, 'UROK', 'CD', 2222);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (2002, 201, '1997-08-25', 'PRIJEM', 'VKLAD', 4000, 15000, 'UROK', 'CD', 2222);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3001, 301, '1997-05-05', 'PRIJEM', 'VKLAD', 5000, 25000, 'UROK', 'EF', 3333);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T1.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1997' GROUP BY T1.district_id HAVING SUM(T3.amount) > 10000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT district.A2 FROM district JOIN account ON district.district_id = account.district_id JOIN trans ON account.account_id = trans.account_id WHERE trans.amount > 10000 AND STRFTIME('%Y', trans.date) = '1997';

/*
Prediction Result:
*/