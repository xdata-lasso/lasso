-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 5000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'NYC', 'LA', 2500, '2023-01-01', '2023-01-01', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 1, 'NYC', 'SF', 2600, '2023-01-01', '2023-01-01', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 1, 'NYC', 'LA', 2500, '2023-01-01', '2023-01-02', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (104, 1, 'NYC', 'LA', 2500, '2023-01-02', '2023-01-02', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (105, 1, 'NYC', 'LA', 2500, '2023-01-03', '2023-01-03', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (106, 2, 'BOS', 'MIA', 1500, '2023-01-01', '2023-01-01', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (107, 2, 'BOS', 'MIA', 1500, '2023-01-05', '2023-01-05', 200.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, n AS count___ FROM (SELECT arrival_date, origin, COUNT(*) AS n FROM flight GROUP BY arrival_date, origin) ORDER BY origin, count___ NULLS LAST;

/*
Gold Result:
('BOS', 1)
('BOS', 1)
('NYC', 1)
('NYC', 2)
('NYC', 2)
*/

-- Prediction Query
SELECT origin, COUNT(*) FROM Flight GROUP BY origin;

/*
Prediction Result:
('BOS', 2)
('NYC', 5)
*/