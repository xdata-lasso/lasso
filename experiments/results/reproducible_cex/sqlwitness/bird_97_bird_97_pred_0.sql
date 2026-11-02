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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default2', 'DISPONENT', 'DISPONENT', 'default2', 'default2', 1, 0, 1.0, 1, NULL, 1.0, 0, 1, 1), (1, 'default1', 'Disponent', 'Disponent', 'POPLATEK PO OBRATU', 'DISPONENT', 'default1', 0, 1, 0.0, 0, 1.0, 1.0, 0, 1, 0), (2, 'POPLATEK PO OBRATU', 'default2', 'DISPONENT', 'POPLATEK PO OBRATU', 'Disponent', 'Disponent', 1, 1, 1.0, 0, 1.0, 0.0, 1, 1, 0), (3, 'default2', 'default1', 'default1', 'DISPONENT', 'default1', 'DISPONENT', 1, 0, 1.0, 0, NULL, 1.0, 1, 1, 0), (4, 'default2', 'DISPONENT', 'default1', 'DISPONENT', 'default1', 'Disponent', 1, 0, 0.0, 0, 0.0, 0.0, 1, 1, 0), (5, 'default2', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'Disponent', 'DISPONENT', 'default2', 1, 0, 1.0, 1, NULL, 1.0, 1, 1, 1), (6, 'POPLATEK PO OBRATU', 'Disponent', 'POPLATEK PO OBRATU', 'DISPONENT', 'DISPONENT', 'Disponent', 1, 1, 1.0, 1, NULL, 1.0, 1, NULL, 1), (7, 'Disponent', 'DISPONENT', 'default2', 'Disponent', 'default2', 'DISPONENT', 1, 0, 1.0, 1, 0.0, 0.0, 1, 0, 0), (8, 'POPLATEK PO OBRATU', 'default1', 'Disponent', 'POPLATEK PO OBRATU', 'Disponent', 'DISPONENT', 1, 1, 1.0, 0, 0.0, 0.0, 0, 0, 0), (9, 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'DISPONENT', 'default2', 'POPLATEK PO OBRATU', 'default1', 0, 1, 0.0, 0, 0.0, 0.0, 1, 0, 0), (10, 'default1', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'DISPONENT', 'Disponent', 'Disponent', 0, 1, 0.0, 1, NULL, 0.0, 0, NULL, 0), (11, 'default1', 'default1', 'default1', 'DISPONENT', 'default2', 'POPLATEK PO OBRATU', 1, 0, 1.0, 1, NULL, 1.0, 0, 1, 1), (12, 'default2', 'Disponent', 'Disponent', 'Disponent', 'DISPONENT', 'default2', 0, 1, 1.0, 1, NULL, 0.0, 0, 1, 1), (13, 'Disponent', 'DISPONENT', 'default2', 'DISPONENT', 'default1', 'POPLATEK PO OBRATU', 1, 0, 0.0, 0, 0.0, 1.0, 1, NULL, 0), (14, 'POPLATEK PO OBRATU', 'Disponent', 'default2', 'DISPONENT', 'default2', 'POPLATEK PO OBRATU', 1, 1, 1.0, 0, NULL, 0.0, 1, NULL, 0), (15, 'DISPONENT', 'POPLATEK PO OBRATU', 'DISPONENT', 'Disponent', 'default1', 'default1', 1, 1, 0.0, 0, 1.0, 1.0, 0, 1, 0), (16, 'default1', 'default2', 'POPLATEK PO OBRATU', 'Disponent', 'POPLATEK PO OBRATU', 'default1', 1, 0, 1.0, 1, 0.0, 0.0, 1, NULL, 0), (17, 'default2', 'DISPONENT', 'default1', 'POPLATEK PO OBRATU', 'default2', 'default2', 1, 1, 1.0, 0, NULL, 1.0, 1, 0, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 2, 'Disponent', '2023-01-01'), (0, 14, 'default1', '2023-01-02'), (2, 5, 'POPLATEK PO OBRATU', '2023-01-01'), (3, 5, 'Disponent', '2023-01-02'), (4, 6, 'default1', '2023-01-01'), (5, 8, 'DISPONENT', '2023-01-02'), (6, 15, 'default1', '2023-01-01'), (7, 0, 'default2', '2023-01-01'), (8, 3, 'Disponent', '2023-01-02'), (9, 15, 'DISPONENT', '2023-01-02'), (10, 13, 'POPLATEK PO OBRATU', '2023-01-01'), (11, 17, 'default2', '2023-01-01'), (12, 3, 'POPLATEK PO OBRATU', '2023-01-02'), (13, 2, 'Disponent', '2023-01-01'), (14, 3, 'DISPONENT', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 15, 'DISPONENT', '2023-01-01'), (0, 1, 'DISPONENT', '2023-01-02'), (2, 9, 'Disponent', '2023-01-02'), (3, 2, 'default1', '2023-01-02'), (4, 16, 'DISPONENT', '2023-01-02'), (5, 9, 'default2', '2023-01-02'), (6, 3, 'default2', '2023-01-01'), (7, 14, 'default1', '2023-01-02'), (8, 0, 'POPLATEK PO OBRATU', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 8, 3, 'POPLATEK PO OBRATU'), (0, 0, 9, 'DISPONENT'), (2, 7, 10, 'DISPONENT'), (3, 6, 0, 'DISPONENT'), (4, 1, 9, 'default1'), (5, 4, 10, 'Disponent'), (6, 7, 6, 'Disponent'), (7, 0, 4, 'POPLATEK PO OBRATU'), (8, 6, 5, 'default1'), (9, 2, 0, 'POPLATEK PO OBRATU'), (10, 3, 9, 'Disponent'), (11, 6, 5, 'DISPONENT'), (12, 4, 3, 'POPLATEK PO OBRATU'), (13, 6, 10, 'POPLATEK PO OBRATU'), (14, 1, 3, 'Disponent'), (15, 8, 3, 'Disponent'), (16, 7, 1, 'default1'), (17, 4, 6, 'default2'), (18, 4, 7, 'Disponent'), (19, 0, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.client_id FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T1.frequency = 'POPLATEK PO OBRATU' AND T2.type = 'DISPONENT';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.client_id, T2.gender, T2.birth_date FROM disp AS T1 INNER JOIN client AS T2 ON T1.client_id = T2.client_id WHERE T1.type = 'Disponent' AND T1.account_id IN (SELECT account_id FROM account WHERE frequency = 'POPLATEK PO OBRATU');

/*
Prediction Result:
(3, 'Disponent', '2023-01-02')
*/