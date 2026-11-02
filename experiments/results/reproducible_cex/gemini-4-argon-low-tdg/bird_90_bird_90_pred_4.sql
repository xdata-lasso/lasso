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
-- Tests:
-- 1. Client belongs to 'Prague' district, but Account belongs to non-Prague district, and vice-versa (kills joining district via client instead of account)
-- 2. Account has 'order', 'trans', and 'disp' records instead of 'loan' (kills mutants that join the wrong transaction/product table)
-- 3. Multiple 'Prague' districts, one with no accounts (kills RIGHT JOIN district with COUNT(*))
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Praha 1', 'Prague', '50000', '0', '0', '0', 1, 1, 100.0, 13000, 0.1, 0.2, 180, 5000, 6000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Praha 2', 'Prague', '60000', '0', '0', '0', 1, 1, 100.0, 12500, 0.2, 0.3, 170, 4000, 5000);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Plzen', 'west Bohemia', '170000', '0', '0', '0', 1, 1, 100.0, 10500, 1.2, 1.5, 130, 8000, 9000);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1996-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK MESICNE', '1996-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (301, 3, 'POPLATEK MESICNE', '1996-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (302, 3, 'POPLATEK MESICNE', '1996-04-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1001, 'M', '1970-01-01', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1002, 'F', '1975-05-05', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1003, 'M', '1980-10-10', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 1001, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 1002, 301, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 1003, 302, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (501, 101, '1997-01-01', 24000, 24, 1000.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (502, 301, '1997-02-01', 36000, 36, 1000.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (503, 302, '1997-03-01', 48000, 48, 1000.0, 'A');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 102, 'AB', 99999, 500.0, 'SIPO');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 102, '1996-05-01', 'PRIJEM', 'VKLAD', 10000, 10000, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T1.district_id = T3.district_id WHERE T3.A3 = 'Prague';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'Prague';

/*
Prediction Result:
(2,)
*/