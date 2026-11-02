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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, 'film', 'sister', 'perhaps', 'deal', 'soon', 'according', 5615, 5619, 5623.5, 5627, 5631.5, 5635.5, 5639, 5643, 5647);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5612, 'organization', 'prevent', 'minute', 'significant', 'style', 'work', 5632.0, 5638.0, 5644.5, 5650.0, 5656.5, 5662.5, 5668.0, 5674.0, 5680.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5613, 'still', 'eight', 'spring', 'wear', 'else', 'it', 5649.0, 5657.0, 5665.5, 5673.0, 5681.5, 5689.5, 5697.0, 5705.0, 5713.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5614, 'fly', 'majority', 'stand', 'office', 'city', 'agent', 5666.0, 5676.0, 5686.5, 5696.0, 5706.5, 5716.5, 5726.0, 5736.0, 5746.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5651, 'early', 'those', 'ability', 'time', 'body', 'million', 5655, 5659, 5663.5, 5667, 5671.5, 5675.5, 5679, 5683, 5687);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5652, 'number', 'rule', 'song', 'sing', 'describe', 'as', 5672.0, 5678.0, 5684.5, 5690.0, 5696.5, 5702.5, 5708.0, 5714.0, 5720.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5653, 'half', 'act', 'really', 'short', 'next', 'change', 5689.0, 5697.0, 5705.5, 5713.0, 5721.5, 5729.5, 5737.0, 5745.0, 5753.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5654, 'provide', 'government', 'however', 'food', 'economy', 'seek', 5706.0, 5716.0, 5726.5, 5736.0, 5746.5, 5756.5, 5766.0, 5776.0, 5786.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 'each', 'watch', 'nature', 'itself', 'school', 'war', 5701, 5702, 5703.5, 5704, NULL, 5705.5, 5706, NULL, 5707);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5691, 0, 'far', '1984-03-07');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5692, 0, 'better', '1984-03-08');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5693, 0, 'animal', '1984-03-09');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5694, 0, 'will', '1984-03-10');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5695, 'F', '1988-07-11', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5696, 'F', '1988-07-12', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5697, 'F', '1988-07-13', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5698, 'F', '1988-07-14', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5699, 'F', '1987-07-12', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, (SELECT MAX(A11) - MIN(A11) FROM district) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client WHERE gender = 'F' ORDER BY birth_date ASC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.account_id, (SELECT MAX(A11) FROM district) - (SELECT MIN(A11) FROM district) AS salary_gap FROM account AS T1 JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' ORDER BY T2.birth_date ASC, T1.account_id NULLS LAST, T2.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5691, 109)
*/