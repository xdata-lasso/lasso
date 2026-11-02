-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR144_8_1919', 'TR144_8_1920', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR144_8_1918', 'TR144_8_1921', 'TR144_8_1927');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR144_8_19', 'TR144_8_1921', 'TR144_8_1919');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR144_8_1919', 'TR144_8_1918', 'TR144_8_19');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR144_8_1919', 'TR144_8_1919', 'TR144_8_19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR144_8_1920', 'TR144_8_1919');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR144_8_1921', 'TR144_8_1919');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR144_8_19';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT a1."element" FROM "connected" AS c INNER JOIN "atom" AS a1 ON c."atom_id" = a1."atom_id" INNER JOIN "atom" AS a2 ON c."atom_id2" = a2."atom_id" WHERE c."bond_id" = 'TR144_8_19';

/*
Prediction Result:
(None,)
*/