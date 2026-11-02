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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'M', 'default2', 'default1', 'default1', 'M', 'M', 1, 1, 0.0, 0, 1.0, 0.0, 0, 1, 1), (0, 'M', 'default2', 'default1', 'M', 'default2', 'default2', 1, 0, 0.0, 0, NULL, 0.0, 0, NULL, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 0, 'M', '2023-01-02'), (1, 0, 'M', '2023-01-01'), (2, 0, 'M', '2023-01-01'), (3, 0, 'default1', '2023-01-02'), (4, 0, 'M', '2023-01-01'), (5, 1, 'M', '2023-01-02'), (6, 1, 'default1', '2023-01-01'), (7, 0, 'M', '2023-01-01'), (8, 1, 'default1', '2023-01-01'), (9, 1, 'default2', '2023-01-01'), (10, 1, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 1, 'M', '2023-01-02'), (1, 1, 'default2', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 1, '2023-01-01', 1, 0, 1.0, 'M'), (1, 0, '2023-01-02', 1, 0, 0.0, 'default2'), (2, 1, '2023-01-01', 0, 0, 1.0, 'M'), (3, 0, '2023-01-02', 0, 0, 1.0, 'default1'), (4, 0, '2023-01-02', 1, 1, 0.0, 'default1'), (5, 1, '2023-01-01', 1, 0, 0.0, 'M'), (6, 0, '2023-01-01', 0, 1, 1.0, 'default2'), (7, 0, '2023-01-02', 0, 0, 0.0, 'M'), (8, 1, '2023-01-02', 1, 1, 0.0, 'default2'), (9, 1, '2023-01-01', 0, 0, 0.0, 'M'), (10, 0, '2023-01-02', 0, 1, 1.0, 'M');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 1, 1, 'M'), (1, 0, 5, 'M'), (2, 0, 5, 'M'), (3, 0, 0, 'M'), (4, 0, 8, 'M'), (5, 1, 9, 'M'), (6, 1, 6, 'default1'), (7, 0, 1, 'default1'), (8, 1, 6, 'M'), (9, 0, 4, 'default1'), (10, 0, 5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'M';

/*
Gold Result:
(0.45454545454545453,)
*/

-- Prediction Query
SELECT AVG(CAST(l.amount AS REAL)) FROM loan AS l JOIN disp AS d ON l.account_id = d.account_id JOIN client AS c ON d.client_id = c.client_id WHERE c.gender = 'M';

/*
Prediction Result:
(0.36585365853658536,)
*/