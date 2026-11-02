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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'OWNER', 'east Bohemia', 'east Bohemia', '%Y', '1995', '1995', 0, 1, 0.0, 1, NULL, 0.0, 1, NULL, 1), (1, 'default1', 'OWNER', '2000', 'east Bohemia', 'default2', 'OWNER', 1, 1, 1.0, 1, NULL, 1.0, 0, NULL, 1), (2, 'east Bohemia', 'east Bohemia', '1995', 'default1', 'default1', '%Y', 1, 1, 1.0, 1, 1.0, 0.0, 0, 0, 0), (3, 'default2', 'default2', 'default2', '2000', 'east Bohemia', '1995', 1, 0, 1.0, 0, NULL, 1.0, 1, NULL, 1), (4, 'OWNER', 'OWNER', 'east Bohemia', '2000', '%Y', '1995', 0, 1, 0.0, 0, NULL, 0.0, 1, NULL, 1), (5, '2000', 'default2', 'default1', '%Y', '1995', 'default1', 1, 1, 1.0, 1, NULL, 1.0, 0, 1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 5, '%Y', '1995-10-27'), (1, 2, 'east Bohemia', '2023-01-02'), (2, 1, 'default2', '2023-01-01'), (3, 1, '1995', '2000-10-27'), (4, 5, '1995', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 5, '%Y', '1995-10-27'), (1, 5, 'default1', '1995-10-27'), (2, 2, 'default1', '2023-01-01'), (3, 0, '2000', '1995-10-27'), (4, 4, '2000', '1995-10-27'), (5, 2, '%Y', '2000-10-27');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 0, 3, 'default1'), (0, 5, 4, '2000'), (2, 3, 2, 'default2'), (3, 1, 0, 'OWNER'), (4, 1, 0, '1995'), (5, 2, 0, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T1.frequency FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'east Bohemia' AND STRFTIME('%Y', T1.date) BETWEEN '1995' AND '2000';

/*
Gold Result:
(3, '2000')
(5, '%Y')
*/

-- Prediction Query
SELECT T1.account_id, T1.frequency FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T4.A3 = 'east Bohemia' AND STRFTIME('%Y', T1.date) BETWEEN '1995' AND '2000' AND T2.type = 'OWNER';

/*
Prediction Result:
*/