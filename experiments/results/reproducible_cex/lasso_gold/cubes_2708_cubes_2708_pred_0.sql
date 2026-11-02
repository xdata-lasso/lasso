-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1001, 'Allison Hill', 'table', 'Petersonberg', 39);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1002, 'Noah Rhodes', 'true', 'Port Matthew', 38);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1003, 'Angie Henderson', 'according', 'South Colinstad', 37);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1004, 'Daniel Wagner', 'song', 'Lindsaymouth', 36);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1005, 'Cristian Santos', 'sure', 'South Christianport', 35);
INSERT INTO "driver" ("driver_id", "name", "party", "home_city", "age") VALUES (1006, 'Connie Lawrence', 'collection', 'Barbaraland', 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM driver WHERE (age <= 40)) ORDER BY home_city) LIMIT 3);

/*
Gold Result:
('Barbaraland',)
('Lindsaymouth',)
('Petersonberg',)
*/

-- Prediction Query
SELECT home_city FROM driver EXCEPT SELECT home_city FROM driver WHERE age > 40;

/*
Prediction Result:
('Barbaraland',)
('Lindsaymouth',)
('Petersonberg',)
('Port Matthew',)
('South Christianport',)
('South Colinstad',)
*/