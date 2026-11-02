-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering on meter_600, ensuring unique maximums across all columns, and distinct values for id vs total row count (n) vs nationality count.
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (10, 'Alice', 'USA', 99.5, '900', '100', '100', '100', '100', '100', '100');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (20, 'Bob', 'USA', 50.1, '100', '900', '100', '100', '200', '100', '100');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (30, 'Charlie', 'CAN', 60.2, '200', '200', '900', '100', '900', '100', '100');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (40, 'David', 'UK', 70.3, '300', '300', '200', '900', '300', '900', '900');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Main Pool', 5000, 'Toronto', 'CAN', 2010);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Finals', '2020');
-- Notice swimmer 30 (Charlie, the winner on meter_600) has NO records in the 'record' table to kill INNER JOIN mutants.
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (10, 1, 1, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, id AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, TIME, COUNT(*) OVER () AS n FROM swimmer) ORDER BY meter_600 DESC) LIMIT 1);

/*
Gold Result:
('CAN', 30)
*/

-- Prediction Query
SELECT nationality, COUNT(*) FROM swimmer GROUP BY nationality HAVING COUNT(*) > 1;

/*
Prediction Result:
('USA', 2)
*/