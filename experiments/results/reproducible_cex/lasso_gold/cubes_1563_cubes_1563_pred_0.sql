-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1012, 'sure', 'Jay Ramirez', 'dinner', 201.0, 1013.5);
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1014, 'source', 'Brandon Davis', 'throw', -200, 1015.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (height > 200.0 OR height <= 190.0) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Brandon Davis',)
('Jay Ramirez',)
*/

-- Prediction Query
SELECT name FROM people WHERE height > 200 OR height < 190;

/*
Prediction Result:
('Jay Ramirez',)
('Brandon Davis',)
*/