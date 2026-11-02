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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '1996-01-03', 'default2', 'default1', 'default1', '1996-01-03', 'default2', 98832, 0, 1.0, 1, 98831.0, 0.0, 1, NULL, 98831), (98831, 'default2', '1996-01-03', 'default2', '1996-01-03', '1996-01-03', 'default2', 98831, 1, 98831.0, 98831, 98833.0, 1.0, 98831, 98831, 0), (98832, '1996-01-03', 'default2', '1996-01-03', '1996-01-03', 'default1', 'default1', 98832, 0, 98833.0, 1, NULL, 98833.0, 0, 98831, 0), (0, '1996-01-03', 'default2', '1996-01-03', 'default2', '1996-01-03', 'default2', 1, 1, 0.0, 0, 98832.0, 98831.0, 98833, 1, 1), (98833, '1996-01-03', 'default1', '1996-01-03', '1996-01-03', 'default1', 'default1', 0, 98832, 98831.0, 0, NULL, 98831.0, 0, NULL, 98833), (2, 'default1', 'default2', '1996-01-03', '1996-01-03', 'default2', '1996-01-03', 0, 98833, 98833.0, 98832, 98833.0, 98832.0, 98832, 0, 1), (3, 'default1', 'default2', '1996-01-03', 'default1', '1996-01-03', '1996-01-03', 0, 98831, 98833.0, 0, 98832.0, 0.0, 0, 98833, 0), (4, 'default2', '1996-01-03', 'default2', 'default1', '1996-01-03', 'default1', 0, 98833, 0.0, 98833, 98832.0, 98831.0, 98833, 1, 98833), (5, 'default1', 'default1', 'default2', 'default1', '1996-01-03', '1996-01-03', 1, 0, 98832.0, 98833, 0.0, 98832.0, 98833, 1, 98832), (6, '1996-01-03', 'default1', '1996-01-03', 'default2', '1996-01-03', 'default1', 1, 1, 98831.0, 98831, 98833.0, 1.0, 98831, 1, 98831), (7, 'default2', 'default2', '1996-01-03', 'default2', '1996-01-03', '1996-01-03', 0, 98833, 98833.0, 98832, 98833.0, 98831.0, 98833, NULL, 0), (8, '1996-01-03', 'default2', 'default1', '1996-01-03', 'default1', '1996-01-03', 0, 98833, 98832.0, 1, 98832.0, 98833.0, 98832, 98833, 0), (9, 'default1', 'default1', 'default2', 'default2', 'default2', 'default2', 98833, 1, 98831.0, 98833, 98833.0, 98831.0, 98832, 98833, 98833), (10, 'default2', '1996-01-03', 'default2', 'default1', '1996-01-03', 'default1', 98831, 98833, 98832.0, 98831, 1.0, 98831.0, 0, 0, 98831), (11, '1996-01-03', '1996-01-03', 'default2', 'default1', 'default1', 'default1', 98832, 98831, 98832.0, 98833, 0.0, 98833.0, 1, 1, 98832), (12, '1996-01-03', '1996-01-03', 'default2', 'default2', 'default2', '1996-01-03', 98833, 98833, 1.0, 98831, 98832.0, 98831.0, 98833, NULL, 1), (13, 'default1', '1996-01-03', 'default1', 'default2', 'default1', 'default1', 98833, 0, 98831.0, 1, 0.0, 98832.0, 98831, 0, 0), (14, 'default2', '1996-01-03', 'default2', 'default1', 'default1', 'default1', 0, 1, 1.0, 98832, 98833.0, 0.0, 98833, 98833, 98833), (15, '1996-01-03', 'default1', 'default1', 'default2', 'default2', 'default1', 98831, 98832, 98831.0, 98833, 98832.0, 0.0, 1, NULL, 98832), (16, 'default2', 'default1', 'default1', '1996-01-03', '1996-01-03', '1996-01-03', 98832, 98831, 98833.0, 98832, 98831.0, 98833.0, 1, 98832, 98832), (17, 'default2', 'default2', 'default2', '1996-01-03', '1996-01-03', 'default2', 98833, 0, 98832.0, 0, 98831.0, 1.0, 0, 98833, 98831), (18, 'default1', 'default1', 'default2', '1996-01-03', 'default2', 'default1', 98832, 98833, 98832.0, 98832, 1.0, 98832.0, 0, 98833, 0), (19, 'default1', 'default2', '1996-01-03', 'default2', 'default2', '1996-01-03', 98833, 98832, 1.0, 98832, NULL, 98831.0, 98832, 0, 1), (20, 'default1', 'default2', 'default2', 'default1', 'default1', 'default2', 98833, 98832, 1.0, 98832, 98831.0, 1.0, 98832, 98831, 98832), (21, 'default2', 'default2', '1996-01-03', '1996-01-03', 'default2', 'default2', 0, 0, 98832.0, 98833, 0.0, 98831.0, 98831, 0, 1), (22, '1996-01-03', 'default2', '1996-01-03', '1996-01-03', 'default1', '1996-01-03', 98833, 98832, 98831.0, 98831, 1.0, 1.0, 98833, 98833, 1), (23, 'default1', 'default1', '1996-01-03', 'default2', 'default1', 'default1', 98832, 98831, 98832.0, 98831, 98833.0, 98832.0, 1, 98831, 98833), (24, 'default2', 'default1', 'default1', 'default1', '1996-01-03', '1996-01-03', 98833, 98831, 98832.0, 98831, 98833.0, 1.0, 0, 0, 1), (25, 'default1', '1996-01-03', 'default1', '1996-01-03', 'default2', 'default1', 98831, 0, 98831.0, 98831, NULL, 98833.0, 98832, 1, 98831), (26, 'default2', 'default2', 'default1', '1996-01-03', '1996-01-03', 'default2', 98832, 0, 98833.0, 98833, 98833.0, 1.0, 98832, 98831, 1), (27, 'default1', 'default2', '1996-01-03', 'default2', 'default1', 'default1', 98833, 1, 98832.0, 98833, 98832.0, 98833.0, 98832, 1, 1), (28, 'default1', 'default1', 'default1', 'default1', 'default2', 'default1', 98833, 98831, 98832.0, 98832, NULL, 1.0, 98831, NULL, 1), (29, 'default1', 'default1', 'default2', 'default1', 'default2', '1996-01-03', 98833, 98831, 98832.0, 98833, 1.0, 98831.0, 98833, 98831, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 22, 'default1', '1996-01-04'), (98831, 20, 'default1', '2023-01-01'), (98833, 22, 'default1', '1996-01-04'), (0, 12, 'default1', '2023-01-02'), (98832, 98831, 'default1', '1996-01-02'), (2, 16, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 12, '1996-01-03', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (98831, 1, '2023-01-01', 1, 0, 98831.0, 'default2'), (98833, 1, '1996-01-03', 0, 98832, 98833.0, '1996-01-03'), (98832, 1, '1996-01-02', 1, 1, 0.0, '1996-01-03'), (1, 1, '2023-01-02', 0, 98831, 0.0, 'default1'), (0, 1, '2023-01-01', 0, 1, 98832.0, 'default1'), (2, 1, '1996-01-02', 98831, 98833, 0.0, 'default2'), (3, 1, '2023-01-01', 98833, 1, 98831.0, 'default1'), (4, 1, '2023-01-02', 0, 98832, 98832.0, 'default2'), (5, 1, '1996-01-02', 1, 98833, 98833.0, 'default1'), (6, 1, '1996-01-03', 98832, 98831, 0.0, '1996-01-03'), (7, 1, '1996-01-04', 98832, 98831, 98833.0, 'default1'), (8, 1, '2023-01-02', 98832, 98832, 98833.0, 'default2'), (9, 1, '1996-01-02', 0, 98831, 98832.0, 'default2'), (10, 1, '1996-01-03', 98833, 1, 0.0, 'default1'), (11, 1, '1996-01-02', 98832, 98831, 0.0, 'default2'), (12, 1, '2023-01-02', 98832, 98832, 98831.0, '1996-01-03'), (13, 1, '2023-01-01', 98832, 98833, 0.0, 'default1'), (14, 1, '1996-01-03', 98831, 98832, 98833.0, '1996-01-03'), (15, 1, '1996-01-03', 98832, 1, 98832.0, 'default2'), (16, 1, '1996-01-03', 98833, 98831, 98832.0, 'default2'), (17, 1, '1996-01-03', 98831, 98832, 98831.0, 'default1'), (18, 1, '1996-01-03', 98833, 98832, 98833.0, 'default1'), (19, 1, '1996-01-04', 0, 0, 0.0, '1996-01-03'), (20, 1, '2023-01-01', 98832, 1, 98832.0, 'default2'), (21, 1, '2023-01-02', 0, 1, 98833.0, 'default2'), (22, 1, '1996-01-02', 98833, 0, 98831.0, 'default2'), (23, 1, '1996-01-03', 1, 1, 98831.0, '1996-01-03'), (24, 1, '1996-01-04', 98833, 98831, 1.0, '1996-01-03'), (25, 1, '2023-01-01', 98832, 0, 1.0, '1996-01-03'), (26, 1, '1996-01-02', 98831, 1, 98833.0, 'default2'), (27, 1, '2023-01-01', 1, 0, 98833.0, '1996-01-03'), (28, 1, '1996-01-02', 1, 98833, 98831.0, 'default2'), (29, 1, '1996-01-03', 0, 0, 98833.0, 'default2'), (30, 1, '2023-01-01', 98831, 98831, 98833.0, '1996-01-03');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (98831, 1, 1, 'default1'), (1, 1, 1, 'default1'), (98832, 1, 98831, '1996-01-03'), (0, 1, 2, 'default2'), (98833, 1, 2, 'default1'), (2, 1, 98832, 'default2'), (3, 1, 1, 'default2'), (4, 1, 0, 'default2'), (5, 1, 0, '1996-01-03'), (6, 1, 2, '1996-01-03'), (7, 1, 2, 'default1'), (8, 1, 98833, '1996-01-03'), (9, 1, 0, 'default1'), (10, 1, 98833, 'default2'), (11, 1, 98833, 'default1'), (12, 1, 2, '1996-01-03'), (13, 1, 0, '1996-01-03'), (14, 1, 98832, 'default2'), (15, 1, 98831, 'default2'), (16, 1, 98832, 'default1'), (17, 1, 2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('2023-01-02',)
('2023-01-02',)
*/

-- Prediction Query
SELECT "client"."birth_date" FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "loan" ON "disp"."account_id" = "loan"."account_id" WHERE "loan"."amount" = 98832 AND "loan"."date" = '1996-01-03';

/*
Prediction Result:
('2023-01-02',)
('2023-01-02',)
('1996-01-04',)
('1996-01-04',)
('1996-01-02',)
('1996-01-02',)
('1996-01-04',)
('1996-01-04',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('1996-01-04',)
('1996-01-04',)
('2023-01-02',)
('2023-01-02',)
('1996-01-04',)
('1996-01-04',)
('1996-01-04',)
('1996-01-04',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('2023-01-02',)
('1996-01-02',)
('1996-01-02',)
('2023-01-01',)
('2023-01-01',)
('1996-01-02',)
('1996-01-02',)
('2023-01-02',)
('2023-01-02',)
('1996-01-04',)
('1996-01-04',)
('2023-01-01',)
('2023-01-01',)
('2023-01-02',)
('2023-01-02',)
*/