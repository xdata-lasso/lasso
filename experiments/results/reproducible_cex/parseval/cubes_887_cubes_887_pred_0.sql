-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'air_777cba', 1.0);

-- Inserting into table: flight --
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1.0, 1.0, 'fli_f58188', 'fli_564835', 1.0, '2025-06-17', '2021-11-08', 0.01);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (0.0, 1.0, 'fli_f58188', 'fli_564835', 0.0, '2024-01-05', '2022-12-08', 0.02);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (2.0, 1.0, 'fli_f58188', 'fli_564835', 3.0, '2023-04-14', '2021-12-04', 0.03);

INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (-1.0, 1.0, 'fli_f58188', 'fli_564835', 0.0, '2020-06-08', '2025-04-30', 0.04);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM (SELECT * FROM (SELECT * FROM flight ORDER BY price, flight.flno NULLS LAST) LIMIT 3);

/*
Gold Result:
(1.0,)
(0.0,)
(2.0,)
*/

-- Prediction Query
SELECT flno FROM Flight ORDER BY distance ASC, Flight.flno NULLS LAST LIMIT 3;

/*
Prediction Result:
(-1.0,)
(0.0,)
(1.0,)
*/