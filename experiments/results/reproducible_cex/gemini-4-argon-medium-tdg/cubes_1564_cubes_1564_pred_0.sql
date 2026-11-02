-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by support_rate, tie-breaking by candidate_id, and distinct projected columns
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (1, 'M', 'John Doe', '1980-01-01', 180.5, 75.0);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (10, 1, 'Source A', '2023-01-01', 0.45, 0.25, 0.20, 0.10);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (5, 1, 'Source B', '2023-01-02', 0.45, 0.30, 0.15, 0.10);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (1, 1, 'Source C', '2023-01-03', 0.60, 0.10, 0.25, 0.05);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (20, 1, 'Source D', '2023-01-04', 0.30, 0.40, 0.10, 0.20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT support_rate, consider_rate, oppose_rate FROM candidate ORDER BY support_rate, candidate.candidate_id NULLS LAST;

/*
Gold Result:
(0.3, 0.4, 0.1)
(0.45, 0.3, 0.15)
(0.45, 0.25, 0.2)
(0.6, 0.1, 0.25)
*/

-- Prediction Query
SELECT Support_rate, Consider_rate, Oppose_rate FROM candidate ORDER BY unsure_rate, candidate.candidate_id NULLS LAST;

/*
Prediction Result:
(0.6, 0.1, 0.25)
(0.45, 0.3, 0.15)
(0.45, 0.25, 0.2)
(0.3, 0.4, 0.1)
*/