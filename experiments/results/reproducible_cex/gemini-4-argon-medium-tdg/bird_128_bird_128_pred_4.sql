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
-- 1. GROUP BY T2.district_id, T2.A2 vs GROUP BY T2.A2 only (Districts 1 and 2 share A2='Alpha').
-- 2. ORDER BY COUNT DESC and tie-breaking by T2.A2 ASC (Districts 2 and 3 both have count=2, A2='Alpha' vs 'Beta').
-- 3. WHERE T1.gender = 'F' filtering vs 'M' or missing filter (District 3 has 'M', District 5 has only 'M').
-- 4. INNER JOIN vs LEFT JOIN on district (District 4 has 0 clients, District 5 has 0 'F' clients).
-- 5. Accidental join or confusion with account.district_id vs client.district_id.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Alpha', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Alpha', 'R2', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Beta', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Gamma', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Delta', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'F', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1980-01-02', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'F', '1980-01-03', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (201, 'F', '1980-01-04', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (202, 'F', '1980-01-05', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (301, 'F', '1980-01-06', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (302, 'F', '1980-01-07', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (303, 'M', '1980-01-08', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (501, 'M', '1980-01-09', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (502, 'M', '1980-01-10', 5);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 4, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 4, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 101, 1, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 201, 2, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('Alpha', 3)
('Alpha', 2)
('Beta', 2)
*/

-- Prediction Query
SELECT T1.A2, COUNT(T3.client_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T4 ON T2.account_id = T4.account_id INNER JOIN client AS T3 ON T4.client_id = T3.client_id WHERE T3.gender = 'F' GROUP BY T1.A2 ORDER BY COUNT(T3.client_id) DESC, T1.A2 NULLS LAST LIMIT 9;

/*
Prediction Result:
('Gamma', 2)
*/