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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1967, 'respond', 'wrong', 'every', 'boy', 'shoulder', 'police', 1971, 1975, 1979.5, 1983, 1987.5, 1991.5, 1995, 1999, 2003);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1968, 'threat', 'ahead', 'could', 'pick', 'stop', 'much', 1988.0, 1994.0, 2000.5, 2006.0, 2012.5, 2018.5, 2024.0, 2030.0, 2036.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1969, 'not', 'business', 'partner', 'leader', 'former', 'image', 2005.0, 2013.0, 2021.5, 2029.0, 2037.5, 2045.5, 2053.0, 2061.0, 2069.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1970, 'glass', 'understand', 'evidence', 'hair', 'least', 'we', 2022.0, 2032.0, 2042.5, 2052.0, 2062.5, 2072.5, 2082.0, 2092.0, 2102.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2007, 1967, 'part', '1973-06-11');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2008, 1967, 'customer', '1973-06-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2009, 1967, 'environmental', '1973-06-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2010, 1967, 'another', '1973-06-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2043, 1967, 'part', '1973-06-11');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2011, 2007, '1977-10-15', 2015, 2019, 2023.5, 'section');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2012, 2007, '1977-10-16', 2024.0, 2030.0, 2036.5, 'ability');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2013, 2007, '1977-10-17', 2033.0, 2041.0, 2049.5, 'nature');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2014, 2007, '1977-10-18', 2042.0, 2052.0, 2062.5, 'sure');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2044, 2043, '1977-10-15', 2142, 2019, 2023.5, 'section');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2027, 2007, '1981-03-19', 'nothing', 'site', 2031, 2035, 'lawyer', 'price', 2039);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2028, 2007, '1981-03-20', 'right', 'religious', 2044.0, 2050.0, 'red', 'record', 2060.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2029, 2007, '1981-03-21', 'serve', 'debate', 2057.0, 2065.0, 'wife', 'thus', 2081.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2030, 2007, '1981-03-22', 'yard', 'himself', 2070.0, 2080.0, 'give', 'capital', 2102.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM loan AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id ORDER BY T1.amount DESC, T2.date ASC, T1.loan_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2031,)
*/

-- Prediction Query
WITH LargestLoan AS (SELECT account_id FROM loan ORDER BY amount DESC, loan.loan_id NULLS LAST LIMIT 1) SELECT t.amount FROM trans AS t INNER JOIN LargestLoan AS ll ON t.account_id = ll.account_id ORDER BY t.date ASC, t.trans_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/