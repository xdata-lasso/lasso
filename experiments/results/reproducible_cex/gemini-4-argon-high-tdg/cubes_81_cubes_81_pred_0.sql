-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Charlie', 6, 3);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (2, 'Alice', 7, 20);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (3, 'Bob', 5, 40);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (10, 'David', 4, 25);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (11, 'Eve', 3, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Charlie',)
('Bob',)
*/