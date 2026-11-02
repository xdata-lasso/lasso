-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'The Phantom of the Opera', 1986, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
('Andrew Lloyd Webber',)
*/

-- Prediction Query
SELECT DISTINCT Nominee FROM musical WHERE Award <> 'Tony Award';

/*
Prediction Result:
*/