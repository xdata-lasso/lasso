-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: musical --
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483648, '5k5swwqcgs', 247012447, 'Tony Award', '8c4pgu7vfe', 'mus_beb2e1', 'hria2ypu');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (2, 'hsrwbbp', 13244799, 'Tony Award', 'hvdltt', 'mus_beb2e1', 'lbn');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (3, 'rmdp', 2026480202, 'Tony Award', 'ie5', 'mus_beb2e1', 'nw6klf');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483645, 'a9000t5c4eci', 1149850321, 'mus_e1b181', 'e', 'mus_beb2e1', '76nium52');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483644, 'zbuo4nrqrof', 373262291, 'Tony Award', 'p5s5bbp', NULL, '02eutliqa11r');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (4, 'ytoo3o9', -1666765085, 'Cleavant Derricks', '72klex14ji7z', 'au2dwy', 'q13py');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, musical.musical_id NULLS LAST;

/*
Gold Result:
(None,)
('mus_beb2e1',)
('mus_beb2e1',)
('mus_beb2e1',)
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' OR Award = 'Cleavant Derricks';

/*
Prediction Result:
('mus_beb2e1',)
(None,)
('mus_beb2e1',)
('mus_beb2e1',)
('au2dwy',)
*/