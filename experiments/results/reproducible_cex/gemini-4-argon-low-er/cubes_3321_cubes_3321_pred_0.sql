-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'Alice', 180.0, 70.0, '1980-01-01', 'NY');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Bob', 170.0, 65.0, '1990-01-01', 'LA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_date FROM people ORDER BY birth_date, people.people_id NULLS LAST;

/*
Gold Result:
('1980-01-01',)
('1990-01-01',)
*/

-- Prediction Query
SELECT Birth_Date FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('1990-01-01',)
('1980-01-01',)
*/