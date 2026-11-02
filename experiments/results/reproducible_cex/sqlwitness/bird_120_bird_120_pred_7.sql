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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'east Bohemia', 'east Bohemia', '1995-01-01', 'default1', 'default2', '2000-12-31', 1, 0, 0.0, 1, 1.0, 0.0, 1, NULL, 1), (1, 'default2', 'default1', '1995', 'default2', '%Y', '%Y', 1, 0, 1.0, 1, 0.0, 0.0, 1, 0, 0), (2, 'default1', 'east Bohemia', '1995', '2000-12-31', 'default2', '1995', 0, 0, 0.0, 0, 1.0, 0.0, 1, 1, 1), (3, '1995-01-01', '2000', '1995', '1995-01-01', '1995-01-01', '1995-01-01', 1, 0, 1.0, 1, 0.0, 0.0, 0, 1, 0), (4, 'default1', '%Y', '2000', 'default1', '%Y', 'east Bohemia', 1, 1, 0.0, 1, 0.0, 1.0, 1, NULL, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 2, 'default2', '2023-01-01'), (1, 3, '2000-12-31', '1995-10-27'), (2, 2, 'east Bohemia', '2001-01-01'), (3, 4, 'default1', '1995-01-02'), (4, 3, '2000-12-31', '2023-01-02'), (5, 2, '2000-12-31', '1995-01-02'), (6, 3, '%Y', '2000-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'east Bohemia', '2023-01-02'), (1, 4, '2000-12-31', '2023-01-01'), (2, 2, '2000-12-31', '2023-01-01'), (3, 3, '%Y', '2023-01-01'), (4, 0, '%Y', '1995-01-01'), (5, 4, '2000', '2023-01-01'), (6, 0, 'default1', '2000-12-31'), (7, 2, 'default1', '1995-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 7, 3, '2000-12-31'), (0, 1, 4, '1995-01-01'), (2, 3, 6, '1995'), (3, 7, 5, '1995-01-01'), (4, 3, 6, 'default2'), (5, 5, 2, '2000'), (6, 6, 6, '1995-01-01'), (7, 5, 2, 'east Bohemia'), (8, 0, 5, '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T1.frequency FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'east Bohemia' AND STRFTIME('%Y', T1.date) BETWEEN '1995' AND '2000';

/*
Gold Result:
(4, '%Y')
(6, 'default1')
(7, 'default1')
*/

-- Prediction Query
SELECT T1.account_id, T1.frequency FROM account AS T1 JOIN disp AS T2 ON T1.account_id = T2.account_id JOIN client AS T3 ON T2.client_id = T3.client_id JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T4.A3 = 'east Bohemia' AND T1.date BETWEEN '1995-01-01' AND '2000-12-31';

/*
Prediction Result:
(7, 'default1')
*/