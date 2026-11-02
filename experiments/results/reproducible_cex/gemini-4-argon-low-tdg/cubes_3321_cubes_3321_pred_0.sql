-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (1, 'John', 180.0, 80.0, '1995-05-10', 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (2, 'Jane', 165.0, 60.0, '1985-10-20', 'Chicago');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (3, 'Alice', 170.0, 65.0, '1985-10-20', 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Birth_Date", "Birth_Place") VALUES (4, 'Bob', 175.0, 75.0, NULL, 'Seattle');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (1, 1, 140.0, 170.0, 310.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (2, 1, 145.0, 175.0, 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_date FROM people ORDER BY birth_date, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
('1985-10-20',)
('1985-10-20',)
('1995-05-10',)
*/

-- Prediction Query
SELECT Birth_Date FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('1985-10-20',)
('1985-10-20',)
(None,)
('1995-05-10',)
*/