-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: musical --
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (2, '5k5swwqcgs', 247012447, 'Tony Award', '8c4pgu7vfe', 'mus_b35f6e', 'hria2ypu');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (3, 'hsrwbbp', 13244799, 'Tony Award', 'hvdltt', 'mus_b35f6e', 'lbn');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (4, 'rmdp', 2026480202, 'mus_a3b1d0', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (5, 'gce376nium52', -443340271, NULL, 'uo4nrqrofqy', '5s5b', 'p');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (6, '02eutliqa11r', 2137741668, 'Tony Award', 'ytoo3o9hl7', NULL, 'klex14ji');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483643, '7zwau2dwyr', -1021749117, '3pyu78d99r', 'jsl', 'A', 'b4yp5qi');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483642, 'rkf9vqx5', 1836127587, 'f8jegd2', 'vy9uxj4', 'C', 'wb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "nominee" FROM "musical" WHERE ("award" = 'Tony Award') ORDER BY nominee, "nominee" NULLS LAST;

/*
Gold Result:
(None,)
('mus_b35f6e',)
*/

-- Prediction Query
SELECT DISTINCT Nominee FROM musical WHERE Award <> 'Tony Award';

/*
Prediction Result:
('A',)
('C',)
('nw6klf',)
*/