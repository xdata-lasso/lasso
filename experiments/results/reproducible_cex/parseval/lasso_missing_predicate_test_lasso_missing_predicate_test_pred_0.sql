-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, DOC INTEGER, StatusType TEXT, County TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: schools --
INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483648, -55602865, 'swwqcgsk', 'Orange');

INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483647, NULL, '9n8c4pgu7v', 'sch_de2f45');

INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483646, NULL, 'e4', 'sch_19aac6');

INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483645, NULL, 'hria2ypuzhs', 'Orange');

INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483644, NULL, 'rwbbp6luhvd', 'Orange');

INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483643, NULL, 'tti', 'Orange');

INSERT INTO "schools" ("id", "doc", "statustype", "county") VALUES (-2147483642, NULL, 'bnp', 'Orange');
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
(-55602865,)
*/