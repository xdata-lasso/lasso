-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('pro_a95ade', 'value', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('A', 'pro_b7616b', -55602865);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('@', 'pro_b7616b', -59984348);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('H', 'pro_b7616b', -664303813);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('?', 'pro_b7616b', -1022641847);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('O', 'pro_b7616b', -1726781632);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('!', 'pro_b7616b', 247012447);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('`', 'pro_b7616b', -1980249628);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('D', 'pro_b7616b', -734455130);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_name_ FROM projects ORDER BY count_distinct_name_;

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT name) FROM projects;

/*
Prediction Result:
(2,)
*/