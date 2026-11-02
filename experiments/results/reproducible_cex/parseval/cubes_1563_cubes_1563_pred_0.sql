-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1, '5k5swwqcgs', 'peo_94646f', '9n8', 201.0, 874.871895);

INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (2, 'pgu7vfe4', 'peo_94646f', 'hria2ypuzhs', 201.0, 663.049759);

INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (3, 'wbbp6luhvdlt', 'peo_94646f', 'ilbnp', 201.0, 787.938887);

INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (4, 'dpos', 'ie5', 'nw6klf', 190.0, 741.842896);

INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (5, '5k5swwqcgs', '9n8', '4', 190.01, 249.706432);

INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (6, 'u7', 'fe4hri', 'a2ypuzhsrwbb', NULL, 749.826493);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (height > 200.0 OR height <= 190.0) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('ie5',)
('peo_94646f',)
('peo_94646f',)
('peo_94646f',)
*/

-- Prediction Query
SELECT name FROM people WHERE height > 200 OR height < 190;

/*
Prediction Result:
('peo_94646f',)
('peo_94646f',)
('peo_94646f',)
*/