-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (1, 'M', 'Alice', '1980-01-01', 190.0, 70.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (2, 'F', 'Bob', '1981-01-01', 200.0, 80.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (3, 'M', 'Charlie', '1982-01-01', 200.1, 85.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (4, 'F', 'David', '1983-01-01', 189.9, 65.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (5, 'M', 'Eve', '1984-01-01', 195.0, 75.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (6, 'F', 'Frank', '1985-01-01', 190.1, 72.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (7, 'M', 'Grace', '1986-01-01', 199.9, 78.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (height > 200.0 OR height <= 190.0) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
('David',)
*/

-- Prediction Query
SELECT name FROM people WHERE height > 200 OR height < 190;

/*
Prediction Result:
('Charlie',)
('David',)
*/