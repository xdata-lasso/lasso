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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (250000, 'POPLATEK MESICNE', 'default1', 'A', 'default2', '1997-12-31', '1995-01-01', 250000, 250001, 1.0, 249999, 1.0, 1.0, 249999, 0, 250000), (249999, 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'default1', 'POPLATEK MESICNE', 'default1', 'A', 250000, 249999, 250001.0, 250000, 250000.0, 249999.0, 250000, 1, 0), (0, '1995-01-01', 'POPLATEK MESICNE', 'default1', '1995-01-01', '1995-01-01', '1997-12-31', 250001, 249999, 250001.0, 249999, 0.0, 249999.0, 249999, 249999, 249999), (250001, 'default1', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'POPLATEK MESICNE', '1997-12-31', 'POPLATEK MESICNE', 249999, 250000, 250001.0, 249999, 249999.0, 1.0, 0, NULL, 249999), (1, 'default2', '1995-01-01', '1997-12-31', 'POPLATEK MESICNE', 'default2', 'default2', 249999, 249999, 249999.0, 250001, 1.0, 1.0, 0, 0, 250001), (2, 'A', 'default1', 'default1', 'A', 'default2', '1995-01-01', 250001, 250001, 0.0, 0, 250000.0, 1.0, 250000, 249999, 250000), (3, 'POPLATEK MESICNE', '1997-12-31', 'A', 'A', 'A', '1995-01-01', 249999, 250001, 249999.0, 0, 249999.0, 1.0, 250000, NULL, 0), (4, '1997-12-31', '1995-01-01', '1997-12-31', 'default1', '1995-01-01', 'default2', 0, 249999, 249999.0, 250001, 250000.0, 250000.0, 0, 250000, 250000), (5, 'default1', '1997-12-31', '1995-01-01', 'POPLATEK MESICNE', 'default2', 'default1', 250000, 0, 0.0, 1, 0.0, 1.0, 250001, 250000, 0), (6, 'POPLATEK MESICNE', 'default1', '1995-01-01', '1995-01-01', '1997-12-31', 'default2', 1, 1, 250001.0, 249999, 250000.0, 1.0, 249999, 1, 250001), (7, 'default2', 'default2', 'POPLATEK MESICNE', '1997-12-31', 'default2', '1995-01-01', 1, 0, 1.0, 0, NULL, 0.0, 0, NULL, 0), (8, 'A', '1995-01-01', 'default2', 'A', 'default2', '1995-01-01', 0, 250000, 250001.0, 1, 250000.0, 249999.0, 250000, 249999, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (249999, 6, '1997-12-31', '1997-12-30'), (1, 2, 'default1', '1997-12-31'), (0, 7, 'default2', '1994-12-31'), (250001, 5, 'POPLATEK MESICNE', '2023-01-02'), (250000, 5, '1995-01-01', '1997-12-31'), (2, 3, 'A', '1997-12-31'), (3, 3, '1995-01-01', '1994-12-31'), (4, 0, 'POPLATEK MESICNE', '1997-12-30'), (5, 3, 'default1', '1995-01-02'), (6, 2, 'default2', '1997-12-30'), (7, 3, '1997-12-31', '2023-01-01'), (8, 1, '1995-01-01', '1994-12-31'), (9, 249999, 'POPLATEK MESICNE', '2023-01-01'), (10, 2, 'default2', '1997-12-30'), (11, 0, 'default1', '1997-12-30'), (12, 3, 'default2', '1995-01-01'), (13, 250001, 'default1', '2023-01-02'), (14, 250000, '1997-12-31', '1997-12-30'), (15, 1, 'default1', '1997-12-30'), (16, 250001, '1997-12-31', '1997-12-31');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (250000, 2, '1994-12-31', 250001, 250001, 1.0, '1995-01-01'), (0, 4, '2023-01-01', 1, 249999, 0.0, 'A'), (1, 7, '1997-12-30', 250000, 1, 250000.0, 'POPLATEK MESICNE'), (250001, 4, '1997-12-31', 250001, 249999, 1.0, 'POPLATEK MESICNE'), (249999, 1, '1998-01-01', 250000, 250001, 249999.0, 'default2'), (2, 8, '2023-01-02', 1, 1, 0.0, 'default2'), (3, 250000, '1997-12-31', 250000, 0, 1.0, '1997-12-31'), (4, 4, '1997-12-30', 1, 0, 250001.0, '1997-12-31'), (5, 249999, '1994-12-31', 250001, 250001, 250001.0, 'default1'), (6, 14, '2023-01-02', 1, 1, 249999.0, 'POPLATEK MESICNE'), (7, 7, '1995-01-01', 0, 250000, 249999.0, 'A'), (8, 15, '2023-01-02', 1, 250000, 1.0, 'default2'), (9, 10, '1998-01-01', 250000, 0, 250001.0, 'POPLATEK MESICNE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.date BETWEEN '1995-01-01' AND '1997-12-31' AND T1.frequency = 'POPLATEK MESICNE' AND T2.amount > 250000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.account_id) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.amount >= 250000 AND T2.frequency = 'POPLATEK MESICNE' AND T1.date BETWEEN '1995-01-01' AND '1997-12-31' AND T1.status = 'A';

/*
Prediction Result:
(0,)
*/