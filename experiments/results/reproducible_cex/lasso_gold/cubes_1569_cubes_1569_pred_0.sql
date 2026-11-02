-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1030, 'value', 'Patricia Galloway', 'answer', 1031.5, 1032.5);
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1033, 'win', 'Juan Calderon', 'present', 1032.5, 1033.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM candidate AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Juan Calderon',)
('Patricia Galloway',)
*/

-- Prediction Query
SELECT name FROM people WHERE NOT people_id IN (SELECT people_id FROM candidate);

/*
Prediction Result:
('Patricia Galloway',)
('Juan Calderon',)
*/