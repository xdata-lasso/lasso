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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (101, 'default2', 'default2', 'default1', 'default1', 'default1', 'D', 100, 0, 1.0, 101, 0.0, 1.0, 100, 1, 100), (1, 'D', 'default1', 'default2', 'default2', 'D', 'D', 100, 1, 101.0, 1, 101.0, 101.0, 0, 101, 100), (100, 'default2', 'default2', 'D', 'D', 'default1', 'D', 101, 100, 1.0, 101, 99.0, 101.0, 100, 100, 0), (99, 'default2', 'D', 'D', 'default2', 'default1', 'default1', 100, 1, 101.0, 0, 101.0, 1.0, 0, 101, 99);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 1, 'default2', '2023-01-02'), (100, 99, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (99, 99, 'default1', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 99, '2023-01-01', 0, 100, 101.0, 'default2'), (99, 99, '2023-01-01', 101, 1, 0.0, 'default2'), (100, 99, '2023-01-01', 0, 100, 101.0, 'default2'), (101, 99, '2023-01-02', 101, 101, 0.0, 'default2'), (1, 99, '2023-01-02', 0, 101, 100.0, 'D');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 99, 100, 'default2'), (100, 99, 100, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((T3.A13 - T3.A12) AS REAL) * 100 / T3.A12 FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.status = 'D';

/*
Gold Result:
(-99.00990099009901,)
*/

-- Prediction Query
SELECT T4.A2, T4.A3, (CAST(T4.A13 - T4.A12 AS REAL) * 100) / T4.A12 AS unemployment_rate_increment FROM district AS T4 INNER JOIN client AS T2 ON T4.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.client_id = T3.client_id INNER JOIN account AS T1 ON T3.account_id = T1.account_id INNER JOIN loan AS T5 ON T1.account_id = T5.account_id WHERE T5.status = 'D';

/*
Prediction Result:
('default2', 'D', -99.00990099009901)
('default2', 'D', -99.00990099009901)
*/