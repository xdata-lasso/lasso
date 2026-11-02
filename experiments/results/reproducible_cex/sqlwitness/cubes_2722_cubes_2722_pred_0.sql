-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO driver (driver_id, name, party, home_city, age) VALUES (2, 'default1', 'default2', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT LHS.name AS name, LHS.n AS n, RHS.party AS party, RHS.home_city AS home_city, RHS.age AS age FROM (SELECT name, COUNT(*) AS n FROM driver GROUP BY name) AS LHS INNER JOIN driver AS RHS ON (LHS.n = RHS.driver_id AND LHS.name = RHS.name)) ORDER BY home_city;

/*
Gold Result:
*/

-- Prediction Query
SELECT home_city FROM driver GROUP BY home_city ORDER BY COUNT(*) DESC, home_city NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/