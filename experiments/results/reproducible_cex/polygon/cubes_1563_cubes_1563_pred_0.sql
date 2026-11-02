-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (7, 9, '9', '9', 9, 9, 9, 9);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (6, 9, '9', '9', 9, 9, 9, 9);
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (8, NULL, NULL, NULL, 190, NULL);
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (9, '14', NULL, '15', -550, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (height > 200.0 OR height <= 190.0) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT name FROM people WHERE height > 200 OR height < 190;

/*
Prediction Result:
(None,)
*/