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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 0.29, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Benesov', 'central Bohemia', '88884', '80', '26', '6', 2, 5, 46.7, 8507, 1.67, 1.85, 132, 2159, 2674);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Beroun', 'central Bohemia', '75232', '55', '26', '4', 1, 5, 41.7, 8980, 1.95, 2.21, 111, 2824, 2813);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Kladno', 'central Bohemia', '149893', '63', '29', '6', 2, 6, 67.4, 9753, 4.64, 5.05, 109, 5244, 5892);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK TYDNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK TYDNE', '1995-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 1, 'POPLATEK MESICNE', '1995-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 2, 'POPLATEK TYDNE', '1995-04-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 3, 'POPLATEK MESICNE', '1995-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (106, 4, 'POPLATEK TYDNE', '1995-06-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'M', '1972-05-12', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'F', '1975-08-20', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'F', '1980-03-15', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'M', '1965-11-30', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'M', '1968-07-22', 3);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (7, 'M', '1990-12-05', 3);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 3, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 4, 104, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 1, 103, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (4, 5, 105, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(57.142857142857146,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN client.gender = 'M' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(*) AS percentage FROM account INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE account.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(0.0,)
*/