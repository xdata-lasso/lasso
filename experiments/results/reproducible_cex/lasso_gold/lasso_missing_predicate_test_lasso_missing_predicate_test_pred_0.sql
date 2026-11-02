-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, DOC INTEGER, StatusType TEXT, County TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (1018, 1019, 'Merged_z', 'Orange');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(DOC) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(DOC) FROM schools WHERE County = 'Orange';

/*
Prediction Result:
(1019,)
*/