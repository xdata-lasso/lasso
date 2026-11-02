-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (3, 'Zed', 'Rep', 'Hartford', 50);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (1, 'Amy', 'Dem', 'Hartford', 60);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (2, 'Ben', 'Dem', 'Hartford', 45);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (4, 'Cal', NULL, 'Hartford', 55);
INSERT INTO driver (Driver_ID, Name, Party, Home_city, Age) VALUES (5, 'Dan', 'Ind', 'Hartford', 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "party" FROM "driver" WHERE ("home_city" = 'Hartford' AND age > 40) ORDER BY party, driver.driver_id NULLS LAST;

/*
Gold Result:
(None,)
('Dem',)
('Dem',)
('Ind',)
('Rep',)
*/

-- Prediction Query
SELECT party FROM driver WHERE home_city = 'Hartford' AND age > 40;

/*
Prediction Result:
('Dem',)
('Dem',)
('Rep',)
(None,)
('Ind',)
*/