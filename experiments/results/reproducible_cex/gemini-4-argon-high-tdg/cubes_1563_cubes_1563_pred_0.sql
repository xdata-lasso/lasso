-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'Delta', '1990-01-01', 190.0, 80.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Alpha', '1991-02-02', 200.0, 75.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'M', 'Echo', '1992-03-03', 190.1, 82.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (4, 'F', 'Bravo', '1993-04-04', 189.9, 68.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (5, 'M', 'Charlie', '1994-05-05', 200.1, 95.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (6, 'F', 'Foxtrot', '1995-06-06', 199.9, 70.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (7, 'M', 'Golf', '1996-07-07', 195.0, 85.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (8, 'F', 'Hotel', '1997-08-08', NULL, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (height > 200.0 OR height <= 190.0) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Bravo',)
('Charlie',)
('Delta',)
*/

-- Prediction Query
SELECT name FROM people WHERE height > 200 OR height < 190;

/*
Prediction Result:
('Bravo',)
('Charlie',)
*/