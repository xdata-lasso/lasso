-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate Names (kills SELECT DISTINCT mutants) and tie-breaking by ID in ORDER BY (when ID order opposes insertion order).
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (10, 'Alice', 5, 22);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (5, 'Alice', 6, 28);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (20, 'Bob', 7, 30);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Bob', 5, 45);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
('Bob',)
('Alice',)
*/