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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'USER', 'default2', 'OWNER', 'default2', 'OWNER', 0, 0, 1.0, 1, 0.0, 0.0, 1, 0, 1), (0, 'default2', 'POPLATEK TYDNE', 'default2', 'OWNER', 'USER', 'USER', 1, 1, 0.0, 0, 0.0, 1.0, 1, 0, 0), (2, 'POPLATEK TYDNE', 'USER', 'default2', 'USER', 'default1', 'USER', 0, 0, 1.0, 0, NULL, 0.0, 1, 0, 1), (3, 'USER', 'POPLATEK TYDNE', 'USER', 'OWNER', 'default1', 'default1', 1, 1, 1.0, 0, 1.0, 0.0, 1, NULL, 1), (4, 'POPLATEK TYDNE', 'OWNER', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'USER', 'USER', 0, 0, 1.0, 0, 1.0, 1.0, 1, NULL, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 2, 'POPLATEK TYDNE', '2023-01-02'), (1, 1, 'default1', '2023-01-02'), (2, 2, 'default2', '2023-01-01'), (3, 3, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 4, 'OWNER', '2023-01-01'), (1, 1, 'default2', '2023-01-02'), (2, 4, 'POPLATEK TYDNE', '2023-01-01'), (3, 2, 'default2', '2023-01-01'), (4, 2, 'default2', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 0, 0, 'USER'), (1, 2, 1, 'USER'), (2, 1, 3, 'default1'), (3, 1, 2, 'default1'), (4, 4, 1, 'default2'), (5, 4, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T2.account_id = T1.account_id WHERE T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'USER';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT disp.client_id) FROM disp INNER JOIN account ON disp.account_id = account.account_id WHERE disp.type = 'OWNER' AND account.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(0,)
*/