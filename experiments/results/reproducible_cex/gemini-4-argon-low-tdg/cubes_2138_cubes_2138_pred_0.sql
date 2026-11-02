-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO item (i_id, title) VALUES (1, 'Zebra');
INSERT INTO item (i_id, title) VALUES (2, 'Apple');
INSERT INTO item (i_id, title) VALUES (3, 'Mango');
INSERT INTO item (i_id, title) VALUES (4, 'Banana');
INSERT INTO useracct (u_id, name) VALUES (1, 'User1');
INSERT INTO useracct (u_id, name) VALUES (2, 'User2');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1, 1, 1, 10, 5);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (2, 2, 1, 10, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (3, 2, 2, 10, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (4, 3, 1, 9, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (5, 4, 2, 11, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (6, NULL, 1, 10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, RHS.title AS title FROM (SELECT * FROM review WHERE (rating = 10)) AS LHS LEFT JOIN item AS RHS ON (LHS.i_id = RHS.i_id)) ORDER BY title;

/*
Gold Result:
(None,)
('Apple',)
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.title FROM item AS T1 JOIN review AS T2 ON T1.i_id = T2.i_id WHERE T2.rating = 10;

/*
Prediction Result:
('Zebra',)
('Apple',)
('Apple',)
*/