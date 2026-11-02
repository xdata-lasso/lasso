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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'POPLATEK PO OBRATU', '1993', '%Y', 'default1', 'default1', 0, 0, 0.0, 0, 0.0, 1.0, 1, 0, 0), (1, 'default1', 'default1', '%Y', '1993', 'default2', '%Y', 0, 1, 1.0, 1, 0.0, 1.0, 1, 0, 1), (2, 'POPLATEK PO OBRATU', '1993', '%Y', 'default2', '1993', 'default1', 0, 0, 0.0, 1, NULL, 0.0, 0, NULL, 1), (3, '1993', '%Y', 'POPLATEK PO OBRATU', '%Y', 'default1', 'default2', 1, 0, 1.0, 1, 1.0, 1.0, 1, 0, 0), (4, 'default1', '%Y', '%Y', '%Y', '%Y', 'default1', 0, 1, 1.0, 0, 0.0, 0.0, 1, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'default2', '2023-01-01'), (1, 1, 'POPLATEK PO OBRATU', '1993-10-27'), (2, 3, '1993', '2023-01-01'), (3, 3, 'default1', '1993-10-27'), (4, 1, '%Y', '2023-01-02'), (5, 3, 'default1', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 5, '1993-10-27', '1993', 'default2', 1, 0, 'default1', '1993', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.frequency = 'POPLATEK PO OBRATU' AND STRFTIME('%Y', T1.date) = '1993';

/*
Gold Result:
(1, 'default1', 'default1')
*/

-- Prediction Query
SELECT T1.account_id, T3.A2 AS district_name, T3.A3 AS district_region FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T1.district_id = T3.district_id WHERE T1.frequency = 'POPLATEK PO OBRATU' AND STRFTIME('%Y', T2.date) = '1993';

/*
Prediction Result:
*/