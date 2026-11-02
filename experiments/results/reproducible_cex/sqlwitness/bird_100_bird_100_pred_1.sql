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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'Sokolov', 'F', 'F', '1950-01-01', 'Slokolov', 'default2', 1, 0, 0.0, 0, NULL, 0.0, 0, NULL, 1), (0, '%Y', 'F', 'F', 'default2', 'default2', '1950-01-01', 1, 0, 1.0, 1, NULL, 0.0, 1, 0, 0), (2, 'Sokolov', '1950-01-01', 'F', 'Slokolov', 'F', 'default2', 0, 1, 0.0, 0, NULL, 1.0, 1, 0, 0), (3, 'Sokolov', 'Slokolov', '%Y', 'default2', 'Slokolov', '1950', 0, 1, 0.0, 0, NULL, 0.0, 1, NULL, 0), (4, '1950-01-01', '%Y', '%Y', 'default2', 'default1', 'default1', 1, 1, 1.0, 0, 1.0, 1.0, 1, NULL, 0), (5, 'Sokolov', 'default2', '1950-01-01', '%Y', '1950', 'Sokolov', 0, 1, 0.0, 1, 1.0, 0.0, 1, 1, 0), (6, 'default2', 'Sokolov', '%Y', 'F', 'Sokolov', 'F', 1, 0, 0.0, 0, 1.0, 1.0, 1, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 4, 'Slokolov', '1950-01-02'), (1, 4, 'F', '2023-01-01'), (2, 4, 'default2', '1949-12-31'), (3, 3, 'Slokolov', '1950-01-02'), (4, 3, 'Sokolov', '1950-01-02'), (5, 6, 'default1', '2023-01-01'), (6, 0, 'Slokolov', '2023-01-01'), (7, 0, 'Sokolov', '1950-01-02'), (8, 6, 'Slokolov', '1950-10-27'), (9, 6, 'F', '1950-01-02'), (10, 5, 'default1', '1950-01-01'), (11, 2, 'Slokolov', '1950-01-02'), (12, 0, 'Slokolov', '1950-01-01'), (13, 3, 'default1', '1949-12-31'), (14, 5, '1950', '1950-10-27'), (15, 5, 'default2', '1950-01-01'), (16, 4, 'default1', '1950-01-01'), (17, 5, 'F', '1949-12-31'), (18, 4, 'default2', '1950-10-27'), (19, 2, '1950-01-01', '1949-12-31'), (20, 6, 'default2', '1949-12-31'), (21, 2, 'Slokolov', '1950-10-27'), (22, 5, 'Slokolov', '1949-12-31'), (23, 2, 'Sokolov', '2023-01-01'), (24, 3, 'Slokolov', '2023-01-02'), (25, 0, 'Slokolov', '1950-01-01'), (26, 1, 'Slokolov', '2023-01-02'), (27, 5, 'F', '2023-01-02'), (28, 4, 'Sokolov', '2023-01-01'), (29, 2, 'default2', '2023-01-02'), (30, 1, '1950', '1950-10-27'), (31, 0, '%Y', '1950-01-02'), (32, 1, 'Sokolov', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' AND STRFTIME('%Y', T2.birth_date) < '1950' AND T1.A2 = 'Slokolov';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(client.client_id) FROM client INNER JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' AND client.birth_date < '1950-01-01' AND district.A2 = 'Sokolov';

/*
Prediction Result:
(1,)
*/