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
-- DATASET 2
-- Tests WHERE clause boundary conditions, logical operators (AND vs OR), and wrong column references (e.g., account.date vs loan.date, trans.amount vs loan.amount).
-- The reference query should return empty on this dataset, whereas relaxed or mutated predicates will return rows.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
-- Account 1 has the target date '1996-01-03', but its loan has a different date
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'POPLATEK MESICNE', '1996-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 2, 'POPLATEK MESICNE', '1995-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 3, 'POPLATEK MESICNE', '1994-04-04');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1960-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1965-02-02', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'M', '1996-01-03', 3);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 1, 1, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 2, 2, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 3, 3, 'OWNER');
-- Loan 1: Right amount (98832), wrong date ('1996-01-04'), on Account 1 (which has date '1996-01-03')
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 1, '1996-01-04', 98832, 12, 8236.0, 'A');
-- Loan 2: Right date ('1996-01-03'), wrong amount (98831)
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 2, '1996-01-03', 98831, 12, 8235.9, 'B');
-- Loan 3: Right date ('1996-01-03'), wrong amount (98833)
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 3, '1996-01-03', 98833, 12, 8236.1, 'C');
-- Trans & Order with target date/amount to catch wrong table usage
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 1, '1996-01-03', 'PRIJEM', 'VKLAD', 98832, 100000, ' ', 'AB', 123);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 1, 'AB', 123, 98832.0, 'SIPO');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
*/

-- Prediction Query
SELECT client.birth_date FROM loan INNER JOIN account ON loan.account_id = account.account_id INNER JOIN client ON account.district_id = client.district_id WHERE loan.amount = 98832 AND loan.date BETWEEN '1996-01-01' AND '1996-12-31';

/*
Prediction Result:
('1960-01-01',)
*/