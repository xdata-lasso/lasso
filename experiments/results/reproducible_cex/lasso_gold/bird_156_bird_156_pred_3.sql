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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2839, 'time', 'lead', 'machine', 'nearly', 'system', 'side', 2843, 2847, 2851.5, 2855, 2859.5, 2863.5, 2867, 2871, 2875);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2840, 'test', 'high', 'second', 'rather', 'stage', 'executive', 2860.0, 2866.0, 2872.5, 2878.0, 2884.5, 2890.5, 2896.0, 2902.0, 2908.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2841, 'might', 'prove', 'learn', 'expect', 'member', 'future', 2877.0, 2885.0, 2893.5, 2901.0, 2909.5, 2917.5, 2925.0, 2933.0, 2941.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2842, 'born', 'them', 'similar', 'power', 'that', 'together', 2894.0, 2904.0, 2914.5, 2924.0, 2934.5, 2944.5, 2954.0, 2964.0, 2974.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2907, 'subject', 'pick', 'action', 'effort', 'one', 'race', 2911, 2915, 2919.5, 2923, 2927.5, 2931.5, 2935, 2939, 2943);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2908, 'evening', 'science', 'nation', 'service', 'son', 'seek', 2928.0, 2934.0, 2940.5, 2946.0, 2952.5, 2958.5, 2964.0, 2970.0, 2976.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2909, 'grow', 'fact', 'cut', 'investment', 'effect', 'military', 2945.0, 2953.0, 2961.5, 2969.0, 2977.5, 2985.5, 2993.0, 3001.0, 3009.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2910, 'far', 'only', 'bed', 'middle', 'maybe', 'line', 2962.0, 2972.0, 2982.5, 2992.0, 3002.5, 3012.5, 3022.0, 3032.0, 3042.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2879, 2839, 'else', '1972-03-23');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2880, 2839, 'worry', '1972-03-24');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2881, 2839, 'before', '1972-03-25');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2882, 2839, 'family', '1972-03-26');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2947, 2907, 'structure', '1984-04-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2948, 2907, 'adult', '1984-04-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2949, 2907, 'better', '1984-04-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2950, 2907, 'financial', '1984-04-15');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2883, 'upon', '1976-07-04', 2839);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2884, 'little', '1976-07-05', 2839);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2885, 'over', '1976-07-06', 2839);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2886, 'poor', '1976-07-07', 2839);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2951, 'do', '1988-08-16', 2907);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2952, 'role', '1988-08-17', 2907);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2953, 'follow', '1988-08-18', 2907);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2954, 'record', '1988-08-19', 2907);
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2888, 2883, 2879, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2889, 2883, 2879, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2890, 2883, 2879, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2955, 2883, 2879, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2887, 2951, 2947, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2956, 2951, 2947, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2957, 2951, 2947, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2958, 2951, 2947, 'OWNER');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2891, 2879, '1980-11-08', 2990.0, 2899, 2903.5, 'today');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2893, 2879, '1980-11-09', 2904.0, 2910.0, 2916.5, 'garden');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2894, 2879, '1980-11-10', 2913.0, 2921.0, 2929.5, 'difference');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2959, 2879, '1980-11-11', 2922.0, 2932.0, 2942.5, 'hear');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2892, 2947, '1992-01-20', 2990.0, 2967, 2971.5, 'party');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2960, 2947, '1992-01-21', 2972.0, 2978.0, 2984.5, 'on');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2961, 2947, '1992-01-22', 2981.0, 2989.0, 2997.5, 'guy');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2962, 2947, '1992-01-23', 2895, 3000.0, 3010.5, 'skill');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2951,)
*/

-- Prediction Query
SELECT T2.client_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T2.type = 'OWNER' ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2883,)
*/