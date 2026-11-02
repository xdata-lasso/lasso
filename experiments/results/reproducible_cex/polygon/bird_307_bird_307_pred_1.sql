-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2_325', 'TR000_2_318', 'TR000_2_328');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2_326', 'TR000_2_327', 'TR000_2_328');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR000_2_3', NULL, 'TR000_2_331');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR000_2_319', 'TR000_2_327', 'TR000_2_326');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2_326', 'TR000_2_325', 'TR000_2_3');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2_326', 'TR000_2_326', 'TR000_2_3');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000_2_327', 'TR000_2_326');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000_2_318', 'TR000_2_326');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Gold Result:
('TR000_2_328',)
('TR000_2_328',)
*/

-- Prediction Query
SELECT DISTINCT a.element FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.bond_id = 'TR000_2_3';

/*
Prediction Result:
('TR000_2_328',)
*/