-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+20', '+22', 'cl21');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+12', 'cl13', '+24');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl15', 'cl13', '+22');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+14', 'cl13', '+22');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+12', '+12', '+14');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+12', '+20', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+22', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl13', 'cl23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN atom.element = 'cl' THEN 1 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
(0.0,)
*/