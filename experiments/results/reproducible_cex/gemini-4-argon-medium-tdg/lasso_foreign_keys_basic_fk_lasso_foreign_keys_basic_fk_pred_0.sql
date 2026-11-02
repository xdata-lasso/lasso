-- Schema DDL
CREATE TABLE PARENT (ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE CHILD (ID INTEGER PRIMARY KEY, PARENT_ID INTEGER, TITLE TEXT, FOREIGN KEY (PARENT_ID) REFERENCES PARENT (ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, operator mutations (<, <=, >, >=, <>), column confusion (CHILD.ID vs CHILD.PARENT_ID vs PARENT.NAME), and NULL handling.
INSERT INTO PARENT (ID, NAME) VALUES (0, '1');
INSERT INTO PARENT (ID, NAME) VALUES (1, 'Parent One');
INSERT INTO PARENT (ID, NAME) VALUES (2, 'Parent Two');
INSERT INTO CHILD (ID, PARENT_ID, TITLE) VALUES (1, 2, 'Wrong Parent with Child ID 1');
INSERT INTO CHILD (ID, PARENT_ID, TITLE) VALUES (2, 0, 'Parent ID Zero');
INSERT INTO CHILD (ID, PARENT_ID, TITLE) VALUES (3, 1, 'Target Child');
INSERT INTO CHILD (ID, PARENT_ID, TITLE) VALUES (4, NULL, 'Orphan Child');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TITLE FROM CHILD WHERE PARENT_ID = 1;

/*
Gold Result:
('Target Child',)
*/

-- Prediction Query
SELECT NAME FROM PARENT JOIN CHILD ON PARENT.ID = CHILD.PARENT_ID WHERE PARENT.ID = 1;

/*
Prediction Result:
('Parent One',)
*/