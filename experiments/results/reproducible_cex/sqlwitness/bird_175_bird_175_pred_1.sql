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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'OWNER', 'default1', 'POPLATEK PO OBRATU', 'OWNER', 'OWNER', 'OWNER', 0, 1, 0.0, 1, 1.0, 1.0, 0, 0, 1), (1, 'POPLATEK PO OBRATU', 'OWNER', 'OWNER', 'default2', 'default2', 'default1', 0, 1, 1.0, 0, 0.0, 1.0, 1, 1, 0), (2, 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'default1', 'OWNER', 'OWNER', 'default1', 0, 0, 1.0, 1, 0.0, 1.0, 0, 1, 1), (3, 'default2', 'POPLATEK PO OBRATU', 'default1', 'OWNER', 'default1', 'POPLATEK PO OBRATU', 0, 1, 1.0, 1, 0.0, 0.0, 0, 0, 0), (4, 'OWNER', 'OWNER', 'OWNER', 'OWNER', 'POPLATEK PO OBRATU', 'default2', 0, 0, 0.0, 0, 1.0, 1.0, 1, 0, 1), (5, 'OWNER', 'default2', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'OWNER', 'OWNER', 0, 0, 0.0, 0, 1.0, 1.0, 0, 0, 0), (6, 'POPLATEK PO OBRATU', 'default1', 'default1', 'POPLATEK PO OBRATU', 'default2', 'default1', 1, 0, 1.0, 0, 0.0, 0.0, 0, 0, 0), (7, 'default2', 'default2', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'OWNER', 'POPLATEK PO OBRATU', 0, 1, 1.0, 0, 0.0, 1.0, 1, 0, 1), (8, 'default1', 'default2', 'default2', 'POPLATEK PO OBRATU', 'OWNER', 'OWNER', 1, 0, 1.0, 1, NULL, 0.0, 0, 0, 0), (9, 'POPLATEK PO OBRATU', 'OWNER', 'OWNER', 'default2', 'default2', 'default1', 1, 0, 1.0, 0, 1.0, 0.0, 0, 0, 0), (10, 'OWNER', 'POPLATEK PO OBRATU', 'default1', 'OWNER', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 0, 0, 0.0, 1, 0.0, 0.0, 0, 0, 0), (11, 'POPLATEK PO OBRATU', 'OWNER', 'POPLATEK PO OBRATU', 'OWNER', 'default1', 'default1', 0, 1, 1.0, 0, 1.0, 0.0, 0, 0, 0), (12, 'OWNER', 'default1', 'default1', 'OWNER', 'OWNER', 'default2', 1, 1, 1.0, 0, 0.0, 0.0, 0, 0, 1), (13, 'POPLATEK PO OBRATU', 'default1', 'default2', 'default2', 'default1', 'POPLATEK PO OBRATU', 0, 1, 0.0, 0, 0.0, 0.0, 0, NULL, 0), (14, 'default1', 'POPLATEK PO OBRATU', 'OWNER', 'default1', 'POPLATEK PO OBRATU', 'default1', 1, 0, 0.0, 0, 1.0, 1.0, 1, 0, 0), (15, 'default2', 'default1', 'OWNER', 'default1', 'default2', 'POPLATEK PO OBRATU', 1, 1, 1.0, 1, 0.0, 0.0, 1, 1, 1), (16, 'POPLATEK PO OBRATU', 'OWNER', 'OWNER', 'default1', 'default1', 'default2', 1, 0, 0.0, 1, NULL, 1.0, 1, 0, 0), (17, 'default2', 'default2', 'default2', 'default1', 'OWNER', 'POPLATEK PO OBRATU', 1, 1, 0.0, 0, 0.0, 1.0, 0, NULL, 0), (18, 'default2', 'OWNER', 'POPLATEK PO OBRATU', 'default1', 'default1', 'POPLATEK PO OBRATU', 1, 1, 1.0, 0, 0.0, 0.0, 0, 0, 1), (19, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1', 1, 1, 0.0, 0, NULL, 0.0, 0, 1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 15, 'default1', '2023-01-01'), (0, 1, 'default1', '2023-01-01'), (2, 6, 'POPLATEK PO OBRATU', '2023-01-02'), (3, 18, 'OWNER', '2023-01-02'), (4, 18, 'default1', '2023-01-02'), (5, 4, 'default2', '2023-01-02'), (6, 5, 'OWNER', '2023-01-02'), (7, 6, 'POPLATEK PO OBRATU', '2023-01-02'), (8, 17, 'default2', '2023-01-01'), (9, 12, 'default1', '2023-01-01'), (10, 1, 'POPLATEK PO OBRATU', '2023-01-02'), (11, 8, 'default2', '2023-01-01'), (12, 15, 'OWNER', '2023-01-01'), (13, 16, 'OWNER', '2023-01-02'), (14, 2, 'default1', '2023-01-01'), (15, 19, 'POPLATEK PO OBRATU', '2023-01-02'), (16, 13, 'POPLATEK PO OBRATU', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 12, 'OWNER', '2023-01-02'), (1, 13, 'default2', '2023-01-01'), (2, 15, 'POPLATEK PO OBRATU', '2023-01-01'), (3, 5, 'OWNER', '2023-01-01'), (4, 19, 'POPLATEK PO OBRATU', '2023-01-01'), (5, 6, 'POPLATEK PO OBRATU', '2023-01-02'), (6, 6, 'default1', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 2, 2, 'default2'), (1, 5, 10, 'default1'), (2, 6, 8, 'default1'), (3, 0, 3, 'default2'), (4, 3, 7, 'default2'), (5, 0, 0, 'default1'), (6, 1, 5, 'POPLATEK PO OBRATU'), (7, 0, 10, 'OWNER'), (8, 3, 9, 'OWNER'), (9, 0, 1, 'default2'), (10, 1, 11, 'default1'), (11, 2, 16, 'default2'), (12, 2, 4, 'default2'), (13, 6, 9, 'default2'), (14, 5, 7, 'OWNER'), (15, 2, 7, 'default2'), (16, 0, 2, 'default2'), (17, 4, 12, 'default1'), (18, 3, 2, 'default1'), (19, 4, 0, 'default2'), (20, 4, 2, 'OWNER'), (21, 3, 3, 'POPLATEK PO OBRATU'), (22, 4, 12, 'OWNER'), (23, 3, 13, 'OWNER'), (24, 2, 6, 'default2'), (25, 2, 10, 'default1'), (26, 4, 11, 'OWNER'), (27, 5, 8, 'default1'), (28, 2, 5, 'default2'), (29, 5, 13, 'default2'), (30, 2, 14, 'default1'), (31, 2, 11, 'default1'), (32, 4, 10, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T2.type = 'OWNER' AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT account.account_id) AS account_count FROM account INNER JOIN disp ON account.account_id = disp.account_id WHERE disp.type = 'OWNER' AND account.frequency = 'POPLATEK PO OBRATU';

/*
Prediction Result:
(2,)
*/