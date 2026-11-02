-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1, 'lhs_917785', 1.0, 1.0, 'lhs_a4b5e1');

INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (-2147483648, 'lhs_b6a1a8', 1.0, 1.0, 'lhs_13a446');

-- Inserting into table: perpetrator --
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483648, 1, '5k5swwqcgs', 171.746906, 'n8c4pgu7v', 'e4', 1160656988, -992890117);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483647, 1, 'a2ypuzhsrwbb', 749.826493, 'luhvdltti', 'bnp', 1236688122, 2087640001);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483646, 1, 'dposiie5unw', 992.733505, 'lfa', '9000t5c4ec', -1683203397, 528680845);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483645, 1, '76nium52', 816.814398, 'buo4nrq', 'rofqyp5s5b', 2107872094, 882961052);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483644, 1, '2eutliqa11r', 997.73177, 'ytoo3o9hl7', 'klex14ji', -453362185, 481163439);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483643, 1, '2dwyrq', 433.533777, 'pyu78d99', 'ljsl0', -2031361952, 1649269347);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483642, 1, 'p5qi2rkf9v', 263.638479, 'x58pz0f8jeg', 'd21vy9uxj4hw', -2050247126, -736979194);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('lhs_917785',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('lhs_917785',)
('lhs_917785',)
('lhs_917785',)
('lhs_917785',)
('lhs_917785',)
('lhs_917785',)
('lhs_917785',)
*/