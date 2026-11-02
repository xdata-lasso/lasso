-- Schema DDL
CREATE TABLE PARENT (ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE CHILD (ID INTEGER PRIMARY KEY, PARENT_ID INTEGER, TITLE TEXT, FOREIGN KEY (PARENT_ID) REFERENCES PARENT (ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: parent --
INSERT INTO "parent" ("id", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "parent" ("id", "name") VALUES (2, '9n8');

-- Inserting into table: child --
INSERT INTO "child" ("id", "parent_id", "title") VALUES (-2147483648, 1, 'chi_02b10a');

INSERT INTO "child" ("id", "parent_id", "title") VALUES (2, 1, 'chi_02b10a');

INSERT INTO "child" ("id", "parent_id", "title") VALUES (3, 1, 'chi_02b10a');

INSERT INTO "child" ("id", "parent_id", "title") VALUES (-2147483645, 2, 'chi_02b10a');

INSERT INTO "child" ("id", "parent_id", "title") VALUES (-2147483644, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TITLE FROM CHILD WHERE PARENT_ID = 1;

/*
Gold Result:
('chi_02b10a',)
(None,)
('chi_02b10a',)
('chi_02b10a',)
*/

-- Prediction Query
SELECT NAME FROM PARENT JOIN CHILD ON PARENT.ID = CHILD.PARENT_ID WHERE PARENT.ID = 1;

/*
Prediction Result:
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
*/