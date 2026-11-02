-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1018, 'discover', 'Lance Hoffman', 'sense', 1019.5, 1020.5);
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1026, 'offer', 'Jerry Ramirez', 'true', 1027.5, 1028.5);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (1021, 1018, 'according', 'science', 1023.5, 1023.5, 1024.5, 1025.5);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (1029, 1026, 'rate', 'song', 1022.5, 1024.5, 1025.5, 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT support_rate, consider_rate, oppose_rate FROM candidate ORDER BY support_rate, candidate.candidate_id NULLS LAST;

/*
Gold Result:
(1022.5, 1024.5, 1025.5)
(1023.5, 1023.5, 1024.5)
*/

-- Prediction Query
SELECT Support_rate, Consider_rate, Oppose_rate FROM candidate ORDER BY unsure_rate, candidate.candidate_id NULLS LAST;

/*
Prediction Result:
(1023.5, 1023.5, 1024.5)
(1022.5, 1024.5, 1025.5)
*/