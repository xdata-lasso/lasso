-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+21', 'n22', 'n');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+27', 'n22', 'n');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('n16', 'n14', 'n22');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+15', NULL, 'n22');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+21', '+21', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+21', '+27', '+15');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('n14', 'n22');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('n22', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'n' AND T1.label = '+';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'n' AND T2.label = '+';

/*
Prediction Result:
(2,)
*/