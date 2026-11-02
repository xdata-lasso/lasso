-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (33, NULL, '32', '32', 34, '1000-02-05', NULL, NULL);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (20, 21, NULL, '27', NULL, NULL, NULL, NULL);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (21, '42', 43);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (22, '38', 38);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (24, '38', 38);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (23, '38', 38);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.aid AS aid, LHS.price AS price, LHS.n AS n, RHS.name AS name, RHS.distance AS distance FROM (SELECT aid, price, COUNT(*) AS n FROM (SELECT flno, destination AS origin, destination, distance, departure_date, arrival_date, price, aid, flno_other, distance_other, departure_date_other, arrival_date_other, price_other, aid_other FROM (SELECT flno, origin, origin AS destination, distance, departure_date, arrival_date, price, aid, flno_other, distance_other, departure_date_other, arrival_date_other, price_other, aid_other FROM (SELECT LHS.flno AS flno, LHS.origin AS origin, LHS.destination AS destination, LHS.distance AS distance, LHS.departure_date AS departure_date, LHS.arrival_date AS arrival_date, LHS.price AS price, LHS.aid AS aid, RHS.flno AS flno_other, RHS.distance AS distance_other, RHS.departure_date AS departure_date_other, RHS.arrival_date AS arrival_date_other, RHS.price AS price_other, RHS.aid AS aid_other FROM flight AS LHS INNER JOIN flight AS RHS ON (LHS.origin = RHS.destination AND LHS.destination = RHS.origin)))) GROUP BY aid, price) AS LHS LEFT JOIN aircraft AS RHS ON (LHS.aid = RHS.aid)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid GROUP BY T1.aid HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/