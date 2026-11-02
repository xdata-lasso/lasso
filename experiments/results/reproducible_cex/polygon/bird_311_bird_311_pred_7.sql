-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=15', '=27', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s24', '=27', '=25');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('s26', '=27', 's28');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=17', '=27', '=23');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=27', 's34');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('s16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(molecule_id) FROM molecule WHERE NOT molecule_id IN (SELECT molecule_id FROM atom WHERE element = 's') AND NOT molecule_id IN (SELECT molecule_id FROM bond WHERE bond_type = '=');

/*
Prediction Result:
(2,)
*/