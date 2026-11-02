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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '10', '10', '10', 1, 1, 10.0, 1000, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '2000', '20', '20', '20', 2, 2, 20.0, 2000, 2.0, 2.0, 2, 2, 2);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '3000', '30', '30', '30', 3, 3, 30.0, 9000, 3.0, 3.0, 3, 3, 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1999-12-31', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'M', '1985-05-05', 3);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'MONTHLY', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'WEEKLY', '1990-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (25, 2, 'MONTHLY', '1998-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 3, 'DAILY', '1999-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 1, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 2, 30, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 3, 25, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client ORDER BY birth_date DESC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T3.birth_date = (SELECT MAX(birth_date) FROM client) AND T4.A11 = (SELECT MAX(A11) FROM district);

/*
Prediction Result:
*/