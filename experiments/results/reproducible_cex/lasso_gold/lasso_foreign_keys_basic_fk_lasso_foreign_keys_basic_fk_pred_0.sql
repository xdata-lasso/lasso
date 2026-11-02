-- Schema DDL
CREATE TABLE PARENT (ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE CHILD (ID INTEGER PRIMARY KEY, PARENT_ID INTEGER, TITLE TEXT, FOREIGN KEY (PARENT_ID) REFERENCES PARENT (ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "parent" ("id", "name") VALUES (1, 'Allison Hill');
INSERT INTO "child" ("id", "parent_id", "title") VALUES (1001, 1, 'Environmental health practitioner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TITLE FROM CHILD WHERE PARENT_ID = 1;

/*
Gold Result:
('Environmental health practitioner',)
*/

-- Prediction Query
SELECT NAME FROM PARENT JOIN CHILD ON PARENT.ID = CHILD.PARENT_ID WHERE PARENT.ID = 1;

/*
Prediction Result:
('Allison Hill',)
*/