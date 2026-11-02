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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (100, 'default2', 'default1', 'default1', 'default1', 'default1', 'default1', 1, 100, 99.0, 1, 101.0, 101.0, 2, -1, 101), (-1, 'F', 'default2', 'F', 'default1', 'default2', 'default1', 9999, 10001, 10000.0, 2, 99.0, 101.0, 2, -1, 2), (10001, 'default2', 'F', 'default2', 'default2', 'default2', 'default1', 1, 100, 2.0, 1, 9999.0, 9999.0, 100, 101, -1), (0, 'F', 'F', 'F', 'default1', 'default1', 'F', 100, 99, -1.0, -1, 99.0, 101.0, -1, 9999, 100), (10000, 'default2', 'F', 'default2', 'F', 'default2', 'F', 9999, 99, 9999.0, 10001, 9999.0, 101.0, 100, 2, 9999), (9999, 'default2', 'default1', 'F', 'default2', 'default1', 'default1', 2, 0, 1.0, 1, 101.0, 9999.0, 99, 2, 1), (1, 'F', 'default1', 'default1', 'F', 'default2', 'default1', -1, 9999, -1.0, 101, 101.0, 10001.0, 100, -1, 99);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (101, 10000, 'default2', '2023-01-01'), (10001, 0, 'default2', '2023-01-01'), (1, 1, 'default1', '2023-01-01'), (100, 0, 'default2', '2023-01-01'), (0, -1, 'default1', '2023-01-01'), (99, -1, 'default1', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 10001, 'F', '2023-01-02'), (10001, 1, 'F', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (-1, 0, 99, 'F'), (10001, 0, 99, 'F'), (100, 0, 101, 'default1'), (10000, 0, 99, 'F'), (101, 10001, 99, 'default2'), (9999, 0, 101, 'default2'), (1, 0, 1, 'default1'), (0, 10001, 99, 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) * 100 / COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A11 > 10000;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF(C.gender = 'F', 1, 0)) AS REAL) * 100 / COUNT(*) FROM client AS C INNER JOIN disp AS D ON C.client_id = D.client_id INNER JOIN account AS A ON D.account_id = A.account_id INNER JOIN district AS DI ON A.district_id = DI.district_id WHERE DI.A11 > 10000;

/*
Prediction Result:
(None,)
*/