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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'bnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'p', '2024-08-27');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'oo3o9', '2021-04-03');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'F', '2023-05-30', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'F', '2024-09-12', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, '5c4ec', '2021-06-11', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 't1__2fef32', '2021-11-08', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, 1, 1, 'dpos');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 1, 1, 'yrq13pyu78d9');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, 3, 3, 'jsl');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, 4, 1, 'swwqcgsk');

-- Inserting into table: card --
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483648, 1, 'ie5', '2023-09-04');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483647, 1, 'gce376nium52', '2024-06-13');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483646, 1, '2eutliqa11r', '2024-03-30');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483645, 3, 'b4yp5qi', '2025-01-05');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483644, 1, '1vy9uxj4', '2021-05-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483643, 1, 'cprj', '2023-05-30');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483642, 3, 'qv0gcb98ozk', '2025-03-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483641, 1, 'ah0f8jsww', '2021-12-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483640, 1, 'z16nijjai5d', '2021-05-12');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483639, 3, 'tsj', '2025-02-02');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483638, 3, 'den8c68x', '2023-10-28');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483637, 3, 'o72ctdc', '2023-06-03');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (2, 1, '1i', '2022-07-11');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (3, 1, '278507cv', '2023-05-06');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483634, 3, 'f', '2021-11-12');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483633, 3, '5', '2024-03-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483632, 3, 's27p2r94gth2', '2022-03-04');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483631, 3, '57', '2025-12-24');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483630, 1, 'pdjwzw5chn9', '2022-02-22');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483629, 1, '0', '2022-12-01');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483628, 1, '32o', '2020-08-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (4, 4, '9n8c4pgu7v', '2020-12-20');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '2022-06-13', 44952191, 1151980946, 83.204633, '9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2020-03-30', 757448742, -1179823637, 760.580899, 'rqrofqyp5s');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 3, '2022-02-06', 1178636309, -1390245819, 763.856372, 'x14ji7zwau2d');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 1, '2023-01-22', 2056419640, 222415430, 263.638479, 'x58pz0f8jeg');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 1, '2023-12-18', -2050247126, -736979194, 989.653112, 'h2gndqwnqcx5');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '2023-07-15', -361507387, 401805964, 154.065416, '8n2f3');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 1, '2024-06-09', 1686459626, -1554531873, 728.712934, 'kn6vc');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 1, '2022-12-03', -566887085, 602161869, 814.417862, 'a7ryfd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 3, '2025-06-24', -1738458256, -1714354341, 54.980195, 'yzt1afgog');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 1, '2020-03-04', 2111987706, -598313376, 959.196496, '4301j');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 1, '2020-02-26', 2035306060, 1523825314, 983.924121, '5w1of7');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '2022-04-02', -1784554553, -242584410, 415.494881, '5q8qdj');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2021-08-18', -847293924, -2033879835, 918.655561, '5zi36c');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 1, '2021-01-09', 1923659053, -1950324754, 992.626961, '7z2zezjo7wg');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483634, 1, '2023-03-21', -546516406, -405743609, 49.297401, '5i3');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483633, 1, '2022-12-17', 1816660482, -1212676731, 893.960343, '5k58');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483632, 1, '2022-05-15', -2136247961, -1478011227, 11.892553, 'okv8uttmu2');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483631, 1, '2021-12-11', 697257217, -451030047, 636.053055, 'be8yvkv42q');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483630, 1, '2024-02-23', 756202403, 782684333, 476.006677, 'pmaus3auvmk');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483629, 1, '2022-07-11', -354292049, 238533676, 419.43898, 'xfo');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483628, 1, '2020-12-03', -634585028, 1719800120, 55.294573, '2zob');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483627, 1, '2024-01-02', 440115543, 292557306, 665.099697, 'lwyng');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2020-09-26', -1633151678, -252690330, 797.015047, 'uzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id WHERE T1.gender = 'F';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(3,)
(3,)
(3,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(3,)
(3,)
(3,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(3,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id INNER JOIN loan AS T5 ON T3.account_id = T5.account_id WHERE T1.gender = 'F' AND T2.type = 'OWNER';

/*
Prediction Result:
*/