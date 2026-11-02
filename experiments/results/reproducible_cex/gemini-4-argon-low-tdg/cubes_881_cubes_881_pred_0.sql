-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Boeing 777', 9500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Airbus A380', 10000);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'Airbus A320', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (5, 'Boeing 737', 3500);
INSERT INTO aircraft (aid, name, distance) VALUES (6, 'Embraer E190', 2400);
INSERT INTO aircraft (aid, name, distance) VALUES (7, 'Bombardier CRJ', 1500);
INSERT INTO aircraft (aid, name, distance) VALUES (8, 'Cessna 172', 800);
INSERT INTO aircraft (aid, name, distance) VALUES (9, 'Gulfstream G650', 7500);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 8, 'LAX', 'SFO', 15000, '2023-01-01', '2023-01-01', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 7, 'LAX', 'JFK', 14000, '2023-01-02', '2023-01-02', 600.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT aid, name, AVG(distance) AS meandistance FROM aircraft GROUP BY aid, name) ORDER BY meandistance DESC) LIMIT 7);

/*
Gold Result:
('Airbus A380',)
('Boeing 777',)
('Boeing 747',)
('Gulfstream G650',)
('Boeing 737',)
('Airbus A320',)
('Embraer E190',)
*/

-- Prediction Query
SELECT name FROM Aircraft WHERE distance > (SELECT AVG(distance) FROM Aircraft);

/*
Prediction Result:
('Boeing 747',)
('Boeing 777',)
('Airbus A380',)
('Gulfstream G650',)
*/