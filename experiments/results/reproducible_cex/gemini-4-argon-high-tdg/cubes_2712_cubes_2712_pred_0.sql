-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Alice', 'Dem', 'Zeta', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Bob', 'Dem', 'Zeta', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Charlie', 'Rep', 'Beta', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'David', 'Ind', 'Beta', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, 'Eve', 'Rep', 'Alpha', 40);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (6, 'Frank', 'Dem', 'Gamma', 39);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (7, 'Grace', 'Dem', 'Delta', 41);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (8, 'Heidi', 'Rep', 'Epsilon', 2);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (9, 'Ivan', 'Ind', 'Theta', 1);
INSERT INTO school (School_ID, Grade, School, Location, Type) VALUES (10, 'High', 'Central High', 'Miami', 'Public');
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 1, 40, 1);
INSERT INTO school_bus (School_ID, Driver_ID, Years_Working, If_full_time) VALUES (10, 6, 40, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT home_city, party, COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM driver WHERE (age = 40 AND age >= 2)) GROUP BY home_city, party) ORDER BY home_city;

/*
Gold Result:
('Alpha',)
('Beta',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT home_city FROM driver WHERE age > 40 GROUP BY home_city HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/