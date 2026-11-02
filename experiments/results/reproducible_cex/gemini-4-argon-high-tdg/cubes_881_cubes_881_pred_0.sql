-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (105, 'Airbus A320', 3200);
INSERT INTO aircraft (aid, name, distance) VALUES (101, 'Boeing 747', 9800);
INSERT INTO aircraft (aid, name, distance) VALUES (109, 'Cessna 172', 800);
INSERT INTO aircraft (aid, name, distance) VALUES (103, 'Boeing 737', 5400);
INSERT INTO aircraft (aid, name, distance) VALUES (108, 'Embraer 190', 2100);
INSERT INTO aircraft (aid, name, distance) VALUES (102, 'Airbus A380', 4600);
INSERT INTO aircraft (aid, name, distance) VALUES (110, 'Piper PA-28', 600);
INSERT INTO aircraft (aid, name, distance) VALUES (104, 'Boeing 737', 3900);
INSERT INTO aircraft (aid, name, distance) VALUES (107, 'Bombardier CRJ', 1500);
INSERT INTO aircraft (aid, name, distance) VALUES (106, 'Boeing 777', 2700);
INSERT INTO employee (eid, name, salary) VALUES (1, 'Alice Smith', 95000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Bob Jones', 120000.00);
INSERT INTO certificate (eid, aid) VALUES (1, 109);
INSERT INTO certificate (eid, aid) VALUES (2, 110);
INSERT INTO certificate (eid, aid) VALUES (1, 107);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 109, 'LAX', 'SFO', 9900, '2023-05-01', '2023-05-01', 150.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (20, 110, 'JFK', 'BOS', 8500, '2023-05-02', '2023-05-02', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (30, 101, 'ORD', 'DEN', 300, '2023-05-03', '2023-05-03', 400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT aid, name, AVG(distance) AS meandistance FROM aircraft GROUP BY aid, name) ORDER BY meandistance DESC) LIMIT 7);

/*
Gold Result:
('Boeing 747',)
('Boeing 737',)
('Airbus A380',)
('Boeing 737',)
('Airbus A320',)
('Boeing 777',)
('Embraer 190',)
*/

-- Prediction Query
SELECT name FROM Aircraft WHERE distance > (SELECT AVG(distance) FROM Aircraft);

/*
Prediction Result:
('Boeing 747',)
('Boeing 737',)
('Airbus A380',)
('Boeing 737',)
*/