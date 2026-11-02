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
-- DATASET 1
-- Tests:
-- 1. Gender filter (T1.gender = 'F' vs 'M' with an earlier birth_date).
-- 2. Primary sort order (T1.birth_date ASC vs DESC).
-- 3. Join path via district_id vs joining through the disposition table (disp).
-- 4. Confusing client.birth_date with account.date.
-- 5. Confusing account_id with client_id or district_id in the SELECT clause.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '100', '1', '1', '1', 1, 1, 50.0, 9000, 1.0, 1.0, 10, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '200', '2', '2', '2', 2, 2, 60.0, 8000, 2.0, 2.0, 20, 20, 20);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (30, 'D30', 'R3', '300', '3', '3', '3', 3, 3, 70.0, 7000, 3.0, 3.0, 30, 30, 30);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1950-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1960-05-15', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1975-10-20', 30);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 20, 'POPLATEK MESICNE', '1999-12-31');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (303, 30, 'POPLATEK MESICNE', '1990-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 1, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 2, 303, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 3, 202, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(202,)
*/

-- Prediction Query
SELECT T3.account_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN district AS T4 ON T1.district_id = T4.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date, T4.A11, T1.client_id NULLS LAST, T2.disp_id NULLS LAST, T3.account_id NULLS LAST, T4.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(303,)
*/