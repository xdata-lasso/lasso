-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s26', '=29', 's');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=21', 's30', 's');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('s28', 's30', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=27', '=29', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=21', 's26', 's28');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('s26', '=21', '=27');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=29', 's30');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('s30', 's30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('=29',)
('s30',)
*/

-- Prediction Query
SELECT T1.label FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T2.atom_id = T3.atom_id INNER JOIN bond AS T4 ON T3.bond_id = T4.bond_id WHERE T2.element = 's' AND T4.bond_type = '=';

/*
Prediction Result:
('s30',)
('s30',)
*/