-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice', 170.0, 65.0, '1990-01-01', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Bob', 170.0, 70.0, '1991-02-02', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (3, 'Charlie', 180.0, 75.0, '1992-03-03', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (4, 'David', 180.0, 80.0, '1993-04-04', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (5, 'Eve', 190.0, 85.0, '1994-05-05', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (6, 'Frank', 170.0, 60.0, '1995-06-06', 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (7, 'Grace', 185.0, 90.0, '1996-07-07', 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (8, 'Heidi', 185.0, 95.0, '1997-08-08', 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (9, 'Ivan', 185.0, 100.0, '1998-09-09', 'Boston');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (1, 1, 100.0, 120.0, 220.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (2, 1, 105.0, 125.0, 230.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (3, 6, 110.0, 130.0, 240.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, n AS count___ FROM (SELECT birth_place, height, COUNT(*) AS n FROM people GROUP BY birth_place, height) ORDER BY birth_place, count___ NULLS LAST;

/*
Gold Result:
('Boston', 1)
('Boston', 3)
('New York', 1)
('New York', 2)
('New York', 2)
*/

-- Prediction Query
SELECT Birth_Place, COUNT(*) FROM people GROUP BY Birth_Place;

/*
Prediction Result:
('Boston', 4)
('New York', 5)
*/