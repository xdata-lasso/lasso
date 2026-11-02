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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'default1', 'default2', 'default1', 'default2', '1996-01-03', 1, 0, 0.0, 98832, 0.0, 1.0, 98831, NULL, 98832), (98831, 'default2', 'default1', '1996-01-03', 'default1', 'default2', 'default1', 1, 98831, 1.0, 0, 98832.0, 98833.0, 1, 98833, 98833);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (98833, 1, '1996-01-03', '2023-01-01'), (1, 1, '1996-01-03', '2023-01-02'), (98831, 98831, 'default2', '1996-01-03'), (98832, 98831, 'default2', '1996-01-03'), (0, 1, '1996-01-03', '1996-01-04'), (2, 1, 'default2', '1996-01-04'), (3, 1, '1996-01-03', '2023-01-02'), (4, 1, 'default2', '2023-01-01'), (5, 98831, 'default2', '1996-01-02'), (6, 98831, 'default1', '1996-01-04'), (7, 98831, 'default1', '1996-01-04'), (8, 1, 'default1', '1996-01-04'), (9, 1, 'default1', '2023-01-02'), (10, 1, 'default2', '1996-01-02'), (11, 1, 'default1', '1996-01-04'), (12, 1, 'default2', '2023-01-01'), (13, 98831, 'default1', '1996-01-04'), (14, 98831, 'default2', '2023-01-02'), (15, 98831, 'default2', '1996-01-04'), (16, 1, 'default2', '1996-01-04'), (17, 1, '1996-01-03', '1996-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (98832, 98831, 'default1', '1996-01-02'), (98833, 98831, '1996-01-03', '1996-01-03'), (98831, 1, 'default2', '1996-01-04'), (0, 98831, 'default2', '1996-01-03');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 98833, '2023-01-02', 98831, 0, 98831.0, 'default2'), (0, 98831, '1996-01-03', 98833, 98833, 98832.0, 'default1'), (98831, 98833, '1996-01-03', 1, 0, 98833.0, 'default1'), (98832, 0, '2023-01-01', 98831, 98832, 0.0, 'default1'), (98833, 98833, '1996-01-02', 98833, 98831, 0.0, 'default1'), (2, 98832, '1996-01-02', 98831, 98831, 98833.0, 'default1'), (3, 0, '1996-01-03', 1, 0, 98833.0, '1996-01-03'), (4, 98831, '1996-01-03', 1, 98831, 0.0, '1996-01-03'), (5, 0, '2023-01-01', 1, 98833, 98832.0, 'default2'), (6, 98833, '1996-01-03', 98831, 1, 0.0, 'default1'), (7, 98832, '2023-01-02', 0, 0, 98833.0, 'default2'), (8, 98832, '1996-01-03', 98832, 1, 0.0, 'default2'), (9, 98832, '1996-01-03', 98831, 98832, 98832.0, 'default1'), (10, 98833, '1996-01-02', 98832, 98833, 98832.0, 'default1'), (11, 98833, '1996-01-03', 98833, 0, 98831.0, '1996-01-03'), (12, 98831, '1996-01-02', 98831, 98833, 0.0, '1996-01-03'), (13, 98831, '2023-01-02', 0, 98833, 98833.0, '1996-01-03'), (14, 98833, '1996-01-03', 98832, 98833, 98831.0, 'default2'), (15, 98831, '2023-01-01', 1, 98831, 0.0, 'default2'), (16, 98832, '2023-01-01', 0, 98833, 1.0, 'default1'), (17, 0, '1996-01-02', 98832, 1, 98832.0, '1996-01-03'), (18, 0, '2023-01-01', 0, 98833, 98831.0, '1996-01-03'), (19, 98832, '1996-01-04', 98833, 1, 98832.0, 'default2'), (20, 98831, '1996-01-04', 1, 98833, 98831.0, 'default2');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (98831, 98833, 98832, 'default2'), (1, 0, 98831, 'default2'), (0, 0, 10, 'default1'), (98833, 98833, 98831, 'default1'), (98832, 98833, 15, 'default1'), (2, 98831, 2, 'default2'), (3, 0, 11, 'default1'), (4, 98832, 16, 'default2'), (5, 98832, 14, '1996-01-03'), (6, 98833, 6, '1996-01-03'), (7, 0, 10, 'default1'), (8, 0, 15, 'default1'), (9, 98832, 98833, 'default1'), (10, 98831, 98832, 'default2'), (11, 0, 98833, 'default1'), (12, 0, 10, 'default2'), (13, 98831, 14, '1996-01-03'), (14, 0, 1, '1996-01-03'), (15, 98832, 2, 'default1'), (16, 0, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('1996-01-02',)
('1996-01-03',)
('1996-01-03',)
('1996-01-04',)
('1996-01-04',)
('1996-01-04',)
('1996-01-04',)
('2023-01-02',)
('1996-01-02',)
('1996-01-03',)
('1996-01-03',)
('1996-01-04',)
('1996-01-04',)
('1996-01-04',)
('1996-01-04',)
('2023-01-02',)
*/

-- Prediction Query
SELECT client.birth_date FROM loan INNER JOIN disp ON loan.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE loan.amount = 98832 AND loan.date = '1996-01-03';

/*
Prediction Result:
('1996-01-04',)
('2023-01-02',)
('1996-01-04',)
('2023-01-01',)
('1996-01-04',)
('1996-01-03',)
('1996-01-04',)
('1996-01-03',)
*/