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
-- 1. Lexicographical vs numeric ordering on TEXT column T2.A4 ('95000' > '120000' in TEXT).
-- 2. Ordering by T2.A4 DESC vs ordering by the calculated percentage DESC/ASC.
-- 3. Floating-point division (CAST AS REAL) vs integer division (1/3 * 100 = 33.333... vs 33 or 0).
-- 4. Filtering by T2.A3 = 'south Bohemia' (distractor district has higher A4 '99999').
-- 5. GROUP BY T2.A4 vs no GROUP BY.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'south Bohemia', '95000', '0', '0', '0', 0, 0, 0.0, 0, 0.0, 0.0, 0, 0, 0);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'south Bohemia', '120000', '0', '0', '0', 0, 0, 0.0, 0, 0.0, 0.0, 0, 0, 0);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'north Bohemia', '99999', '0', '0', '0', 0, 0, 0.0, 0, 0.0, 0.0, 0, 0, 0);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1970-01-02', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1970-01-03', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'M', '1970-01-04', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'M', '1970-01-05', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'F', '1970-01-06', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (7, 'M', '1970-01-07', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' ORDER BY T2.A4 DESC, T1.client_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(50.0,)
*/