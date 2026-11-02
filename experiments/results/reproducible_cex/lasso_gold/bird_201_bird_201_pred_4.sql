-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('early', 'mouth');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('option', 'decide');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('science', 'offer');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('play', 'early', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sense', 'option', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('kind', 'science', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('agreement', 'early', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('rate', 'option', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('discussion', 'science', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element = 'c' THEN T1.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT (CAST(SUM(a.element = 'c') AS REAL) / CAST(COUNT(a.atom_id) AS REAL)) * 100 AS carbon_percentage FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE b.bond_type = '=';

/*
Prediction Result:
(66.66666666666666,)
*/