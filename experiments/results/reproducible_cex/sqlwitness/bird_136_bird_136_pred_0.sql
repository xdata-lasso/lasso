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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '1997-12-31', 'POPLATEK MESICNE', 'default1', 'default2', 'A', 'default1', 249999, 250000, 250001.0, 249999, 249999.0, 0.0, 1, 1, 250001), (0, '1995-01-01', 'A', '1995-01-01', '1997-12-31', 'default1', '1997-12-31', 1, 1, 250001.0, 250001, 0.0, 1.0, 1, 0, 249999), (250000, 'A', 'default2', 'POPLATEK MESICNE', 'default1', 'default1', '1997-12-31', 250000, 1, 0.0, 249999, 250001.0, 1.0, 0, NULL, 250001);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, '1995-01-01', '1994-12-31'), (250000, 1, 'POPLATEK MESICNE', '1998-01-01'), (249999, 250000, 'default2', '1994-12-31');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (250000, 250000, '1995-01-01', 250001, 250000, 250000.0, 'default1'), (1, 1, '1994-12-31', 1, 250000, 250001.0, '1997-12-31'), (249999, 1, '1997-12-30', 249999, 249999, 249999.0, 'A'), (250001, 1, '2023-01-01', 1, 250001, 249999.0, 'POPLATEK MESICNE'), (0, 250000, '2023-01-01', 1, 0, 250000.0, 'POPLATEK MESICNE'), (2, 249999, '1994-12-31', 250001, 1, 249999.0, 'A'), (3, 249999, '1995-01-01', 249999, 250000, 250001.0, 'default1'), (4, 250000, '1995-01-02', 0, 0, 0.0, '1995-01-01'), (5, 1, '2023-01-01', 250000, 0, 250000.0, 'default2'), (6, 249999, '2023-01-01', 1, 250001, 250001.0, '1995-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.date BETWEEN '1995-01-01' AND '1997-12-31' AND T1.frequency = 'POPLATEK MESICNE' AND T2.amount > 250000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT loan.loan_id) FROM loan INNER JOIN account ON loan.account_id = account.account_id WHERE loan.amount >= 250000 AND account.frequency = 'POPLATEK MESICNE' AND loan.date BETWEEN '1995-01-01' AND '1997-12-31' AND loan.status = 'A';

/*
Prediction Result:
(0,)
*/