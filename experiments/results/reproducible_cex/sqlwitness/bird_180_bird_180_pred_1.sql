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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'east Bohemia', '1983', '1987-12-31', 'default1', '1983', 1, 1, 1.0, 0, 1.0, 1.0, 0, 0, 1), (1, '%Y', '1987', '1983-01-01', '1983', 'east Bohemia', '1987', 0, 0, 0.0, 1, NULL, 1.0, 1, 1, 1), (2, 'default1', 'east Bohemia', '1983', '1987', '1983-01-01', '1987-12-31', 1, 0, 0.0, 0, 1.0, 1.0, 0, NULL, 0), (3, '1987', '1987', '1987-12-31', 'default1', '1983-01-01', 'east Bohemia', 1, 1, 0.0, 0, 0.0, 0.0, 0, 0, 0), (4, 'default2', '1987', 'default1', 'default2', '%Y', 'default2', 1, 1, 0.0, 0, NULL, 1.0, 0, 1, 1), (5, '1987-12-31', 'default2', '1983-01-01', 'default1', '1983-01-01', '1987-12-31', 0, 0, 1.0, 1, 0.0, 1.0, 1, NULL, 1), (6, '%Y', 'east Bohemia', 'default2', 'default1', '%Y', 'east Bohemia', 0, 0, 1.0, 0, NULL, 0.0, 1, NULL, 1), (7, 'default1', '1987-12-31', 'default2', 'default2', '1983', 'default2', 0, 1, 1.0, 0, NULL, 1.0, 1, 1, 0), (8, '1987', 'east Bohemia', 'default2', '1987-12-31', '%Y', '1987', 1, 0, 1.0, 0, 1.0, 0.0, 1, 0, 0), (9, 'east Bohemia', 'default1', '1987-12-31', '1987-12-31', '1983', '1983-01-01', 0, 0, 0.0, 1, NULL, 1.0, 0, NULL, 1), (10, '1987-12-31', 'default2', 'default2', 'default1', '1983-01-01', '%Y', 1, 0, 0.0, 0, 1.0, 0.0, 1, 1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 10, '1983', '1987-12-30'), (0, 1, 'default2', '1983-10-27'), (2, 1, 'default2', '2023-01-02'), (3, 4, 'default1', '2023-01-02'), (4, 10, 'east Bohemia', '1987-12-31');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, '1983-01-01', '1987-10-27'), (1, 2, 'default1', '1983-01-02'), (2, 1, '1983', '1987-12-31'), (3, 0, 'default2', '1983-10-27'), (4, 3, '1983-01-01', '1987-12-31'), (5, 8, 'default2', '1983-01-01'), (6, 1, 'east Bohemia', '1983-01-02'), (7, 3, 'default1', '1988-01-01'), (8, 7, '1983-01-01', '1987-12-31'), (9, 7, 'default2', '1983-10-27'), (10, 0, 'default2', '1988-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 8, 1, '%Y'), (1, 7, 1, '1987-12-31'), (2, 4, 3, '%Y'), (3, 1, 2, 'east Bohemia'), (4, 8, 1, '1987'), (5, 8, 4, 'east Bohemia'), (6, 9, 4, '1987-12-31'), (7, 3, 0, '1983-01-01'), (8, 5, 0, '1983-01-01'), (9, 3, 2, 'default1'), (10, 8, 1, 'east Bohemia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id, T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T2.A3 = 'east Bohemia' AND STRFTIME('%Y', T1.birth_date) BETWEEN '1983' AND '1987';

/*
Gold Result:
*/

-- Prediction Query
SELECT "client"."client_id", "client"."birth_date" FROM "client" JOIN "disp" ON "client"."client_id" = "disp"."client_id" JOIN "account" ON "disp"."account_id" = "account"."account_id" JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "client"."birth_date" BETWEEN '1983-01-01' AND '1987-12-31' AND "district"."a3" = 'east Bohemia';

/*
Prediction Result:
(0, '1983-10-27')
(0, '1983-10-27')
*/