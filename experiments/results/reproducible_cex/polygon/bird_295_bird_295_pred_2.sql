-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('h22', 'H23', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('H14', NULL, 'H23');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('H17', '+15', 'H23');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('h16', NULL, 'H23');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('h22', 'h22', 'h16');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('h22', 'H14', 'h16');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H23', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+15', 'H23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) AS atomnums_h FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'h';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T2.atom_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'H' AND T1.label = '+';

/*
Prediction Result:
(0,)
*/