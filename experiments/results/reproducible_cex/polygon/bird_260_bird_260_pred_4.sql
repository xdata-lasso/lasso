-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#39', 'br23', 'p28');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('br20', 'br23', 'br');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('p40', NULL, '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('p22', 'br23', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('br20', 'br20', 'p22');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('br20', '#39', 'p40');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#21', 'br23');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('br23', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T3.atom_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#' AND T3.element IN ('p', 'br');

/*
Prediction Result:
(1,)
*/