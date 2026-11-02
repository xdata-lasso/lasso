-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO useracct (u_id, name) VALUES (2, 'UserTwo');
INSERT INTO useracct (u_id, name) VALUES (3, 'UserThree');
INSERT INTO item (i_id, title) VALUES (1, 'Gamma');
INSERT INTO item (i_id, title) VALUES (2, 'Beta');
INSERT INTO item (i_id, title) VALUES (3, 'Alpha');
INSERT INTO item (i_id, title) VALUES (4, 'Delta');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (2, 1, 2, 2, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (3, 4, 3, 3, 3);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (5, 4, 2, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM item AS LHS WHERE NOT EXISTS(SELECT 1 FROM review AS RHS WHERE (LHS.i_id = RHS.i_id))) ORDER BY title;

/*
Gold Result:
('Alpha',)
('Beta',)
*/

-- Prediction Query
SELECT title FROM item WHERE NOT i_id IN (SELECT i_id FROM review);

/*
Prediction Result:
('Beta',)
('Alpha',)
*/