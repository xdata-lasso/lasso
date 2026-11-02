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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '1950-01-01', 'Slokolov', 'default1', 'F', '%Y', 'F', 0, 0, 0.0, 0, NULL, 1.0, 0, 1, 1), (0, 'Slokolov', 'default1', 'default2', 'default2', 'F', 'F', 0, 1, 0.0, 1, NULL, 1.0, 1, 0, 0), (2, '%Y', 'default1', '1950', '1950-01-01', '%Y', '1950-01-01', 0, 0, 0.0, 1, NULL, 1.0, 1, NULL, 1), (3, '1950', 'Slokolov', 'F', '1950', 'default2', 'default2', 1, 0, 0.0, 1, 1.0, 0.0, 0, 0, 0), (4, 'F', 'default2', 'Sokolov', 'Slokolov', 'default2', 'Sokolov', 0, 0, 0.0, 0, 0.0, 1.0, 1, NULL, 0), (5, 'Sokolov', 'default2', '1950-01-01', 'F', 'Slokolov', 'default2', 1, 0, 0.0, 1, NULL, 0.0, 1, 1, 0), (6, '%Y', '%Y', 'Slokolov', 'default2', 'Sokolov', 'Slokolov', 1, 0, 1.0, 1, 1.0, 0.0, 1, 0, 1), (7, '%Y', 'F', 'Sokolov', 'default2', '1950-01-01', '1950-01-01', 1, 0, 0.0, 0, 1.0, 1.0, 1, 0, 0), (8, '1950-01-01', '1950', 'F', 'F', 'Slokolov', 'default2', 1, 0, 0.0, 0, 0.0, 1.0, 0, 1, 0), (9, '1950', '%Y', 'F', '1950', 'default2', 'default1', 0, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1), (10, 'default2', 'Slokolov', '%Y', 'default2', '1950', '%Y', 0, 0, 0.0, 1, NULL, 0.0, 1, 1, 0), (11, 'Sokolov', 'F', 'default1', '1950-01-01', 'Slokolov', 'F', 1, 1, 0.0, 1, 0.0, 1.0, 1, NULL, 1), (12, 'default1', 'default2', 'Slokolov', 'default1', 'Slokolov', 'Sokolov', 1, 0, 0.0, 1, NULL, 0.0, 1, 1, 1), (13, '%Y', 'default1', '%Y', 'Slokolov', '%Y', '1950', 0, 1, 0.0, 1, NULL, 1.0, 0, 0, 1), (14, '%Y', 'default1', 'default1', '1950-01-01', 'default1', 'default2', 1, 0, 0.0, 0, 0.0, 0.0, 0, 1, 0), (15, 'F', 'default2', '%Y', '1950-01-01', '%Y', 'Slokolov', 0, 0, 1.0, 1, NULL, 1.0, 1, 0, 1), (16, 'Sokolov', 'default1', 'Sokolov', 'default2', 'default2', '%Y', 1, 1, 1.0, 0, NULL, 0.0, 0, 0, 0), (17, 'F', '1950', '1950', 'F', '1950-01-01', '1950-01-01', 1, 0, 1.0, 0, 1.0, 0.0, 1, 1, 0), (18, '1950', '%Y', '%Y', 'Slokolov', 'default2', '1950-01-01', 0, 1, 0.0, 0, 1.0, 0.0, 0, NULL, 0), (19, '1950-01-01', 'default1', 'F', '1950-01-01', 'Slokolov', 'Slokolov', 0, 0, 0.0, 1, 0.0, 0.0, 0, 0, 1), (20, 'default2', '%Y', 'default1', 'Slokolov', '%Y', 'Slokolov', 0, 1, 0.0, 1, NULL, 0.0, 1, NULL, 0), (21, 'default2', '1950', 'Sokolov', 'F', 'F', 'default2', 1, 1, 1.0, 1, NULL, 1.0, 1, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 3, '%Y', '2023-01-01'), (0, 8, 'Slokolov', '1950-01-02'), (2, 17, '1950', '1950-01-02'), (3, 18, 'F', '1950-10-27'), (4, 15, 'default1', '1950-01-02'), (5, 20, 'Sokolov', '1950-01-02'), (6, 20, '%Y', '1950-01-02'), (7, 18, 'default1', '1950-01-02'), (8, 5, '1950', '2023-01-02'), (9, 21, 'default1', '2023-01-02'), (10, 21, 'Sokolov', '1949-12-31'), (11, 18, '%Y', '1950-10-27'), (12, 15, '1950', '2023-01-01'), (13, 17, 'default2', '1950-01-02'), (14, 14, 'Sokolov', '1950-10-27'), (15, 4, 'default2', '2023-01-02'), (16, 10, '1950-01-01', '2023-01-02'), (17, 5, 'Sokolov', '1950-10-27'), (18, 9, '1950', '1950-01-01'), (19, 16, 'F', '1949-12-31'), (20, 19, '1950', '1950-01-02'), (21, 6, 'Slokolov', '1950-01-02'), (22, 15, 'F', '2023-01-02'), (23, 16, 'Sokolov', '2023-01-02'), (24, 7, '1950-01-01', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' AND STRFTIME('%Y', T2.birth_date) < '1950' AND T1.A2 = 'Slokolov';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS num_customers FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' AND T1.birth_date < '1950-01-01' AND T2.A2 = 'Sokolov';

/*
Prediction Result:
(1,)
*/