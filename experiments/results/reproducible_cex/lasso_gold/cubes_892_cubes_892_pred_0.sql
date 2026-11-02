-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1082.5, 'Derek Zuniga', 1083.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1087.5, 'Lisa Jackson', 1088.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1084.5, 1082.5, 'Los Angeles', 'Honolulu', 1085.5, '1973-11-11', '1974-01-11', 1086.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1089.5, 1087.5, 'Los Angeles', 'Honolulu', 1090.5, '1973-11-10', '1976-03-13', 1091.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "departure_date", "arrival_date" FROM "flight" WHERE ("origin" = 'Los Angeles' AND "destination" = 'Honolulu') ORDER BY departure_date, flight.flno NULLS LAST;

/*
Gold Result:
('1973-11-10', '1976-03-13')
('1973-11-11', '1974-01-11')
*/

-- Prediction Query
SELECT departure_date, arrival_date FROM Flight WHERE origin = 'Los Angeles' AND destination = 'Honolulu';

/*
Prediction Result:
('1973-11-11', '1974-01-11')
('1973-11-10', '1976-03-13')
*/