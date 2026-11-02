-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Zeta Aquatic Center', 5000, 'Madrid', 'Spain', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Alpha Natatorium', 20000, 'Sydney', 'Australia', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Mu Pool', 10000, 'Tokyo', 'Japan', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Omega Arena', 15000, 'London', 'UK', 2012);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Unlinked Stadium', 8000, 'Paris', 'France', 1998);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (101, 1, 'World Junior', '2019');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (102, 2, 'World Junior', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (103, 3, 'World Junior', '2017');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (104, 4, 'World Senior', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (105, 4, 'world junior', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (106, 4, 'World Junior Championship', '2022');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'John Doe', 'USA', 48.5, '1:45.0', '2:45.0', '3:45.0', '4:45.0', '5:45.0', '6:45.0', '2021');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Jane Roe', 'AUS', 52.1, '1:50.0', '2:50.0', '3:50.0', '4:50.0', '5:50.0', '6:50.0', '2021');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 101, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 101, 2, 'Loss');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 104, 3, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "capacity" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."capacity" AS "capacity", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."opening_year" AS "opening_year", "RHS"."id" AS "id_other", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM "stadium" AS "LHS" INNER JOIN (SELECT * FROM "event" WHERE ("name" = 'World Junior')) AS RHS ON (LHS.id = RHS.stadium_id)) ORDER BY name, "name" NULLS LAST, "capacity" NULLS LAST;

/*
Gold Result:
('Alpha Natatorium', 20000)
('Mu Pool', 10000)
('Zeta Aquatic Center', 5000)
*/

-- Prediction Query
SELECT t1.name, t1.capacity FROM stadium AS t1 JOIN event AS t2 ON t1.id = t2.stadium_id WHERE t2.name = 'World Junior';

/*
Prediction Result:
('Zeta Aquatic Center', 5000)
('Alpha Natatorium', 20000)
('Mu Pool', 10000)
*/