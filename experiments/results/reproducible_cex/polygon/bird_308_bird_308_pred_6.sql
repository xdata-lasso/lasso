-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl26', 'cl25', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl16', NULL, 'cl');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl15', 'cl14', 'cl16');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl27', NULL, 'cl16');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl16', 'cl26', 'cl27');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl26', 'cl16', 'cl27');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl14', 'cl16');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl25', 'cl16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.bond_id) FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id WHERE a.element = 'cl' OR a.element = 'cl';

/*
Prediction Result:
(1,)
*/