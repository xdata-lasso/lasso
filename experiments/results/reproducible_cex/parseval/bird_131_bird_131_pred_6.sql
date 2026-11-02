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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 3, '4', '2024-04-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'gjd8y', '2024-05-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 3, '1afgogritsj', '2025-02-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 6, 'ex1', '2025-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 3, '7zw', '2020-03-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 7, 'nrqrofqy', '2022-09-19');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', 't2__280f60', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'prmd', 't2__280f60', 'posiie5unw6k', 'fa9', '00t5c4e', 'cigce376nium', 283598170, 742285925, 21.917736, -747753377, 478.908865, 203.577612, 902887186, -967741825, 775304493);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 998.887019, -533293970, 520.715697, 541.066766, -977635379, 1661181156, -1372125820);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'x58pz0f8jeg', 't2__280f60', 'd21vy9uxj4hw', 'd', 'lph2gn', 'q', -664193365, -1070063173, 629.317167, 722884590, 635.267184, 210.05299, 1575412235, -988981234, -841004020);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', 602161869, 1350414441, 987.646344, -961217731, 86.816079, 60.297953, 777149609, 61479715, -1496556994);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, '5k5swwqcgs', 't2__4dd647', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'wbbp6luhvdlt', 't2__4dd647', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 1038707349, 1419861592, 663.001988, 374105386, 950.466571, 796.740316, -1683203397, 528680845, -1585009206);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, '52zb', 'dis_1b3175', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '5k5swwqcgs', 'val_1', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 517.275698, 1155439218, 805.746877, 322.782838, 283598170, 742285925, -747753377);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '2021-05-27', 1, -1364429300, 998.421621, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2022-09-10', 1, -1025564911, 447.109657, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 1, '2021-11-05', 1, -705985602, 604.643336, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 1, '2020-01-31', 0, -7597509, 651.586084, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 1, '2021-05-12', -1, 1583472758, 837.437794, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '2020-03-04', 1, 2111987706, 360.694313, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 3, '2024-09-24', 0, 1792827279, 632.340892, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 1, '2025-04-30', 0, -1538707438, 774.445116, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '2025-03-06', -1, 1476361420, 216.6701, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 3, '2020-07-09', 0, -683007527, 757.137864, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 3, '2020-06-09', -1, 1523825314, 983.924121, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '2023-07-08', 1, 1371234901, 354.593207, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2024-11-06', 0, 765724008, 528.552305, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 3, '2022-09-26', 1, -435350511, 689.065203, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483634, 3, '2025-11-01', 0, 1992637800, 308.935851, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483633, 1, '2020-06-04', 1, 1303877941, 695.452114, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483632, 1, '2022-04-02', 0, -1784554553, 806.601275, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483631, 3, '2024-12-21', 0, -1744557630, 935.463334, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483630, 3, '2025-07-11', -1, -1021978385, 632.482455, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483629, 1, '2022-08-18', 1, -1858644047, 140.053935, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483628, 1, '2022-07-11', 0, -241848752, 518.274259, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483627, 3, '2025-07-18', 1, 2119806856, 848.763933, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483626, 3, '2025-11-04', 0, 2004147439, 338.933701, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483625, 3, '2021-08-18', 1, -847293924, 511.172331, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2020-04-18', 1, -1171104889, 813.864654, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2025-07-13', 1, -1575410149, 510.534763, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483622, 3, '2020-05-11', 1, 1722106924, 17.379583, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483621, 3, '2021-11-12', 1, 1201273976, 660.336025, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483620, 3, '2022-07-17', 1, -1950324754, 992.626961, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483619, 3, '2025-10-22', 1, -406331049, 392.567695, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483618, 1, '2024-05-20', 1, 304189298, 108.948237, 't3__343ed0');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 2, '2024-12-25', 2, 364869063, 278.010437, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 3, '2025-02-23', 3, 2142703426, 375.832821, 'C');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483615, 4, '2025-11-02', 244829661, -1362461264, 943.791649, 'l0b4y');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 6, '2025-06-25', 1884179925, 902551284, 22.720462, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('ilbnp',)
*/

-- Prediction Query
SELECT d.A3 AS district_name, COUNT(l.loan_id) AS active_loan_count FROM district AS d INNER JOIN account AS a ON d.district_id = a.district_id INNER JOIN loan AS l ON a.account_id = l.account_id WHERE l.status IN ('C', 'D') GROUP BY d.A3 ORDER BY active_loan_count DESC, district_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('2eutliqa11r', 16)
*/