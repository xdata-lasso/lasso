-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1016, 'Kevin Cox', 'Watts, Robinson and Nguyen', 1034, 'size');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1017, 'Donald Reid', 'Perez Inc', 1031.0, 'option');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1018, 'Jacob Clark', 'Morales-Jones', 1040.0, 'nothing');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1019, 'Timothy Wong', 'Walter, Edwards and Rios', 1049.0, 'everyone');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1020, 'Carolyn Daniel', 'Wilkerson-Day', 1058.0, 'skin');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1021, 'James Mayo', 'Baker and Sons', 1067.0, 'pattern');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1028, 'Bobby Hall', 'Maldonado PLC', 1022, 'claim');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1029, 'Brenda Snyder PhD', 'Mack-Peterson', 1043.0, 'hour');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1030, 'Brittany Moore', 'Graham-Chavez', 1052.0, 'sound');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1031, 'Linda Cruz', 'Liu, Baker and Mason', 1061.0, 'color');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1032, 'Julie King', 'Romero Inc', 1070.0, 'notice');
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1033, 'Terri Frazier', 'Evans, Fowler and Lynch', 1079.0, 'start');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date FROM (SELECT * FROM (SELECT * FROM church ORDER BY church_id DESC) LIMIT 3);

/*
Gold Result:
('Terri Frazier', 1079)
('Julie King', 1070)
('Linda Cruz', 1061)
*/

-- Prediction Query
SELECT name, open_date FROM church ORDER BY open_date DESC, church.church_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Terri Frazier', 1079)
('Julie King', 1070)
('James Mayo', 1067)
*/