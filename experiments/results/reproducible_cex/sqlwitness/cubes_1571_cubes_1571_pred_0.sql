-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, sex, name, date_of_birth, height, weight) VALUES (1, NULL, NULL, 'default1', 0.0, NULL), (0, 'default1', 'default2', 'default2', 1.0, NULL), (2, 'default1', NULL, NULL, 1.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT people_id, sex, name, date_of_birth, height, weight FROM people ORDER BY people_id;

/*
Gold Result:
(0, 'default1', 'default2', 'default2', 1.0, None)
(1, None, None, 'default1', 0.0, None)
(2, 'default1', None, None, 1.0, 0.0)
*/

-- Prediction Query
SELECT * FROM people;

/*
Prediction Result:
(0, 'default1', 'default2', 'default2', 1.0, None)
(1, None, None, 'default1', 0.0, None)
(2, 'default1', None, None, 1.0, 0.0)
*/