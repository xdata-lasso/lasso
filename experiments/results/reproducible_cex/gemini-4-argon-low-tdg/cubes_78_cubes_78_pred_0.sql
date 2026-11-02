-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'Zulu Museum', 15, '1995');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (2, 'Alpha Museum', 30, '2010');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (3, 'Beta Museum', 10, '1980');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (4, 'Beta Museum', 25, '2005');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (5, 'Gamma Museum', 40, '2000');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (101, 'Alice', 1, 25);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (102, 'Bob', 2, 35);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (5, '101', 2, 50.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (5, '102', 1, 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM museum AS LHS WHERE NOT EXISTS(SELECT 1 FROM visit AS RHS WHERE (LHS.museum_id = RHS.museum_id))) ORDER BY name;

/*
Gold Result:
('Alpha Museum',)
('Beta Museum',)
('Beta Museum',)
('Zulu Museum',)
*/

-- Prediction Query
SELECT name FROM museum WHERE NOT Museum_ID IN (SELECT museum_id FROM visit);

/*
Prediction Result:
('Zulu Museum',)
('Alpha Museum',)
('Beta Museum',)
('Beta Museum',)
*/