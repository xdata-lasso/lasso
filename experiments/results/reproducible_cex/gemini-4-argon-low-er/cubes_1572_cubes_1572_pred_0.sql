-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (1, 'M', 'A', '2000-01-02', 180.0, 75.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (2, 'F', 'B', '2000-01-01', 165.0, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM people ORDER BY date_of_birth, people.people_id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/