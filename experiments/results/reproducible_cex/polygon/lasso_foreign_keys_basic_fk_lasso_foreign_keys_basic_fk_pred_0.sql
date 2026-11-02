-- Schema DDL
CREATE TABLE PARENT (ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE CHILD (ID INTEGER PRIMARY KEY, PARENT_ID INTEGER, TITLE TEXT, FOREIGN KEY (PARENT_ID) REFERENCES PARENT (ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "PARENT" ("id", "name") VALUES (1, '13');
INSERT INTO "PARENT" ("id", "name") VALUES (8, '12');
INSERT INTO "CHILD" ("id", "parent_id", "title") VALUES (7, 8, NULL);
INSERT INTO "CHILD" ("id", "parent_id", "title") VALUES (10, 1, '11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TITLE FROM CHILD WHERE PARENT_ID = 1;

/*
Gold Result:
('11',)
*/

-- Prediction Query
SELECT NAME FROM PARENT JOIN CHILD ON PARENT.ID = CHILD.PARENT_ID WHERE PARENT.ID = 1;

/*
Prediction Result:
('13',)
*/