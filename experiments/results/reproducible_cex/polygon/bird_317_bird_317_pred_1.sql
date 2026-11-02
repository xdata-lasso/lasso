-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl35', '+36', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl13', '+14', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl15', '+36', '+36');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl13', 'cl35', 'cl15');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl13', 'cl13', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+14', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+36', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T2.label = '+' AND T1.element = 'cl' THEN T2.molecule_id ELSE NULL END) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT (CAST(SUM(m.label = '+' AND a.element = 'cl') AS REAL) * 100.0 / CAST(COUNT(DISTINCT m.molecule_id) AS REAL)) AS percentage FROM molecule AS m JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+';

/*
Prediction Result:
(None,)
*/