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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '%Y', '1950-01-01', 'default1', 'Sokolov', '1950-01-01', 'Slokolov', 0, 0, 0.0, 0, 0.0, 1.0, 1, NULL, 0), (0, 'default2', 'F', 'default2', 'F', 'default1', 'default2', 0, 0, 0.0, 1, 1.0, 1.0, 0, NULL, 0), (2, '%Y', 'Slokolov', '1950-01-01', 'F', 'default2', 'Sokolov', 0, 0, 0.0, 0, NULL, 0.0, 1, 0, 0), (3, 'Sokolov', 'Sokolov', 'F', '1950', 'default2', 'default1', 1, 1, 0.0, 1, NULL, 0.0, 0, 0, 1), (4, 'Sokolov', '1950-01-01', 'F', '1950', '%Y', 'default1', 0, 1, 1.0, 0, 1.0, 1.0, 1, 1, 0), (5, 'Slokolov', 'F', 'F', 'Slokolov', '1950-01-01', '%Y', 1, 0, 1.0, 0, 0.0, 0.0, 1, NULL, 1), (6, '1950-01-01', 'default2', 'Slokolov', 'Slokolov', 'Sokolov', 'default1', 0, 0, 0.0, 1, 1.0, 0.0, 0, 0, 0), (7, '%Y', 'F', '%Y', '%Y', 'F', 'F', 0, 0, 1.0, 1, NULL, 0.0, 1, 1, 1), (8, '%Y', 'F', '1950', 'Sokolov', 'F', 'F', 1, 1, 1.0, 1, 0.0, 0.0, 0, NULL, 1), (9, '%Y', 'Sokolov', 'Slokolov', '1950', '1950', 'F', 0, 1, 1.0, 0, NULL, 0.0, 0, 1, 1), (10, 'Slokolov', '1950-01-01', '1950-01-01', '1950-01-01', 'Sokolov', '1950-01-01', 1, 1, 1.0, 1, 1.0, 0.0, 1, 0, 1), (11, '1950-01-01', '%Y', '%Y', '1950-01-01', 'F', 'F', 0, 0, 1.0, 1, 0.0, 0.0, 0, NULL, 0), (12, '1950', 'default2', '1950-01-01', '1950', 'default2', 'default2', 0, 1, 1.0, 1, 1.0, 0.0, 1, NULL, 1), (13, 'Slokolov', 'Sokolov', 'Sokolov', '%Y', 'Sokolov', '1950-01-01', 1, 0, 0.0, 1, NULL, 0.0, 0, 1, 0), (14, 'Slokolov', '%Y', 'default2', 'Slokolov', '1950', '%Y', 1, 1, 0.0, 1, 0.0, 0.0, 0, 0, 1), (15, 'F', '%Y', 'default1', '1950', 'default1', 'default2', 1, 1, 1.0, 0, NULL, 0.0, 1, 0, 1), (16, 'default2', 'Sokolov', '1950-01-01', 'Slokolov', '1950-01-01', 'default1', 0, 0, 0.0, 0, 1.0, 0.0, 0, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 8, '1950', '1950-10-27'), (1, 5, '1950-01-01', '1950-01-02'), (2, 10, 'default1', '1950-01-01'), (3, 9, '%Y', '1950-01-02'), (4, 13, '1950-01-01', '1950-01-02'), (5, 3, '1950-01-01', '2023-01-02'), (6, 11, 'default2', '2023-01-01'), (7, 0, 'Sokolov', '1950-01-01'), (8, 13, 'default2', '1950-10-27'), (9, 14, '%Y', '2023-01-02'), (10, 7, 'default2', '1949-12-31'), (11, 3, 'F', '1950-01-02'), (12, 11, 'Sokolov', '1950-01-01'), (13, 7, 'default1', '2023-01-02'), (14, 13, 'Sokolov', '1950-01-01'), (15, 10, 'default1', '1950-01-01'), (16, 3, 'default2', '1949-12-31'), (17, 9, '%Y', '1950-01-02'), (18, 0, 'default2', '1949-12-31'), (19, 8, '1950', '1950-10-27'), (20, 14, 'Sokolov', '2023-01-01'), (21, 14, 'F', '1949-12-31');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' AND STRFTIME('%Y', T2.birth_date) < '1950' AND T1.A2 = 'Slokolov';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client AS c JOIN district AS d ON c.district_id = d.district_id WHERE c.gender = 'F' AND c.birth_date < '1950-01-01' AND d.A2 = 'Sokolov';

/*
Prediction Result:
(0,)
*/