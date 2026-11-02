-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Alice', 'Dem', 'Boston', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Bob', 'Dem', 'Boston', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Charlie', 'Rep', 'Boston', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'David', 'Dem', 'Austin', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, 'Eve', 'Ind', 'Chicago', 40);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (1, 'High', 'Boston High', 'Boston', 'Public');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (1, 1, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT home_city, party, COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM driver WHERE (age = 40 AND age >= 2)) GROUP BY home_city, party) ORDER BY home_city;

/*
Gold Result:
('Austin',)
('Boston',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT home_city FROM driver WHERE age > 40 GROUP BY home_city HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/