-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (10, 'MoMA', 50, '1929');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (20, 'Bob', 6, 30);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (5, 'Bob', 9, 25);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (12, 'Bob', 5, 40);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Alice', 7, 20);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (2, 'Alice', 7, 22);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (3, 'Bob', 4, 18);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (10, '20', 1, 25.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (10, '5', 2, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, level_of_membership FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
('Alice', 7)
('Alice', 7)
('Bob', 9)
('Bob', 5)
('Bob', 6)
*/

-- Prediction Query
SELECT name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY age DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('Bob', 5)
('Bob', 6)
('Bob', 9)
('Alice', 7)
('Alice', 7)
*/