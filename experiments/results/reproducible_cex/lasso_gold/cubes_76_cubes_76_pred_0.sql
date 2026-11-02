-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (1034, 'Derek Zuniga', 5, 1035);
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (1036, 'Patty Perez', 5, 1037);
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (1038, 'Margaret Hawkins DDS', 6, 1039);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, level_of_membership FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
('Derek Zuniga', 5)
('Margaret Hawkins DDS', 6)
('Patty Perez', 5)
*/

-- Prediction Query
SELECT name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY age DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('Margaret Hawkins DDS', 6)
('Patty Perez', 5)
('Derek Zuniga', 5)
*/