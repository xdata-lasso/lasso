-- Schema DDL
CREATE TABLE PARENT (ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE CHILD (ID INTEGER PRIMARY KEY, PARENT_ID INTEGER, TITLE TEXT, FOREIGN KEY (PARENT_ID) REFERENCES PARENT (ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO parent (id, name) VALUES (0, 'default1'), (1, NULL), (2, 'default1'), (3, 'default2'), (4, NULL), (5, 'default2');
INSERT INTO child (id, parent_id, title) VALUES (1, 0, 'default2'), (0, 4, NULL), (2, 2, 'default2'), (3, 1, 'default2'), (4, 5, 'default2'), (5, 3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TITLE FROM CHILD WHERE PARENT_ID = 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT NAME FROM PARENT JOIN CHILD ON PARENT.ID = CHILD.PARENT_ID WHERE PARENT.ID = 1;

/*
Prediction Result:
(None,)
*/