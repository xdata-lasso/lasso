-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', 'decide');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('thought', 'claim');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('purpose', 'hour');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('movement', 'sound');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('politics', 'color');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('brother', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('surface', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('woman', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('food', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('him', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('education', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('unit', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('article', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('theory', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('effect', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('notice', 'TR006', 'a');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('start', 'thought', 'place');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('win', 'purpose', 'game');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('nice', 'movement', 'middle');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('why', 'politics', 'after');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('brother', 'surface', 'notice');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('woman', 'food', 'start');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('him', 'education', 'win');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('unit', 'article', 'nice');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('theory', 'effect', 'why');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.molecule_id = 'TR006' ORDER BY T2.bond_id LIMIT 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT bond.bond_id FROM bond WHERE bond.molecule_id = 'TR006' ORDER BY bond.bond_id ASC LIMIT 2;

/*
Prediction Result:
('notice',)
*/