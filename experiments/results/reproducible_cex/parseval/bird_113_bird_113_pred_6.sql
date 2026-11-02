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
-- Inserting into table: account --
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 1, 'a9000t5c4eci', '2021-03-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, '5s5b', '2020-04-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'iqa', '2024-10-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, '5k5swwqcgs', '2021-12-04');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'd21vy9uxj4hw', 'd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -841004020, -361507387, 395.809081, 401805964, 154.065416, 261.415754, -1255130038, -1762857309, 806170397);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'dpos', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'e', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, '76nium52', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, '02eu', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'qv0gcb98ozk', '2024-06-15', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'kn6vck6ah0f8', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, '7', '2024-06-15', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'z16ni', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'ogrgjd8y', '2024-06-15', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 'tsj3ayxp1q4', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'afu5w1of7', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, '0v', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, 'q8qdjpe1', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'tg6bnou5zi', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, '6c4bfkfo', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483633, 'd5ysxc', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483632, 'q5l', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483631, '8qs27p2r', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483630, '4gth2mnaj', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483629, 'la3', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'fe4hri', '2020-01-20', 1);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '1996-01-03', 98832, -1576219117, 75.403642, 'nw6klf');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '1996-01-03', 98832, -443340271, 676.357279, '4nrq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 1, '1996-01-03', 98832, 418417917, 220.906948, 'qy');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '1996-01-03', 98832, 2074205376, 274.580687, 'ytoo3o9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 1, '1996-01-03', 98832, -155284187, 892.659478, 'lyr');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '1996-01-03', 98832, -1520489792, 346.706184, 'q7x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 1, '1996-01-03', 98832, 602161869, 814.417862, 'a7ryfd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 3, '1996-01-03', 98832, 2011234363, 154.68882, '5dh');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '1996-01-03', 98832, 1129658414, 308.482994, 'afgogri');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '1996-01-03', 98832, -1538707438, 774.445116, 'den8c68x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '1996-01-03', 98832, 1774087382, 13.875982, 'x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 3, '1996-01-03', 98832, 76996700, 398.637058, '72ctdctmfg62');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 3, '1996-01-03', 98832, -1180042408, 445.968654, '507cvtjpt');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 3, '1996-01-03', 98832, -1950324754, 992.626961, '7z2zezjo7wg');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483634, 1, '2024-06-15', 98832, -405743609, 49.297401, '5i3');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483633, 1, '1996-01-03', 1, 1339733032, 236.262879, 'm5k');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483632, 1, '1996-01-03', 98832, 1803796945, 338.437591, 'uttmu2ne578');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2024-06-15', 1, 1610062532, 475.173408, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2020-01-20',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
*/

-- Prediction Query
SELECT T1.birth_date FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN loan AS T4 ON T3.account_id = T4.account_id WHERE T4.amount = 98832 AND T4.date = '1996-01-03';

/*
Prediction Result:
*/