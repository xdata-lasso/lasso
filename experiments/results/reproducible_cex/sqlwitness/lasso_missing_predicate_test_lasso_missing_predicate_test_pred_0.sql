-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, DOC INTEGER, StatusType TEXT, County TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (id, doc, statustype, county) VALUES (0, 1, 'Merged', 'default1'), (1, 1, 'default2', 'Merged'), (2, 1, 'default2', 'default2'), (3, 0, NULL, 'Orange');
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
(0,)
*/