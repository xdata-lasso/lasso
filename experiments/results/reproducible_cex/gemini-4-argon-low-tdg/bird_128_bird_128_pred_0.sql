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
-- 1. GROUP BY T2.district_id, T2.A2 vs GROUP BY T2.A2 only (Districts 1 and 2 share A2 = 'SameName')
-- 2. INNER JOIN vs LEFT JOIN on district (District 3 has only 'M' clients, District 4 has 0 clients)
-- 3. WHERE gender = 'F' vs no filter or gender = 'M' (District 2 has 'M' clients that would inflate its count if unfiltered)
-- 4. ORDER BY COUNT DESC vs ASC, and tie-breaking on T2.A2 ASC vs DESC (Districts 5 and 6 both have count 2, named 'Alpha' and 'Beta')
-- 5. Confounding path via account/disp (Client 1 is in District 1, but has an account in District 5)
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'SameName', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'SameName', 'R2', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'OnlyMale', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'NoClient', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Beta', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (6, 'Alpha', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 100, 1.0, 1.0, 1, 1, 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'F', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1981-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1982-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'F', '1983-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'M', '1984-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'M', '1985-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (7, 'M', '1986-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (8, 'M', '1987-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (9, 'M', '1988-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'F', '1989-01-01', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (11, 'F', '1990-01-01', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (12, 'F', '1991-01-01', 6);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (13, 'F', '1992-01-01', 6);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 5, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 5, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (201, 1, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (202, 1, 102, 'DISPONENT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('SameName', 3)
('Alpha', 2)
('Beta', 2)
('SameName', 1)
*/

-- Prediction Query
SELECT T1.A2, COUNT(T2.client_id) AS num FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' GROUP BY T1.A2 ORDER BY num DESC, T1.A2 NULLS LAST LIMIT 10;

/*
Prediction Result:
('SameName', 4)
('Alpha', 2)
('Beta', 2)
*/