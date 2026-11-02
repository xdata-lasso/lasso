-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('i16', 'i31', 'i32');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('i32', 'i31', 'i');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('i15', NULL, 'i32');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('i17', 'i14', 'i32');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('i32', 'i32', 'i17');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('i32', 'i16', 'i17');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('i31', 'i32');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('i14', 'i32');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(c.bond_id) AS REAL) / COUNT(DISTINCT a.atom_id) AS average_bonds FROM atom AS a INNER JOIN connected AS c ON a.atom_id = c.atom_id WHERE a.element = 'i';

/*
Prediction Result:
(2.0,)
*/