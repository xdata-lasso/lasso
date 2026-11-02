-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "item" ("i_id", "title") VALUES (1, 'Item1');
INSERT INTO "useracct" ("u_id", "name") VALUES (1, 'Alice');
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (2, 1, 1, 5, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT a_id, u_id, a_id AS i_id, rating, rank, name, a_id_other, rating_other, rank_other FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, LHS.name AS name, RHS.a_id AS a_id_other, RHS.rating AS rating_other, RHS.rank AS rank_other FROM (SELECT a_id, a_id AS u_id, i_id, rating, rank, name FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, RHS.name AS name FROM review AS LHS INNER JOIN useracct AS RHS ON (LHS.a_id = RHS.u_id))) AS LHS INNER JOIN review AS RHS ON (LHS.a_id = RHS.i_id AND LHS.rank = RHS.u_id))) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.name FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id ORDER BY T2.rating DESC, T1.u_id NULLS LAST, T2.a_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/