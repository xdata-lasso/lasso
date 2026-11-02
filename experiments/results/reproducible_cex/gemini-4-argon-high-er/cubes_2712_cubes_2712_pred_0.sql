-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'John', 'Dem', 'New York', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT home_city, party, COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM driver WHERE (age = 40 AND age >= 2)) GROUP BY home_city, party) ORDER BY home_city;

/*
Gold Result:
('New York',)
*/

-- Prediction Query
SELECT home_city FROM driver WHERE age > 40 GROUP BY home_city HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/