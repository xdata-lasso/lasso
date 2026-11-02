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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'F', 'default2', 'south Bohemia', 'default1', 'F', 'default1', 0, 0, 0.0, 1, NULL, 1.0, 1, 1, 0), (1, 'F', 'F', 'south Bohemia', 'south Bohemia', 'south Bohemia', 'default2', 1, 1, 0.0, 1, 1.0, 1.0, 1, 0, 1), (2, 'default1', 'default2', 'default1', 'default1', 'default2', 'south Bohemia', 1, 0, 1.0, 1, NULL, 1.0, 1, 0, 1), (3, 'default2', 'south Bohemia', 'south Bohemia', 'south Bohemia', 'default1', 'south Bohemia', 0, 1, 0.0, 0, 1.0, 1.0, 1, NULL, 0), (4, 'default1', 'default2', 'south Bohemia', 'default2', 'default1', 'south Bohemia', 0, 0, 0.0, 0, 1.0, 0.0, 1, NULL, 1), (5, 'south Bohemia', 'F', 'default2', 'default2', 'default2', 'default1', 0, 0, 1.0, 0, 0.0, 0.0, 0, 0, 1), (6, 'default1', 'south Bohemia', 'default1', 'default1', 'default2', 'default2', 0, 0, 0.0, 0, 0.0, 0.0, 0, 0, 1), (7, 'F', 'default2', 'F', 'F', 'default2', 'F', 0, 1, 0.0, 0, 0.0, 0.0, 0, 1, 0), (8, 'default1', 'default1', 'F', 'default1', 'F', 'default1', 0, 0, 0.0, 0, 1.0, 0.0, 0, NULL, 1), (9, 'F', 'default1', 'south Bohemia', 'default1', 'F', 'default1', 0, 0, 0.0, 0, 1.0, 1.0, 1, NULL, 0), (10, 'F', 'F', 'default2', 'south Bohemia', 'default2', 'default2', 1, 1, 0.0, 1, 1.0, 1.0, 1, NULL, 1), (11, 'default1', 'south Bohemia', 'F', 'default2', 'south Bohemia', 'default1', 1, 1, 0.0, 0, NULL, 0.0, 1, 0, 1), (12, 'default1', 'default2', 'south Bohemia', 'default2', 'F', 'F', 0, 0, 0.0, 0, NULL, 0.0, 0, 0, 0), (13, 'default1', 'F', 'F', 'default2', 'south Bohemia', 'F', 1, 0, 0.0, 1, 0.0, 1.0, 1, 1, 1), (14, 'default1', 'F', 'south Bohemia', 'south Bohemia', 'F', 'south Bohemia', 1, 1, 0.0, 1, 0.0, 0.0, 1, 1, 0), (15, 'default2', 'F', 'F', 'default2', 'default2', 'F', 1, 1, 0.0, 1, 1.0, 0.0, 1, 1, 1), (16, 'F', 'south Bohemia', 'default2', 'F', 'F', 'default2', 0, 0, 1.0, 1, 1.0, 1.0, 0, 0, 1), (17, 'south Bohemia', 'default2', 'F', 'south Bohemia', 'south Bohemia', 'default2', 1, 1, 1.0, 1, 0.0, 0.0, 1, 0, 1), (18, 'default2', 'south Bohemia', 'default1', 'south Bohemia', 'south Bohemia', 'south Bohemia', 1, 1, 0.0, 0, 0.0, 1.0, 0, NULL, 0), (19, 'default1', 'default2', 'default1', 'F', 'south Bohemia', 'F', 0, 0, 1.0, 1, 0.0, 0.0, 1, 1, 0), (20, 'default2', 'default2', 'south Bohemia', 'F', 'default2', 'south Bohemia', 0, 1, 1.0, 0, 0.0, 1.0, 1, NULL, 0), (21, 'default2', 'south Bohemia', 'default1', 'south Bohemia', 'F', 'F', 1, 1, 0.0, 1, NULL, 0.0, 0, 0, 1), (22, 'default2', 'default2', 'south Bohemia', 'default1', 'south Bohemia', 'F', 0, 1, 0.0, 1, 1.0, 1.0, 0, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 8, 'default1', '2023-01-01'), (0, 3, 'F', '2023-01-02'), (2, 20, 'default1', '2023-01-01'), (3, 3, 'south Bohemia', '2023-01-02'), (4, 1, 'south Bohemia', '2023-01-02'), (5, 21, 'south Bohemia', '2023-01-01'), (6, 15, 'default1', '2023-01-01'), (7, 8, 'default1', '2023-01-02'), (8, 18, 'default1', '2023-01-01'), (9, 19, 'south Bohemia', '2023-01-01'), (10, 0, 'default2', '2023-01-02'), (11, 22, 'F', '2023-01-01'), (12, 8, 'F', '2023-01-02'), (13, 1, 'south Bohemia', '2023-01-01'), (14, 8, 'default2', '2023-01-01'), (15, 6, 'south Bohemia', '2023-01-01'), (16, 6, 'default2', '2023-01-02'), (17, 22, 'F', '2023-01-01'), (18, 12, 'default1', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 5, 'default2', '2023-01-01'), (0, 15, 'default2', '2023-01-02'), (2, 22, 'F', '2023-01-01'), (3, 2, 'default1', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 3, 11, 'south Bohemia'), (0, 2, 1, 'south Bohemia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' AND T2.A3 = 'south Bohemia';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T4.A3 = 'south Bohemia' AND T1.gender = 'F';

/*
Prediction Result:
(0,)
*/