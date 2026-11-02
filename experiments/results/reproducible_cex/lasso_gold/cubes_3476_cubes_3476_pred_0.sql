-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1074.5, 'Donald Reid', 1077.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1075.5, 'Jacob Clark', 1084.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1076.5, 'Timothy Wong', 1091.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1080.5, 1074.5, 'politics', 'Martinique', 1083.5, '1977-04-14', '1980-07-17', NULL);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1081.5, 1074.5, 'prove', 'Saint Lucia', 1094.5, '1977-04-15', '1980-07-18', NULL);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1082.5, 1074.5, 'Congress', 'Ecuador', 1105.5, '1977-04-16', '1980-07-19', NULL);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1089.5, 1074.5, 'common', 'Faroe Islands', 1092.5, '1983-10-20', '1986-02-23', NULL);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1090.5, 1074.5, 'maintain', 'Uzbekistan', 1103.5, '1983-10-21', '1986-02-24', NULL);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1091.5, 1074.5, 'hundred', 'Northern Mariana Islands', 1114.5, '1983-10-22', '1986-02-25', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT flno, distance FROM (SELECT LHS.flno AS flno, LHS.origin AS origin, LHS.destination AS destination, LHS.distance AS distance, LHS.departure_date AS departure_date, LHS.arrival_date AS arrival_date, LHS.price AS price, LHS.aid AS aid, LHS.maxprice AS maxprice, RHS.flno AS flno_other, RHS.origin AS origin_other, RHS.destination AS destination_other, RHS.distance AS distance_other, RHS.departure_date AS departure_date_other, RHS.arrival_date AS arrival_date_other, RHS.price AS price_other, RHS.aid AS aid_other, RHS.maxprice AS maxprice_other FROM (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, MAX(price) OVER () AS maxprice FROM flight) AS LHS CROSS JOIN (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, MAX(price) OVER () AS maxprice FROM flight) AS RHS) WHERE (price >= maxprice_other AND price_other < maxprice_other) ORDER BY flno, distance NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT flno, distance FROM Flight ORDER BY price DESC, Flight.flno NULLS LAST LIMIT 1;

/*
Prediction Result:
(1080.5, 1083.5)
*/