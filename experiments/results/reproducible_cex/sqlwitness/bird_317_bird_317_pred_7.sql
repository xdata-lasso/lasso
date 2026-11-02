-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('cl', 'default1'), ('+', 'cl'), ('default2', 'default1'), ('default1', NULL), ('unique_4', 'cl'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', NULL, 'default1'), ('default2', '+', '+'), ('default1', '+', 'default1'), ('cl', 'unique_6', '+'), ('unique_4', 'unique_6', 'default2'), ('unique_5', 'unique_5', '+'), ('unique_6', 'unique_6', 'default2'), ('unique_7', 'unique_7', 'cl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T2.label = '+' AND T1.element = 'cl' THEN T2.molecule_id ELSE NULL END) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
(14,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN "molecule"."label" = '+' AND "atom"."element" = 'cl' THEN 1 ELSE 0 END) * 100.0 / COUNT("molecule"."molecule_id") AS percentage FROM "atom" INNER JOIN "molecule" ON "atom"."molecule_id" = "molecule"."molecule_id";

/*
Prediction Result:
(14.285714285714286,)
*/