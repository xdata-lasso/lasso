-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior when the target table 'election' is empty (0 rows vs 1 row returned by standard COUNT(*)).
-- Also populates 'representative' to catch mutants querying the wrong table or performing an OUTER JOIN.
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'John Doe', 'NY', 'Dem', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Jane Smith', 'CA', 'Rep', '1960-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM election ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM election;

/*
Prediction Result:
(0,)
*/