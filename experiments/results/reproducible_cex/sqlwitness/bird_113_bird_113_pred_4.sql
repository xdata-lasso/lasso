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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (98832, 'default2', 'default1', 'default1', 'default1', '1996-01-03', '1996-01-03', 98833, 98831, 0.0, 98832, 98833.0, 98831.0, 98833, NULL, 98833), (0, '1996-01-03', 'default1', '1996-01-03', '1996-01-03', 'default1', 'default2', 98832, 98831, 98831.0, 0, 98833.0, 98833.0, 98833, NULL, 98831), (1, 'default1', '1996-01-03', 'default1', 'default2', '1996-01-03', 'default2', 98833, 98833, 98833.0, 98831, 0.0, 98831.0, 98832, 98833, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (98831, 98832, 'default2', '1996-01-02'), (98832, 0, '1996-01-03', '2023-01-02'), (98833, 0, '1996-01-03', '1996-01-02'), (0, 1, 'default1', '1996-01-04'), (1, 1, '1996-01-03', '1996-01-02'), (2, 1, 'default2', '1996-01-03'), (3, 98832, 'default2', '1996-01-04'), (4, 98832, 'default2', '2023-01-02'), (5, 0, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'default1', '2023-01-01'), (98832, 98832, 'default1', '1996-01-02'), (98833, 0, 'default1', '2023-01-01'), (0, 98832, 'default2', '1996-01-03'), (98831, 1, 'default1', '2023-01-02'), (2, 98832, 'default2', '1996-01-02'), (3, 1, '1996-01-03', '1996-01-04'), (4, 98832, 'default1', '1996-01-04'), (5, 1, 'default2', '1996-01-04'), (6, 98832, 'default1', '1996-01-04');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (98832, 1, '1996-01-03', 98832, 98832, 98831.0, 'default2'), (98831, 4, '1996-01-02', 98832, 98832, 0.0, 'default2'), (98833, 6, '2023-01-02', 98832, 1, 98833.0, 'default1'), (1, 1, '2023-01-01', 0, 98833, 98832.0, 'default2'), (0, 6, '2023-01-01', 0, 98833, 0.0, '1996-01-03'), (2, 0, '2023-01-01', 98832, 98832, 0.0, 'default2'), (3, 98833, '2023-01-01', 98833, 98831, 98833.0, '1996-01-03'), (4, 5, '1996-01-04', 98831, 0, 98831.0, '1996-01-03'), (5, 98831, '1996-01-03', 98832, 98831, 98833.0, 'default2'), (6, 1, '2023-01-02', 98833, 0, 98833.0, 'default2'), (7, 3, '1996-01-04', 98831, 98832, 98833.0, 'default1'), (8, 98833, '1996-01-03', 98831, 0, 98833.0, 'default2'), (9, 4, '1996-01-04', 98832, 98831, 98833.0, 'default2');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (98833, 4, 2, '1996-01-03'), (1, 5, 0, 'default1'), (0, 1, 1, '1996-01-03'), (98832, 3, 98832, 'default2'), (98831, 5, 2, 'default1'), (2, 0, 1, 'default2'), (3, 98831, 2, '1996-01-03'), (4, 0, 98833, 'default2'), (5, 98831, 0, 'default1'), (6, 98832, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('1996-01-02',)
('1996-01-03',)
('1996-01-04',)
('1996-01-02',)
('1996-01-03',)
('1996-01-04',)
*/

-- Prediction Query
SELECT c.birth_date FROM loan AS l JOIN disp AS d ON l.account_id = d.account_id JOIN client AS c ON d.client_id = c.client_id WHERE l.amount = 98832 AND l.date = '1996-01-03';

/*
Prediction Result:
('1996-01-02',)
('1996-01-03',)
('1996-01-04',)
*/