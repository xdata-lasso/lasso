-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "useracct" ("u_id", "name") VALUES (1010, 'Daniel Wagner');
INSERT INTO "useracct" ("u_id", "name") VALUES (1013, 'Cristian Santos');
INSERT INTO "useracct" ("u_id", "name") VALUES (1011, NULL);
INSERT INTO "useracct" ("u_id", "name") VALUES (1014, NULL);
INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1010, 1011, 1012);
INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1013, 1014, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meantrust AS avg_trust_ FROM (SELECT name, AVG(trust) AS meantrust FROM (SELECT u_id, name, source_u_id, trust, u_id AS target_u_id FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.source_u_id AS source_u_id, RHS.trust AS trust FROM useracct AS LHS INNER JOIN trust AS RHS ON (LHS.u_id = RHS.target_u_id))) GROUP BY name) ORDER BY name, avg_trust_ NULLS LAST;

/*
Gold Result:
('Cristian Santos', None)
('Daniel Wagner', 1012.0)
*/

-- Prediction Query
SELECT T1.name, AVG(trust) FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id = T2.target_u_id GROUP BY T2.target_u_id;

/*
Prediction Result:
('Daniel Wagner', 1012.0)
('Cristian Santos', None)
*/