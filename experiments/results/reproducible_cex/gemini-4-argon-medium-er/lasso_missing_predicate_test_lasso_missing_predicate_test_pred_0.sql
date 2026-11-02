-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, DOC INTEGER, StatusType TEXT, County TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (id, DOC, StatusType, County) VALUES (1, 10, 'Active', 'Orange');
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
(10,)
*/