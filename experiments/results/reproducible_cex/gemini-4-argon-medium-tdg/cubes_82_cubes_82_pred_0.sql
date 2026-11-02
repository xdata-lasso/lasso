-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'History Museum', 2009, '2015');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (2, 'Art Gallery', 100, '2008');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (3, 'Science Center', 50, '2009');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (4, 'Modern Museum', 300, '2020');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Alice', 1, 30);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (1, '1', 2, 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_staff) OVER () AS avg_num_of_staff_ FROM museum WHERE (num_of_staff = 2009 OR open_year < 2009) ORDER BY avg_num_of_staff_;

/*
Gold Result:
(1054.5,)
*/

-- Prediction Query
SELECT AVG(num_of_staff) FROM museum WHERE open_year < 2009;

/*
Prediction Result:
(100.0,)
*/