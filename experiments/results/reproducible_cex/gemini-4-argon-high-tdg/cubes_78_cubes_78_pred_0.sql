-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'Charlie Museum', 20, '2000');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (2, 'Alpha Museum', 10, '2010');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (3, 'Bravo Museum', 30, '1990');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (4, 'Delta Museum', 15, '1985');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (5, 'Echo Museum', 25, '2015');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Alice', 1, 25);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (2, 'Bob', 2, 30);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (3, 'Carol', 3, 40);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (4, '1', 2, 30.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (4, '2', 1, 15.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (5, '3', 4, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM museum AS LHS WHERE NOT EXISTS(SELECT 1 FROM visit AS RHS WHERE (LHS.museum_id = RHS.museum_id))) ORDER BY name;

/*
Gold Result:
('Alpha Museum',)
('Bravo Museum',)
('Charlie Museum',)
*/

-- Prediction Query
SELECT name FROM museum WHERE NOT Museum_ID IN (SELECT museum_id FROM visit);

/*
Prediction Result:
('Charlie Museum',)
('Alpha Museum',)
('Bravo Museum',)
*/