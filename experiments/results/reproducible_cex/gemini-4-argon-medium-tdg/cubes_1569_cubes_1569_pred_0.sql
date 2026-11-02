-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (1, 'M', 'Zack', '1980-01-01', 180.0, 75.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (2, 'F', 'Alice', '1990-02-02', 165.0, 60.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (3, 'M', 'Bob', '1985-03-03', 175.0, 80.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (4, 'F', 'Alice', '1992-04-04', 170.0, 65.0);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (10, 3, 'Source A', '2020-01-01', 0.5, 0.2, 0.2, 0.1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM candidate AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM people WHERE NOT people_id IN (SELECT people_id FROM candidate);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/