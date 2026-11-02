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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '1976-01-29', 'F', '1976-01-29', '1976-01-29', '1976-01-29', 'default1', 1, 1, 1.0, 1, 1.0, 0.0, 0, 1, 0), (0, '1976-01-29', 'F', 'F', 'F', 'default1', 'F', 1, 1, 1.0, 0, 0.0, 1.0, 0, NULL, 0), (2, 'F', '1976-01-29', 'default2', '1976-01-29', 'default2', 'F', 0, 0, 0.0, 1, NULL, 0.0, 0, NULL, 1), (3, '1976-01-29', 'F', 'F', 'F', 'default1', 'default1', 1, 1, 0.0, 1, NULL, 0.0, 1, 0, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 2, '1976-01-29', '1976-01-28'), (0, 0, 'F', '1976-01-30'), (2, 2, 'F', '1976-01-29'), (3, 2, 'default2', '2023-01-02'), (4, 3, 'F', '1976-01-30'), (5, 3, 'F', '1976-01-30'), (6, 2, 'F', '2023-01-01'), (7, 2, 'default1', '1976-01-30');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'F', '1976-01-30'), (1, 3, '1976-01-29', '1976-01-29'), (2, 2, 'default1', '1976-01-28'), (3, 2, 'F', '1976-01-30'), (4, 2, '1976-01-29', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 0, 4, 'default1'), (0, 4, 4, 'default2'), (2, 4, 5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.A2 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.birth_date = '1976-01-29' AND T2.gender = 'F';

/*
Gold Result:
('F',)
*/

-- Prediction Query
SELECT "district"."a2" FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "account" ON "disp"."account_id" = "account"."account_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "client"."gender" = 'F' AND "client"."birth_date" = '1976-01-29';

/*
Prediction Result:
*/