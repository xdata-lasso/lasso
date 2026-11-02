-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ca20', 'ca21', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ca22', 'ca23', 'ca');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('ca15', 'ca21', 'ca21');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('ca14', 'ca21', 'ca21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('ca20', 'ca22', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ca21', 'ca-777');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ca23', 'ca-776');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('ca-776',)
*/

-- Prediction Query
SELECT MAX(T1.label) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'ca';

/*
Prediction Result:
('ca-777',)
*/