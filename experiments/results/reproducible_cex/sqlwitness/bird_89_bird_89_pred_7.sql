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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default1', 'default2', 'default2', 'east Bohemia', 'east Bohemia', 0, 0, 0.0, 1, 0.0, 0.0, 0, 0, 1), (1, 'East Bohemia', 'POPLATEK PO OBRATU', 'default2', 'east Bohemia', 'east Bohemia', 'POPLATEK PO OBRATU', 0, 1, 1.0, 1, 1.0, 0.0, 1, 0, 0), (2, 'default2', 'east Bohemia', 'default2', 'POPLATEK PO OBRATU', 'default1', 'default2', 1, 1, 1.0, 1, 1.0, 0.0, 1, NULL, 1), (3, 'East Bohemia', 'East Bohemia', 'default2', 'POPLATEK PO OBRATU', 'East Bohemia', 'default1', 1, 0, 0.0, 1, NULL, 1.0, 1, 0, 1), (4, 'POPLATEK PO OBRATU', 'default2', 'default2', 'POPLATEK PO OBRATU', 'east Bohemia', 'default2', 0, 0, 0.0, 1, 1.0, 0.0, 1, 1, 0), (5, 'East Bohemia', 'POPLATEK PO OBRATU', 'east Bohemia', 'default2', 'default2', 'default1', 0, 0, 1.0, 1, 1.0, 1.0, 0, 1, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'East Bohemia', '2023-01-01'), (1, 0, 'default1', '2023-01-01'), (2, 3, 'default1', '2023-01-01'), (3, 5, 'east Bohemia', '2023-01-02'), (4, 2, 'default1', '2023-01-02'), (5, 1, 'default2', '2023-01-02'), (6, 3, 'POPLATEK PO OBRATU', '2023-01-02'), (7, 4, 'east Bohemia', '2023-01-01'), (8, 3, 'East Bohemia', '2023-01-02'), (9, 4, 'default1', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.district_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'East Bohemia' AND T2.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(a.account_id) FROM account AS a JOIN district AS d ON a.district_id = d.district_id WHERE a.frequency = 'POPLATEK PO OBRATU' AND d.A3 = 'east Bohemia';

/*
Prediction Result:
(0,)
*/