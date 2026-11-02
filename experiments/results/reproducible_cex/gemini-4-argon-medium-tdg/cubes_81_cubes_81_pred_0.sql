-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (10, 'Zack', 10, 22);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (20, 'Aaron', 5, 35);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (30, 'Aaron', 6, 35);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (40, 'Bob', 4, 55);
INSERT INTO "visitor" ("ID", "Name", "Level_of_membership", "Age") VALUES (50, 'Bob', 0, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
('Aaron',)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Aaron',)
('Aaron',)
*/