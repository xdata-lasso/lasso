-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'Louvre', 2009, '2012');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (2, 'Met', 40, '2008');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (3, 'Prado', 40, '1999');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (4, 'Tate', 2009, '2005');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (5, 'MoMA', 100, '2009');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (6, 'Hermitage', 2008, '2010');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (7, 'Uffizi', 2010, '2015');
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (1, 'Alice', 1, 30);
INSERT INTO visitor (ID, Name, Level_of_membership, Age) VALUES (2, 'Bob', 2, 45);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (1, '1', 2, 50.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (1, '2', 1, 25.0);
INSERT INTO visit (Museum_ID, visitor_ID, Num_of_Ticket, Total_spent) VALUES (5, '1', 3, 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_staff) OVER () AS avg_num_of_staff_ FROM museum WHERE (num_of_staff = 2009 OR open_year < 2009) ORDER BY avg_num_of_staff_;

/*
Gold Result:
(1024.5,)
*/

-- Prediction Query
SELECT AVG(num_of_staff) FROM museum WHERE open_year < 2009;

/*
Prediction Result:
(696.3333333333334,)
*/