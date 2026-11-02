-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Cessna 172', 800);
INSERT INTO aircraft (aid, name, distance) VALUES (20, 'Gulfstream G650', 7000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (5, 20, 'LA', 'Sydney', 7500, '2023-12-01', '2023-12-02', 1200);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (15, 20, 'SF', 'Sydney', 7400, '2023-11-01', '2023-11-02', 1100);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (25, 10, 'Dallas', 'Atlanta', 700, '2023-10-01', '2023-10-01', 150);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (500, 10, 'Austin', 'Berlin', 5000, '2023-01-01', '2023-01-02', 800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destination FROM (SELECT * FROM (SELECT * FROM (SELECT destination, flno, COUNT(*) AS n FROM flight GROUP BY destination, flno) ORDER BY flno DESC) LIMIT 1);

/*
Gold Result:
('Berlin',)
*/

-- Prediction Query
SELECT destination FROM Flight GROUP BY destination ORDER BY COUNT(*), destination NULLS LAST LIMIT 1;

/*
Prediction Result:
('Atlanta',)
*/