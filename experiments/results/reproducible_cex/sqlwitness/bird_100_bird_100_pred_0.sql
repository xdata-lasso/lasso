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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '%Y', 'Sokolov', 'Slokolov', 'default2', 'Sokolov', 'default1', 0, 0, 1.0, 1, NULL, 0.0, 1, NULL, 0), (0, 'Slokolov', '%Y', 'Slokolov', 'default1', 'Slokolov', 'F', 0, 1, 0.0, 1, NULL, 1.0, 0, 0, 0), (2, '1950', 'default2', 'Sokolov', '1950', 'default1', 'Slokolov', 1, 0, 1.0, 1, 0.0, 0.0, 0, 0, 1), (3, 'Slokolov', '1950-01-01', '1950', 'default1', 'default1', 'F', 1, 1, 1.0, 1, 1.0, 0.0, 1, 1, 0), (4, '1950-01-01', '1950-01-01', 'default2', 'Slokolov', '1950-01-01', 'default2', 1, 0, 0.0, 1, 0.0, 0.0, 0, 0, 0), (5, 'default2', '%Y', 'Sokolov', 'Sokolov', 'default2', '1950-01-01', 1, 0, 0.0, 0, 0.0, 1.0, 1, 1, 1), (6, 'Slokolov', 'default2', '1950', 'F', 'Sokolov', '%Y', 1, 1, 0.0, 0, 0.0, 1.0, 0, NULL, 1), (7, '1950-01-01', 'Sokolov', 'Sokolov', '%Y', '1950-01-01', '1950-01-01', 0, 0, 1.0, 0, 1.0, 1.0, 0, 0, 1), (8, 'F', 'default1', 'Sokolov', '1950-01-01', '1950-01-01', 'Sokolov', 0, 1, 0.0, 1, 1.0, 0.0, 0, 0, 0), (9, 'F', 'default2', '1950-01-01', 'default1', 'Slokolov', 'default1', 0, 1, 1.0, 0, 1.0, 1.0, 0, 1, 1), (10, '%Y', 'F', 'default2', 'F', '1950-01-01', 'F', 1, 0, 1.0, 1, 1.0, 1.0, 0, 0, 0), (11, 'default2', '%Y', 'default2', 'Slokolov', 'Slokolov', 'Slokolov', 0, 1, 1.0, 0, 1.0, 0.0, 1, 0, 1), (12, '1950', 'default1', '1950-01-01', 'Slokolov', 'default1', '1950', 1, 1, 1.0, 1, NULL, 0.0, 1, 1, 1), (13, 'default2', 'default2', 'Sokolov', '%Y', 'default1', 'default1', 0, 0, 1.0, 1, NULL, 1.0, 0, 0, 0), (14, 'Sokolov', 'F', 'Sokolov', 'default1', 'default1', '1950-01-01', 0, 1, 0.0, 0, 1.0, 0.0, 0, NULL, 0), (15, 'default2', 'default1', 'Sokolov', 'default1', '1950', '1950', 0, 0, 1.0, 1, 0.0, 1.0, 0, 0, 1), (16, 'Slokolov', '%Y', 'default2', '%Y', 'Sokolov', 'default1', 0, 0, 1.0, 1, 1.0, 1.0, 1, 0, 1), (17, 'default1', 'F', '1950-01-01', 'Sokolov', '1950-01-01', 'Slokolov', 0, 1, 0.0, 0, 1.0, 0.0, 1, NULL, 1), (18, '1950-01-01', 'Sokolov', 'default1', '%Y', 'default2', 'Slokolov', 0, 0, 0.0, 0, 1.0, 0.0, 0, 1, 1), (19, 'F', '%Y', 'Sokolov', 'F', 'Slokolov', 'Slokolov', 0, 0, 1.0, 0, NULL, 1.0, 0, 0, 1), (20, '1950-01-01', '1950-01-01', '1950-01-01', 'F', '1950', '1950', 0, 1, 1.0, 0, NULL, 1.0, 0, 1, 0), (21, 'default1', 'default1', 'default2', '1950', 'Sokolov', '1950-01-01', 0, 1, 1.0, 0, NULL, 0.0, 0, NULL, 1), (22, '%Y', 'default2', 'Sokolov', 'F', 'Slokolov', '%Y', 1, 1, 0.0, 0, 0.0, 0.0, 0, 0, 1), (23, 'default1', 'Slokolov', 'Sokolov', 'default1', '%Y', 'default1', 1, 0, 1.0, 0, NULL, 0.0, 0, NULL, 1), (24, '1950', 'Slokolov', 'default1', '1950-01-01', '1950-01-01', 'F', 0, 0, 0.0, 0, 0.0, 0.0, 0, NULL, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 4, 'F', '1950-01-01'), (1, 19, 'Sokolov', '2023-01-02'), (2, 2, 'F', '1949-12-31'), (3, 4, '1950-01-01', '1950-01-01'), (4, 2, 'default1', '2023-01-01'), (5, 2, '1950', '1950-01-02'), (6, 11, 'F', '1950-10-27'), (7, 13, '1950', '1949-12-31'), (8, 9, '1950-01-01', '1949-12-31'), (9, 20, 'default2', '1950-01-02'), (10, 20, '1950', '2023-01-02'), (11, 13, 'default1', '1949-12-31'), (12, 16, 'F', '1949-12-31'), (13, 15, '%Y', '1949-12-31'), (14, 23, '%Y', '1950-01-01'), (15, 2, 'F', '2023-01-01'), (16, 13, 'Slokolov', '1950-01-01'), (17, 17, '%Y', '1949-12-31'), (18, 21, '1950', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 1, '1950-01-01', '2023-01-02'), (1, 0, '1950', '1949-12-31');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 1, 11, 'default1'), (1, 1, 5, 'Slokolov'), (2, 1, 18, '%Y'), (3, 1, 15, '%Y'), (4, 1, 12, 'Sokolov'), (5, 0, 15, 'Sokolov'), (6, 1, 7, '%Y'), (7, 1, 8, '1950-01-01'), (8, 1, 18, 'Slokolov'), (9, 0, 13, 'default2'), (10, 0, 3, 'default2'), (11, 1, 9, 'default2'), (12, 0, 7, 'Slokolov'), (13, 0, 8, 'default1'), (14, 0, 14, 'Slokolov');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' AND STRFTIME('%Y', T2.birth_date) < '1950' AND T1.A2 = 'Slokolov';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T3.gender = 'F' AND T3.birth_date < '1950-01-01' AND T4.A2 = 'Sokolov';

/*
Prediction Result:
(0,)
*/