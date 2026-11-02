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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (50, 'Alpha', 'RegionZ', '10000', '10', '5', '2', 1, 1, 50.5, 8000, 1.2, 2.3, 100, 200, 300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (40, 'Beta', 'RegionY', '20000', '12', '6', '3', 2, 1, 60.0, 8500, 1.5, 2.5, 110, 210, 310);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'Gamma', 'RegionX', '30000', '14', '7', '4', 1, 2, 70.0, 9000, 2.0, 3.0, 120, 220, 320);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (30, 'Gamma', 'RegionW', '40000', '16', '8', '5', 3, 2, 80.0, 9500, 2.5, 3.5, 130, 230, 330);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Omega', 'RegionA', '50000', '18', '9', '6', 2, 3, 90.0, 10000, 3.0, 4.0, 140, 240, 340);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Zeta', 'RegionB', '60000', '20', '10', '7', 1, 1, 55.0, 10500, 3.5, 4.5, 150, 250, 350);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (500, 50, 'POPLATEK MESICNE', '1996-01-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (501, 50, 'POPLATEK MESICNE', '1996-01-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (400, 40, 'POPLATEK MESICNE', '1996-01-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (300, 20, 'POPLATEK MESICNE', '1996-01-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 30, 'POPLATEK MESICNE', '1996-01-12');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 10, 'POPLATEK MESICNE', '1996-01-25');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 5, 'POPLATEK MESICNE', '1996-01-30');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (900, 500, '1996-05-01', 'VYDAJ', 'VYBER', 100, 1000, 'SIPO', 'AB', 111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (899, 500, '1996-05-02', 'VYDAJ', 'VYBER', 200, 800, 'SIPO', 'AB', 111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (850, 501, '1996-05-03', 'VYDAJ', 'VYBER', 150, 1500, 'SIPO', 'CD', 222);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (800, 400, '1996-05-04', 'VYDAJ', 'VYBER', 300, 2000, 'SIPO', 'EF', 333);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (799, 400, '1996-05-05', 'VYDAJ', 'VYBER', 400, 1600, 'SIPO', 'EF', 333);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (700, 300, '1996-05-06', 'VYDAJ', 'VYBER', 500, 3000, 'SIPO', 'GH', 444);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (699, 300, '1996-05-07', 'VYDAJ', 'VYBER', 600, 2400, 'SIPO', 'GH', 444);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (600, 200, '1996-05-08', 'VYDAJ', 'VYBER', 700, 4000, 'SIPO', 'IJ', 555);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (599, 200, '1996-05-09', 'VYDAJ', 'VYBER', 800, 3200, 'SIPO', 'IJ', 555);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (500, 100, '1996-05-10', 'VYDAJ', 'VYBER', 900, 5000, 'SIPO', 'KL', 666);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (400, 50, '1996-05-11', 'VYDAJ', 'VYBER', 1000, 6000, 'SIPO', 'MN', 777);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (399, 50, '1996-05-12', 'VYDAJ', 'VYBER', 1100, 4900, 'SIPO', 'MN', 777);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T2.date LIKE '1996-01%' ORDER BY A2 ASC, T1.district_id NULLS LAST, T2.account_id NULLS LAST, T3.trans_id NULLS LAST LIMIT 10;

/*
Gold Result:
(50,)
(50,)
(50,)
(40,)
(40,)
(20,)
(20,)
(30,)
(30,)
(10,)
*/

-- Prediction Query
SELECT T1.A2, SUM(T3.amount) AS total_amount FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T3.date LIKE '1996-01%' GROUP BY T1.A2 ORDER BY total_amount DESC, T1.A2 NULLS LAST LIMIT 10;

/*
Prediction Result:
*/