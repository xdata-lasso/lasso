-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1001, 'Allison Hill', 'USNV Garcia
FPO AA 13177', '991.417.1822', 'ntucker@example.com');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1002, 'Noah Rhodes', '407 Teresa Lane Apt. 849
Barbaraland, AZ 87174', '989-363-8346x578', 'martinaaron@example.com');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1003, 'Angie Henderson', '31647 Martin Knoll Apt. 419
New Jessica, GA 61090', '531.250.9839', 'sara74@example.com');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1004, 'Daniel Wagner', '503 Linda Locks
Carlshire, FM 94599', '603-910-5183', 'smoore@example.org');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1005, 'Cristian Santos', '7242 Julie Plain Suite 969
Coxberg, NY 65187', '582.399.7376', 'rileyamy@example.net');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1006, 'Connie Lawrence', '22691 James Mountain
Tashatown, TX 94967', '865-766-7010', 'brian97@example.net');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1007, 'Abigail Shaffer', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', '633-938-7262', 'brianromero@example.org');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1008, 'Gina Moore', '809 Burns Creek
Natashaport, IA 08093', '517.481.0801', 'larsonemma@example.org');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1009, 1001, 'international', 1017.5, '1970-01-01');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1010, 1002, 'call', 1026.5, '1970-01-02');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1011, 1003, 'year', 1035.5, '1970-01-03');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1012, 1004, 'voice', 1044.5, '1970-01-04');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1013, 1005, 'over', 1053.5, '1970-01-05');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1014, 1006, 'employee', 1062.5, '1970-01-06');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1015, 1007, 'particular', 1071.5, '1970-01-07');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1016, 1008, 'phone', 1080.5, '1970-01-08');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1025, 1009, 'among', 1033.5, '1978-09-09');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1026, 1010, 'president', 1042.5, '1978-09-10');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1027, 1011, 'beat', 1051.5, '1978-09-11');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1028, 1012, 'kind', 1060.5, '1978-09-12');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1029, 1013, 'really', 1069.5, '1978-09-13');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1030, 1014, 'past', 1078.5, '1978-09-14');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1031, 1015, 'other', 1087.5, '1978-09-15');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1032, 1016, 'necessary', 1096.5, '1978-09-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Transactions GROUP BY account_id ORDER BY SUM(amount) DESC, account_id NULLS LAST LIMIT 5;

/*
Gold Result:
(1016,)
(1015,)
(1014,)
(1013,)
(1012,)
*/

-- Prediction Query
SELECT account_id FROM Transactions GROUP BY account_id LIMIT 5;

/*
Prediction Result:
(1009,)
(1010,)
(1011,)
(1012,)
(1013,)
*/