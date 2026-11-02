-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 737', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3500);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1, 1, 'Denver', 'Miami', 1700, '2023-05-01', '2023-05-01', 250.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (2, 1, 'Denver', 'Seattle', 1020, '2023-05-01', '2023-05-01', 180.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (3, 2, 'Denver', 'Boston', 1750, '2023-05-01', '2023-05-01', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (4, 1, 'Denver', 'Miami', 1700, '2023-05-02', '2023-05-02', 260.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (5, 2, 'Denver', 'Dallas', 640, '2023-05-03', '2023-05-03', 150.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (6, 1, 'Denver', 'Chicago', 880, '2023-05-03', '2023-05-03', 190.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (7, 2, 'Denver', 'Phoenix', 600, '2023-05-04', '2023-05-04', 120.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (8, 1, 'Austin', 'Denver', 770, '2023-05-01', '2023-05-01', 160.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (9, 2, 'Austin', 'Miami', 1100, '2023-05-01', '2023-05-01', 210.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 1, 'Boston', 'Denver', 1750, '2023-05-02', '2023-05-02', 310.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (11, 2, 'Boston', 'Austin', 1690, '2023-05-02', '2023-05-02', 290.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (12, 1, 'Boston', 'Miami', 1250, '2023-05-02', '2023-05-02', 220.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (13, 2, 'Boston', 'Chicago', 860, '2023-05-02', '2023-05-02', 175.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, n AS count___ FROM (SELECT arrival_date, origin, COUNT(*) AS n FROM flight GROUP BY arrival_date, origin) ORDER BY origin, count___ NULLS LAST;

/*
Gold Result:
('Austin', 2)
('Boston', 4)
('Denver', 1)
('Denver', 1)
('Denver', 2)
('Denver', 3)
*/

-- Prediction Query
SELECT origin, COUNT(*) FROM Flight GROUP BY origin;

/*
Prediction Result:
('Austin', 2)
('Boston', 4)
('Denver', 7)
*/