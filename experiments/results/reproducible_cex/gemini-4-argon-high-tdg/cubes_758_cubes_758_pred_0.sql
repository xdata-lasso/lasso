-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'Pippin', 1972, 'Tony Award', 'Best Direction', 'Bob Fosse', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Sweeney Todd', 1979, 'Drama Desk Award', 'Outstanding Lyrics', 'Stephen Sondheim', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'Cats', 1981, 'Olivier Award', 'Best New Musical', 'Andrew Lloyd Webber', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" <> 'Tony Award' OR "award" <> 'Drama Desk Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
('Andrew Lloyd Webber',)
('Bob Fosse',)
('Stephen Sondheim',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' INTERSECT SELECT Nominee FROM musical WHERE Award = 'Drama Desk Award';

/*
Prediction Result:
*/