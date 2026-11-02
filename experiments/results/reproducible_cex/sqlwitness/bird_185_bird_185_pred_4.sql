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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'Prague', 'default1', 'F', 'default1', 'default1', 99, 1, 99.0, 99, 100.0, 100.0, 99, 1, 101), (100, 'F', 'Prague', 'Prague', 'default2', 'F', 'default2', 1, 0, 99.0, 0, NULL, 1.0, 1, 1, 101), (99, 'Prague', 'Prague', 'F', 'Prague', 'default2', 'default1', 1, 0, 0.0, 100, 100.0, 1.0, 0, 100, 101);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 100, 'F', '2023-01-02'), (0, 0, 'Prague', '2023-01-02'), (101, 99, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 99, 'Prague', '2023-01-01'), (1, 0, 'F', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (99, 1, 101, 'Prague'), (0, 100, 101, 'Prague'), (100, 1, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) / COUNT(T2.client_id) * 100 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'Prague';

/*
Gold Result:
(33.33333333333333,)
*/

-- Prediction Query
SELECT (COUNT(DISTINCT c.client_id) * 100.0 / (SELECT COUNT(DISTINCT c2.client_id) FROM client AS c2 JOIN disp AS d2 ON c2.client_id = d2.client_id JOIN account AS a2 ON d2.account_id = a2.account_id JOIN district AS di2 ON a2.district_id = di2.district_id WHERE di2.A3 = 'Prague')) AS female_percentage FROM client AS c JOIN disp AS d ON c.client_id = d.client_id JOIN account AS a ON d.account_id = a.account_id JOIN district AS di ON a.district_id = di.district_id WHERE c.gender = 'F' AND di.A3 = 'Prague';

/*
Prediction Result:
(0.0,)
*/