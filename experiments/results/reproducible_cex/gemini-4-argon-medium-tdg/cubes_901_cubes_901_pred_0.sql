-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3000);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Alice', 90000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (999, 1, 'Chicago', 'Paris', 4000, '2023-05-01', '2023-05-02', 800.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (500, 1, 'Boston', 'London', 3500, '2023-06-01', '2023-06-02', 600.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (501, 2, 'New York', 'London', 3400, '2023-06-03', '2023-06-04', 650.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (502, 2, 'Miami', 'London', 4400, '2023-06-05', '2023-06-06', 700.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 2, 'Seattle', 'Tokyo', 4800, '2023-01-01', '2023-01-02', 1200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (800, 1, 'Dallas', 'ZebraCity', 1000, '2023-04-01', '2023-04-01', 150.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (850, 2, 'Denver', 'AlphaCity', 900, '2023-08-01', '2023-08-01', 120.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destination FROM (SELECT * FROM (SELECT * FROM (SELECT destination, flno, COUNT(*) AS n FROM flight GROUP BY destination, flno) ORDER BY flno DESC) LIMIT 1);

/*
Gold Result:
('Paris',)
*/

-- Prediction Query
SELECT destination FROM Flight GROUP BY destination ORDER BY COUNT(*), destination NULLS LAST LIMIT 1;

/*
Prediction Result:
('AlphaCity',)
*/