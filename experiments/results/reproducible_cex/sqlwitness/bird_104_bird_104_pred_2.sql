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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (841, 'default2', '1998-10-14', '1998-10-14', 'default2', '1998-10-14', 'default1', 841, 0, 840.0, 839, NULL, 0.0, 1, NULL, 1), (1, '1998-10-14', 'default2', '1998-10-14', 'default2', '1998-10-14', 'default2', 839, 0, 841.0, 840, 1.0, 841.0, 1, 0, 1), (839, 'default1', 'default2', '1998-10-14', 'default1', 'default2', 'default1', 839, 841, 839.0, 0, 841.0, 840.0, 0, 0, 841), (840, 'default2', 'default1', '1998-10-14', 'default2', 'default1', 'default2', 841, 841, 840.0, 839, 839.0, 841.0, 840, 840, 1), (0, 'default2', '1998-10-14', 'default2', 'default2', '1998-10-14', '1998-10-14', 840, 839, 841.0, 1, 0.0, 839.0, 840, 840, 1), (2, '1998-10-14', 'default2', 'default2', '1998-10-14', 'default1', '1998-10-14', 840, 840, 0.0, 1, 840.0, 1.0, 841, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 1, 'default1', '1998-10-13'), (840, 1, '1998-10-14', '1998-10-14'), (839, 0, 'default1', '1998-10-13'), (1, 841, '1998-10-14', '2023-01-01'), (841, 839, 'default1', '2023-01-01'), (2, 1, 'default2', '2023-01-02'), (3, 841, 'default2', '1998-10-15'), (4, 840, '1998-10-14', '1998-10-15'), (5, 0, 'default1', '1998-10-15'), (6, 840, '1998-10-14', '2023-01-02'), (7, 840, 'default2', '1998-10-14'), (8, 1, 'default1', '1998-10-14'), (9, 1, 'default2', '2023-01-01'), (10, 841, 'default2', '1998-10-13'), (11, 2, 'default1', '2023-01-02'), (12, 839, '1998-10-14', '2023-01-02'), (13, 2, 'default2', '1998-10-13'), (14, 2, 'default1', '2023-01-01'), (15, 1, '1998-10-14', '2023-01-01'), (16, 2, '1998-10-14', '1998-10-13'), (17, 841, 'default2', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (840, 10, '2023-01-02', 'default1', '1998-10-14', 0, 0, 'default1', 'default1', 1), (1, 8, '2023-01-02', 'default2', NULL, 841, 839, 'default1', '1998-10-14', 1), (839, 11, '2023-01-01', 'default2', NULL, 840, 1, 'default2', 'default2', 841), (841, 7, '1998-10-13', 'default2', NULL, 840, 839, NULL, 'default1', 841), (0, 8, '1998-10-14', 'default2', 'default2', 840, 840, NULL, '1998-10-14', NULL), (2, 2, '1998-10-14', '1998-10-14', '1998-10-14', 840, 839, 'default2', 'default2', NULL), (3, 841, '2023-01-02', 'default1', 'default2', 841, 840, 'default2', '1998-10-14', 841), (4, 1, '1998-10-13', 'default2', NULL, 1, 1, 'default1', '1998-10-14', 0), (5, 4, '1998-10-15', '1998-10-14', '1998-10-14', 1, 1, NULL, NULL, NULL), (6, 16, '2023-01-02', 'default1', NULL, 840, 0, 'default1', 'default2', 841), (7, 840, '1998-10-15', 'default2', 'default1', 840, 0, NULL, 'default1', NULL), (8, 1, '1998-10-14', '1998-10-14', NULL, 840, 839, '1998-10-14', '1998-10-14', 1), (9, 3, '1998-10-13', 'default2', '1998-10-14', 840, 0, '1998-10-14', NULL, 839), (10, 840, '2023-01-01', 'default2', NULL, 1, 1, 'default2', 'default2', 841), (11, 3, '1998-10-15', 'default2', 'default1', 839, 839, 'default1', 'default1', 839), (12, 8, '1998-10-14', 'default2', NULL, 840, 841, '1998-10-14', 'default2', 840);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 12, 'default2', 0, 1.0, 'default1'), (0, 11, '1998-10-14', 841, 1.0, '1998-10-14'), (841, 3, '1998-10-14', 840, 0.0, 'default1'), (840, 3, 'default2', 839, 840.0, 'default2'), (839, 840, 'default1', 1, 0.0, '1998-10-14'), (2, 0, 'default2', 841, 839.0, 'default1'), (3, 14, '1998-10-14', 839, 839.0, 'default2'), (4, 841, 'default2', 840, 839.0, 'default2'), (5, 1, 'default1', 841, 0.0, '1998-10-14'), (6, 3, '1998-10-14', 0, 1.0, '1998-10-14'), (7, 17, '1998-10-14', 840, 1.0, 'default1'), (8, 17, '1998-10-14', 0, 839.0, 'default1'), (9, 2, '1998-10-14', 840, 0.0, 'default2'), (10, 5, '1998-10-14', 0, 839.0, 'default2'), (11, 10, 'default2', 839, 840.0, 'default2'), (12, 10, 'default1', 0, 1.0, '1998-10-14'), (13, 7, 'default1', 840, 0.0, '1998-10-14'), (14, 1, 'default1', 1, 840.0, '1998-10-14'), (15, 17, '1998-10-14', 839, 840.0, 'default2'), (16, 2, 'default2', 841, 841.0, 'default2'), (17, 6, '1998-10-14', 0, 839.0, 'default1'), (18, 12, '1998-10-14', 839, 839.0, '1998-10-14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.date FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T2.amount = 840 AND T2.date = '1998-10-14';

/*
Gold Result:
('1998-10-14',)
('2023-01-02',)
('2023-01-01',)
('1998-10-14',)
*/

-- Prediction Query
SELECT account.date FROM trans INNER JOIN account ON trans.account_id = account.account_id WHERE trans.amount = 840 AND trans.date = '1998-10-14' ORDER BY account.date ASC, trans.trans_id NULLS LAST, account.account_id NULLS LAST;

/*
Prediction Result:
('1998-10-14',)
('1998-10-14',)
('2023-01-01',)
('2023-01-02',)
*/