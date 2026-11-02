-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'cl'), ('cl', 'default2'), ('default1', 'default2'), ('+', 'default1'), ('unique_4', 'cl'), ('unique_5', '+'), ('unique_6', '+'), ('unique_7', '+'), ('unique_8', 'cl'), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', 'cl'), ('unique_12', 'default2'), ('unique_13', 'cl'), ('unique_14', 'default2'), ('unique_15', NULL), ('unique_16', 'cl'), ('unique_17', '+'), ('unique_18', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'unique_12', NULL), ('default2', 'unique_12', 'default2'), ('default1', 'cl', '+'), ('cl', 'unique_5', '+'), ('unique_4', 'unique_12', 'default1'), ('unique_5', 'unique_14', NULL), ('unique_6', 'unique_6', 'cl'), ('unique_7', 'unique_18', 'default2'), ('unique_8', 'unique_5', '+'), ('unique_9', 'unique_9', 'cl'), ('unique_10', 'unique_6', 'cl'), ('unique_11', 'unique_7', NULL), ('unique_12', 'unique_4', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "atom"."element" = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("atom"."atom_id") AS percentage FROM "atom" INNER JOIN "molecule" ON "atom"."molecule_id" = "molecule"."molecule_id" WHERE "molecule"."label" = '+';

/*
Prediction Result:
(40.0,)
*/