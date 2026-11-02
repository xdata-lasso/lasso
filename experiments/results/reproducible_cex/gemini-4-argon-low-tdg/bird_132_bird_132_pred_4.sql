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
-- 1. Join via district_id vs join via disp table (Account 10 has a male client in the same district, but is linked to a female client in disp; Account 20 is linked to a male client in disp, but in a district with no male clients).
-- 2. AVG(amount) vs AVG(DISTINCT amount) (Multiple male clients in District 1 multiply the weight of Loan 100).
-- 3. Gender filter 'M' vs 'F' or missing WHERE clause.
-- 4. AVG vs SUM/COUNT/MIN/MAX, and amount vs payments/duration.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'M', '1985-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1990-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'M', '1975-01-01', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'F', '1995-01-01', 3);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '2000-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 3, 'POPLATEK MESICNE', '2000-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 2, 'POPLATEK MESICNE', '2000-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 3, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 1, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 4, 30, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (100, 10, '2001-01-01', 1000, 12, 83.33, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (200, 20, '2001-01-01', 5000, 24, 208.33, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (300, 30, '2001-01-01', 2500, 36, 69.44, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'M';

/*
Gold Result:
(1500.0,)
*/

-- Prediction Query
SELECT AVG(CAST(l.amount AS REAL)) FROM loan AS l JOIN disp AS d ON l.account_id = d.account_id JOIN client AS c ON d.client_id = c.client_id WHERE c.gender = 'M';

/*
Prediction Result:
(3750.0,)
*/