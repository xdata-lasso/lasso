-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of order relative to People_ID), duplicate Names, and incorrect joins/filtering with the candidate table.
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (1, 'M', 'Zack', '1980-01-01', 180.0, 75.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (2, 'F', 'Alice', '1990-02-02', 165.0, 60.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (3, 'F', 'Alice', '1992-03-03', 170.0, 65.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (4, 'M', 'Bob', '1985-04-04', 175.0, 80.0);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (101, 2, 'Source A', '2023-01-01', 0.4, 0.3, 0.2, 0.1);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (102, 2, 'Source B', '2023-02-01', 0.5, 0.2, 0.2, 0.1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM people ORDER BY date_of_birth, people.people_id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Bob',)
('Alice',)
('Alice',)
*/