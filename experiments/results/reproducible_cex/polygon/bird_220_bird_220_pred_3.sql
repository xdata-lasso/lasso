-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00020', 'TR000', 'TR00023');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00021', 'TR000', 'TR00023');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00015', 'TR000', 'TR000');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00014', 'TR000', 'TR000');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00021', 'TR00021', 'TR00014');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00020', 'TR00020', 'TR00014');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR00013', 'TR000');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', 'TR00022');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR000' ORDER BY T.element LIMIT 3;

/*
Gold Result:
('TR00023',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR000' ORDER BY T1.element, T1.atom_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('TR00023',)
('TR00023',)
*/