-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: musical --
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (2, '5k5swwqcgs', 247012447, 'A', '8c4pgu7vfe', 'mus_bf1f62', 'hria2ypu');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (3, 'hsrwbbp', 13244799, 'A', 'hvdltt', 'mus_bf1f62', 'lbn');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (4, 'rmdp', 2026480202, 'Drama Desk Award', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (5, '5k5swwqcgs', 247012447, 'Tony Award', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (6, '5k5swwqcgs', 247012447, NULL, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (7, 'luhvdltti', -1364429300, NULL, 'nprmdposii', '5u', 'w6kl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" <> 'Tony Award' OR "award" <> 'Drama Desk Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
('hria2ypu',)
('mus_bf1f62',)
('nw6klf',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' INTERSECT SELECT Nominee FROM musical WHERE Award = 'Drama Desk Award';

/*
Prediction Result:
*/