-- Schema DDL
CREATE TABLE "Breeds" ("breed_code" TEXT(10) PRIMARY KEY, "breed_name" TEXT(80));

CREATE TABLE "Charges" ("charge_id" INTEGER PRIMARY KEY, "charge_type" TEXT(10), "charge_amount" REAL(19, 4));

CREATE TABLE "Sizes" ("size_code" TEXT(10) PRIMARY KEY, "size_description" TEXT(80));

CREATE TABLE "Treatment_Types" ("treatment_type_code" TEXT(10) PRIMARY KEY, "treatment_type_description" TEXT(80));

CREATE TABLE "Owners" ("owner_id" INTEGER PRIMARY KEY, "first_name" TEXT(50), "last_name" TEXT(50), "street" TEXT(50), "city" TEXT(50), "state" TEXT(20), "zip_code" TEXT(20), "email_address" TEXT(50), "home_phone" TEXT(20), "cell_number" TEXT(20));

CREATE TABLE "Dogs" ("dog_id" INTEGER PRIMARY KEY, "owner_id" INTEGER, "size_code" TEXT(10), "breed_code" TEXT(10), "abandoned_yn" TEXT(1), "name" TEXT(50), "age" TEXT(20), "date_of_birth" DATETIME, "gender" TEXT(1), "weight" TEXT(20), "date_arrived" DATETIME, "date_adopted" DATETIME, "date_departed" DATETIME, FOREIGN KEY ("owner_id") REFERENCES "Owners" ("owner_id"), FOREIGN KEY ("size_code") REFERENCES "Sizes" ("size_code"), FOREIGN KEY ("breed_code") REFERENCES "Breeds" ("breed_code"));

CREATE TABLE "Professionals" ("professional_id" INTEGER PRIMARY KEY, "role_code" TEXT(10), "first_name" TEXT(50), "street" TEXT(50), "city" TEXT(50), "state" TEXT(20), "zip_code" TEXT(20), "last_name" TEXT(50), "email_address" TEXT(50), "home_phone" TEXT(20), "cell_number" TEXT(20));

CREATE TABLE "Treatments" ("treatment_id" INTEGER PRIMARY KEY, "dog_id" INTEGER, "professional_id" INTEGER, "treatment_type_code" TEXT(10), "date_of_treatment" DATETIME, "cost_of_treatment" REAL(19, 4), FOREIGN KEY ("dog_id") REFERENCES "Dogs" ("dog_id"), FOREIGN KEY ("professional_id") REFERENCES "Professionals" ("professional_id"), FOREIGN KEY ("treatment_type_code") REFERENCES "Treatment_Types" ("treatment_type_code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('bank', 'Randy Conley');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('find', 'Amanda Rogers');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('three', 'Bonnie Bennett');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('story', 'Ronald Wise');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('spend', 'Katherine Castillo');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('fight', 'Taylor Griffith');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('sea', 'Kenneth Daniels');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('despite', 'Jennifer Reed');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1063, 'Lisa', 'Rhodes', '83473 Gregory Ports Suite 746
Burchborough, AS 79755', 'North Johnmouth', 'South Carolina', '55101', 'millsmichael@example.net', '001-419-352-0585x2772', '+1-845-411-5447');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1064, 'Gabriel', 'Young', '75818 Justin Track Apt. 478
Port Samuel, PW 29603', 'North Maryfort', 'Minnesota', '25052', 'myerstheodore@example.net', '001-970-643-0305x486', '001-775-470-5964x016');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1065, 'Samuel', 'Wallace', '60685 Paul Common Suite 305
Port Jennifermouth, WY 19643', 'Lake Zacharybury', 'Kansas', '87581', 'qzavala@example.net', '8348505415', '7298702135');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1066, 'Robert', 'Mitchell', '2779 Rebecca Brook Suite 328
Rodriguezport, IA 39973', 'West Ruben', 'Oregon', '88085', 'kellycarlos@example.org', '001-876-452-7758x4161', '001-409-727-5571');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1083, 'Kendra', 'Miller', '421 John Skyway Apt. 301
Riverafort, CT 89786', 'Nelsonville', 'Utah', '80580', 'christopher12@example.org', '+1-753-501-7426x8414', '628.267.9087x406');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1084, 'Dwayne', 'Bradshaw', '267 Santos Throughway
Manuelton, PW 12226', 'Franciscomouth', 'Wisconsin', '84220', 'pmorris@example.org', '927.527.9568', '001-639-810-6518x0170');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1085, 'Bobby', 'Douglas', '026 Sarah Camp
Frenchburgh, WA 38442', 'Jennifertown', 'Illinois', '53649', 'patrick74@example.com', '001-539-418-7851x91088', '(426)756-7661');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1086, 'Stephanie', 'Burgess', '9915 Gibson Row
Smallberg, PR 66589', 'Krystalshire', 'Idaho', '56560', 'brandi90@example.com', '(958)271-3971', '628-968-2300');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1067, 'Occupational therapist', 'Susan', 'PSC 1447, Box 3947
APO AE 16575', 'Davidside', 'Hawaii', '45854', 'King', 'christina18@example.net', '839-669-0784x473', '327.887.7470');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1068, 'Interior and spatial designer', 'Anthony', '2715 Mckinney Plaza
Patriciaburgh, VT 93504', 'Port Tammy', 'Massachusetts', '68513', 'Reid', 'brittanycarpenter@example.org', '710.727.6773x592', '273.339.5004x79748');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1069, 'Health promotion specialist', 'Jacob', 'PSC 2583, Box 1323
APO AA 03946', 'Shawton', 'Virginia', '37731', 'Pierce', 'megan90@example.org', '001-956-525-8815x3714', '(624)356-5060x98358');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1070, 'Fisheries officer', 'April', '8291 Kyle Stravenue Suite 866
East Teresaland, NV 61558', 'New Ericburgh', 'Iowa', '10837', 'Martinez', 'williamsdarlene@example.net', '(710)746-9632', '(787)484-9912x1655');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1087, 'Sport and exercise psychologist', 'Madeline', 'USS Johnson
FPO AP 55451', 'Hernandezfurt', 'Arkansas', '18076', 'Harris', 'nicholsmaria@example.org', '603-831-7393x6385', '(252)328-7280');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1088, 'Photographer', 'John', '31190 Harper Squares
East Joyfurt, NV 31216', 'Port Amanda', 'Oklahoma', '51411', 'Lucas', 'nicholas99@example.org', '585.744.5877x175', '+1-900-962-3120x38750');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1089, 'Ship broker', 'Michael', '84395 Young Wells
Lake Adriana, MT 39888', 'Port Jeremiah', 'Nebraska', '32332', 'Nielsen', 'lopezkathleen@example.net', '560-793-2048x99642', '6082860084');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1090, 'Museum education officer', 'Joshua', '687 Teresa Row
Floydmouth, UT 55069', 'Port Steven', 'North Dakota', '33923', 'Boone', 'timothybooth@example.com', '969.937.8547', '862.311.8233x98454');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('decide', 'American although require sound mind chance throw.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('play', 'Foreign party class wrong.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('Mr', 'Order medical meeting majority none.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('interest', 'Staff happy purpose woman on someone rise.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('hour', 'Wrong difficult range summer president.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('into', 'Behavior here need.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('machine', 'Pm reflect bar suddenly.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('other', 'Not teach believe month amount deep.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('rise', 'Enter pretty will official dinner anything lose.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('professional', 'Pick people subject challenge quite all way.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('agreement', 'Course kid industry include.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('picture', 'Improve simple turn their save.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('trip', 'Even under range exactly myself probably conference.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('role', 'Administration debate certain star start up.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('very', 'Class drive strong home to.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('our', 'Himself science so ready bad seat.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1071, 1063, 'decide', 'bank', 'assume', 'Frederick Bates', 'room', '1972-06-15', 'dark', 'fire', '1976-10-19', '1980-03-23', '1984-07-04');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1072, 1063, 'decide', 'bank', 'season', 'Emily Thompson', 'everything', '1972-06-16', 'employee', 'down', '1976-10-20', '1980-03-24', '1984-07-05');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1073, 1063, 'decide', 'bank', 'certainly', 'Gloria Gomez', 'poor', '1972-06-17', 'family', 'year', '1976-10-21', '1980-03-25', '1984-07-06');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1074, 1063, 'decide', 'bank', 'natural', 'Michelle Schneider', 'member', '1972-06-18', 'open', 'finish', '1976-10-22', '1980-03-26', '1984-07-07');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1091, 1083, 'hour', 'spend', 'half', 'Billy Jacobs', 'how', '1992-04-12', 'pay', 'sport', '1996-08-16', '1971-01-20', '1975-05-01');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1092, 1083, 'hour', 'spend', 'argue', 'Linda Novak', 'lay', '1992-04-13', 'recent', 'present', '1996-08-17', '1971-01-21', '1975-05-02');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1093, 1083, 'hour', 'spend', 'billion', 'Mark Bowers', 'cultural', '1992-04-14', 'husband', 'success', '1996-08-18', '1971-01-22', '1975-05-03');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1094, 1083, 'hour', 'spend', 'leave', 'Darren Tran', 'response', '1992-04-15', 'bed', 'sell', '1996-08-19', '1971-01-23', '1975-05-04');
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1075, 1071, 1067, 'rise', '1988-11-08', 1079.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1076, 1071, 1067, 'rise', '1988-11-09', 1092.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1077, 1071, 1067, 'rise', '1988-11-10', 1105.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1078, 1071, 1067, 'rise', '1988-11-11', 1118.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1095, 1091, 1087, 'trip', '1979-09-05', NULL);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1096, 1091, 1087, 'trip', '1979-09-06', NULL);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1097, 1091, 1087, 'trip', '1979-09-07', NULL);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1098, 1091, 1087, 'trip', '1979-09-08', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT owner_id, zip_code FROM (SELECT * FROM (SELECT * FROM (SELECT treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment, owner_id, abandoned_yn, breed_code, size_code, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number, SUM(cost_of_treatment) OVER () AS sumcost_of_treatment FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN dogs AS RHS ON (LHS.dog_id = RHS.dog_id)) AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id))) ORDER BY weight DESC) LIMIT 1);

/*
Gold Result:
(1083, '80580')
*/

-- Prediction Query
SELECT T1.owner_id, T1.zip_code FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id JOIN Treatments AS T3 ON T2.dog_id = T3.dog_id GROUP BY T1.owner_id ORDER BY SUM(T3.cost_of_treatment) DESC, T1.owner_id NULLS LAST, T1.zip_code NULLS LAST LIMIT 1;

/*
Prediction Result:
(1063, '55101')
*/