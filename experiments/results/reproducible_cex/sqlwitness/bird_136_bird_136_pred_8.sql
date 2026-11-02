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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default1', 'default2', 'POPLATEK MESICNE', 'A', 'default1', 250000, 250001, 1.0, 1, NULL, 1.0, 250000, 250001, 249999), (250000, 'default2', 'POPLATEK MESICNE', '1997-12-31', '1995-01-01', '1997-12-31', 'A', 0, 249999, 250001.0, 0, 1.0, 1.0, 249999, 1, 1), (249999, 'default2', 'POPLATEK MESICNE', '1995-01-01', 'A', 'POPLATEK MESICNE', 'default2', 1, 249999, 250001.0, 1, 0.0, 0.0, 1, 1, 250001), (250001, 'POPLATEK MESICNE', '1995-01-01', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'default1', 'POPLATEK MESICNE', 1, 250001, 250001.0, 250001, 250000.0, 1.0, 1, 250001, 0), (1, 'default1', 'A', 'A', 'POPLATEK MESICNE', 'A', 'default1', 1, 250000, 249999.0, 249999, 0.0, 0.0, 249999, 1, 250000), (2, 'POPLATEK MESICNE', 'default2', 'default1', 'default1', 'POPLATEK MESICNE', 'default1', 0, 250001, 0.0, 250000, 250000.0, 249999.0, 1, 1, 249999), (3, 'A', 'A', 'POPLATEK MESICNE', '1995-01-01', 'default1', '1995-01-01', 1, 249999, 250000.0, 0, 249999.0, 250000.0, 250000, 0, 0), (4, 'default1', '1995-01-01', 'default2', '1995-01-01', 'A', 'default1', 250000, 249999, 250001.0, 0, 250001.0, 249999.0, 250001, 249999, 0), (5, 'default1', 'default1', 'POPLATEK MESICNE', 'default1', 'default2', '1995-01-01', 1, 0, 249999.0, 250000, NULL, 250001.0, 0, 249999, 250000), (6, 'default2', 'default1', 'A', '1997-12-31', '1997-12-31', '1997-12-31', 0, 0, 250000.0, 249999, 250000.0, 0.0, 0, 1, 1), (7, 'POPLATEK MESICNE', 'default1', 'default1', '1995-01-01', '1997-12-31', 'default1', 0, 250001, 0.0, 0, 249999.0, 0.0, 0, 1, 250001), (8, 'default2', 'A', '1995-01-01', 'POPLATEK MESICNE', 'A', 'default1', 1, 0, 250000.0, 250000, 250000.0, 1.0, 250001, 249999, 250000), (9, 'A', 'default2', 'default2', 'POPLATEK MESICNE', 'A', 'default2', 0, 0, 1.0, 1, 249999.0, 0.0, 249999, 1, 0), (10, 'default1', 'POPLATEK MESICNE', '1995-01-01', 'default1', '1995-01-01', '1997-12-31', 249999, 0, 250000.0, 250001, 250001.0, 250001.0, 1, 249999, 1), (11, 'default2', '1997-12-31', 'A', '1997-12-31', 'default2', 'POPLATEK MESICNE', 250001, 1, 249999.0, 250001, NULL, 1.0, 250001, 1, 0), (12, 'POPLATEK MESICNE', 'default1', 'A', 'default2', 'default2', 'default1', 1, 0, 250000.0, 250001, 250000.0, 250001.0, 249999, 249999, 250001);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 8, 'POPLATEK MESICNE', '1994-12-31'), (1, 0, 'A', '1998-01-01'), (249999, 4, 'A', '1998-01-01'), (250000, 249999, '1995-01-01', '1997-12-31'), (250001, 12, '1997-12-31', '2023-01-01'), (2, 4, 'POPLATEK MESICNE', '1995-01-01'), (3, 12, 'default1', '1997-12-30'), (4, 7, 'default2', '1995-01-01'), (5, 250000, 'A', '1994-12-31');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (250001, 3, '1994-12-31', 249999, 0, 1.0, 'default1'), (0, 5, '1995-01-02', 250001, 249999, 249999.0, 'default2'), (1, 1, '1997-12-31', 249999, 0, 250001.0, 'POPLATEK MESICNE'), (249999, 3, '1998-01-01', 249999, 1, 250000.0, '1997-12-31'), (250000, 4, '1995-01-01', 1, 250000, 0.0, '1997-12-31'), (2, 2, '1995-01-02', 250000, 250001, 250000.0, '1997-12-31'), (3, 0, '2023-01-02', 1, 1, 250001.0, 'POPLATEK MESICNE'), (4, 2, '1997-12-31', 250000, 249999, 250000.0, 'A'), (5, 4, '1995-01-02', 250000, 250000, 250001.0, '1995-01-01'), (6, 249999, '1995-01-02', 0, 250000, 1.0, 'default1'), (7, 2, '1997-12-30', 249999, 250001, 0.0, 'POPLATEK MESICNE'), (8, 3, '1995-01-02', 0, 250001, 250001.0, '1995-01-01'), (9, 3, '1994-12-31', 0, 250001, 249999.0, '1997-12-31'), (10, 1, '1995-01-01', 1, 250000, 250001.0, '1995-01-01'), (11, 1, '1994-12-31', 1, 250001, 249999.0, '1997-12-31'), (12, 5, '1995-01-02', 250000, 249999, 1.0, 'A'), (13, 3, '1995-01-02', 250001, 249999, 1.0, 'POPLATEK MESICNE'), (14, 0, '1997-12-30', 250000, 1, 249999.0, 'default1'), (15, 2, '2023-01-01', 250001, 1, 249999.0, 'A'), (16, 250001, '1997-12-31', 250000, 0, 1.0, 'A'), (17, 250001, '1994-12-31', 250001, 250001, 0.0, '1995-01-01'), (18, 2, '1997-12-30', 250000, 250001, 1.0, '1997-12-31'), (19, 2, '1995-01-02', 249999, 0, 1.0, '1995-01-01'), (20, 0, '1997-12-31', 1, 1, 1.0, '1995-01-01'), (21, 3, '2023-01-01', 249999, 250000, 1.0, '1995-01-01'), (22, 4, '2023-01-02', 249999, 1, 0.0, 'A'), (23, 3, '1997-12-31', 1, 249999, 250001.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.date BETWEEN '1995-01-01' AND '1997-12-31' AND T1.frequency = 'POPLATEK MESICNE' AND T2.amount > 250000;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM account AS T1 JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.frequency = 'POPLATEK MESICNE' AND T2.status = 'A' AND T2.amount >= 250000 AND T2."date" BETWEEN '1995-01-01' AND '1997-12-31';

/*
Prediction Result:
(1,)
*/