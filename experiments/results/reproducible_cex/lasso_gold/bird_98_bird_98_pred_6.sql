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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2874, 'such', 'method', 'air', 'success', 'manage', 'none', 2878, 2882, 2886.5, 2890, 2894.5, 2898.5, 2902, 2906, 2910);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2875, 'player', 'explain', 'great', 'interview', 'wide', 'agreement', 2895.0, 2901.0, 2907.5, 2913.0, 2919.5, 2925.5, 2931.0, 2937.0, 2943.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2876, 'water', 'least', 'relate', 'shake', 'care', 'indeed', 2912.0, 2920.0, 2928.5, 2936.0, 2944.5, 2952.5, 2960.0, 2968.0, 2976.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2877, 'discussion', 'mention', 'respond', 'company', 'prevent', 'person', 2929.0, 2939.0, 2949.5, 2959.0, 2969.5, 2979.5, 2989.0, 2999.0, 3009.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2934, 'later', 'court', 'development', 'sort', 'theory', 'beat', 2938, 2942, 2946.5, 2950, 2954.5, 2958.5, 2962, 2966, 2970);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2935, 'central', 'ever', 'look', 'until', 'know', 'many', 2955.0, 2961.0, 2967.5, 2973.0, 2979.5, 2985.5, 2991.0, 2997.0, 3003.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2936, 'trial', 'hundred', 'general', 'fall', 'entire', 'after', 2972.0, 2980.0, 2988.5, 2996.0, 3004.5, 3012.5, 3020.0, 3028.0, 3036.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2937, 'main', 'generation', 'green', 'soldier', 'they', 'so', 2989.0, 2999.0, 3009.5, 3019.0, 3029.5, 3039.5, 3049.0, 3059.0, 3069.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2914, 2874, 'POPLATEK TYDNE', '1977-03-09');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2916, 2874, 'POPLATEK TYDNE', '1977-03-10');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2917, 2874, 'POPLATEK TYDNE', '1977-03-11');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2974, 2874, 'POPLATEK TYDNE', '1977-03-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2915, 2934, 'POPLATEK TYDNE', '1981-07-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2975, 2934, 'POPLATEK TYDNE', '1981-07-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2976, 2934, 'POPLATEK TYDNE', '1981-07-15');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2977, 2934, 'POPLATEK TYDNE', '1981-07-16');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2919, 2914, '1997-01-01', 2922, 2926, 2930.5, 'notice');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2920, 2914, '1997-01-01', 2931.0, 2937.0, 2943.5, 'recognize');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2921, 2914, '1997-01-01', 2940.0, 2948.0, 2956.5, 'because');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2978, 2914, '1997-01-01', 2949.0, 2959.0, 2969.5, 'question');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2918, 2915, '1997-01-01', 2922, 2927, 2931.5, 'organization');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2979, 2915, '1997-01-01', 2991.0, 2997.0, 3003.5, 'area');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2980, 2915, '1997-01-01', 3000.0, 3008.0, 3016.5, 'hard');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2981, 2915, '1997-01-01', 3009.0, 3019.0, 3029.5, 'door');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2915,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a INNER JOIN loan AS l ON a.account_id = l.account_id WHERE STRFTIME('%Y', l.date) = '1997' AND a.frequency = 'POPLATEK TYDNE' ORDER BY l.amount ASC, a.account_id NULLS LAST, l.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2914,)
*/