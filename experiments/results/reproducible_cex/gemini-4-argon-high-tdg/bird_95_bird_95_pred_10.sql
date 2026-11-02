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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1200000', '0', '0', '0', 1, 1, 100.0, 12500, 0.2, 0.4, 160, 85000, 99000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Karvina', 'north Moravia', '280000', '10', '5', '2', 2, 5, 85.5, 9200, 4.5, 5.1, 110, 9000, 10500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Bruntal', 'north Moravia', '105000', '30', '15', '5', 1, 4, 60.0, 7100, 6.2, 7.8, 95, 3200, 4100);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1950-01-10', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (201, 'F', '1998-06-15', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (301, 'M', '1985-03-20', 3);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (500, 1, 'POPLATEK MESICNE', '1997-12-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1001, 2, 'POPLATEK MESICNE', '1995-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1002, 2, 'POPLATEK TYDNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1003, 2, 'POPLATEK PO OBRATU', '1997-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2001, 3, 'POPLATEK MESICNE', '1992-04-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client ORDER BY birth_date DESC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a JOIN client AS c ON a.account_id = c.client_id JOIN district AS d ON c.district_id = d.district_id WHERE d.A11 = (SELECT MAX(A11) FROM district) ORDER BY c.birth_date DESC, a.account_id NULLS LAST, c.client_id NULLS LAST, d.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/