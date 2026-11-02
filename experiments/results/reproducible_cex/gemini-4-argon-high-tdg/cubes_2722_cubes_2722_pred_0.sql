-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Bob', 'PartyA', 'Chicago', 30);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Zack', 'PartyC', 'Austin', 50);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Alice', 'PartyB', 'Boston', 20);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'OnlyFour', 'PartyD', 'Denver', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (10, 'Zack', 'PartyC', 'Dallas', 55);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (20, 'Alice', 'PartyB', 'Seattle', 25);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (30, 'Alice', 'PartyB', 'Miami', 35);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (100, 'High', 'Central High', 'NY', 'Public');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (100, 1, 5, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (100, 4, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT LHS.name AS name, LHS.n AS n, RHS.party AS party, RHS.home_city AS home_city, RHS.age AS age FROM (SELECT name, COUNT(*) AS n FROM driver GROUP BY name) AS LHS INNER JOIN driver AS RHS ON (LHS.n = RHS.driver_id AND LHS.name = RHS.name)) ORDER BY home_city;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT home_city FROM driver GROUP BY home_city ORDER BY COUNT(*) DESC, home_city NULLS LAST LIMIT 1;

/*
Prediction Result:
('Austin',)
*/