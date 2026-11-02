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
-- 1. Predicate mutation on gender (gender = 'M' vs 'F', missing gender filter).
-- 2. Predicate mutation on region A3 (A3 != 'south Bohemia', missing A3 filter, A2 vs A3 confusion).
-- 3. Logical operator mutation (AND vs OR).
-- 4. Aggregation mutation (COUNT(client_id) vs COUNT(DISTINCT district_id), SUM, MAX, MIN).
-- 5. Join condition mutation (cross join, joining client_id = district_id, or joining via account/disp instead of client.district_id).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Pisek', 'south Bohemia', '100', '10', '10', '10', 1, 1, 50.0, 8000, 1.5, 2.0, 100, 1000, 1100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'south Bohemia', 'north Bohemia', '200', '20', '20', '20', 2, 2, 60.0, 9000, 2.5, 3.0, 110, 2000, 2100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (30, 'Tabor', 'south Bohemia', '300', '30', '30', '30', 3, 3, 70.0, 8500, NULL, 2.5, 120, NULL, 3100);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'F', '1980-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'F', '1985-05-05', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (7, 'M', '1990-10-10', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'F', '1975-03-15', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (20, 'M', '1988-07-20', 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 20, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 10, 'POPLATEK MESICNE', '1996-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 5, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 10, 200, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' AND T2.A3 = 'south Bohemia';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(account.account_id) FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN account ON disp.account_id = account.account_id INNER JOIN district ON account.district_id = district.district_id WHERE client.gender = 'F' AND district.a3 = 'south Bohemia';

/*
Prediction Result:
(1,)
*/