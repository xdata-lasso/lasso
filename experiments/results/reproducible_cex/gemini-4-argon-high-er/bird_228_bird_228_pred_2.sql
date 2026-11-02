-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR206', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('1', 'TR206', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('2', 'TR206', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('3', 'TR206', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.element = 'h' THEN T.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(T.atom_id) FROM atom AS T WHERE T.molecule_id = 'TR206';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN "element" = 'h' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("atom_id"), 4) AS percent FROM "atom" WHERE "molecule_id" = 'TR206';

/*
Prediction Result:
(33.3333,)
*/