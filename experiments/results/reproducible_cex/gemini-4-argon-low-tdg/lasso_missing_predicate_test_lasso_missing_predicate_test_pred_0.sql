-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, DOC INTEGER, StatusType TEXT, County TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (id, DOC, StatusType, County) VALUES (1, 10, 'Merged', 'Orange');
INSERT INTO schools (id, DOC, StatusType, County) VALUES (2, 10, 'Merged', 'Orange');
INSERT INTO schools (id, DOC, StatusType, County) VALUES (3, 25, 'Merged', 'Orange');
INSERT INTO schools (id, DOC, StatusType, County) VALUES (4, 50, 'Active', 'Orange');
INSERT INTO schools (id, DOC, StatusType, County) VALUES (5, 100, 'Merged', 'Los Angeles');
INSERT INTO schools (id, DOC, StatusType, County) VALUES (6, 200, 'Closed', 'San Diego');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(DOC) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(45,)
*/

-- Prediction Query
SELECT SUM(DOC) FROM schools WHERE County = 'Orange';

/*
Prediction Result:
(95,)
*/