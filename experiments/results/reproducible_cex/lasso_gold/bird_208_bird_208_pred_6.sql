-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('all', 'offer');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('better', 'offer');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('blue', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('begin', 'all', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('performance', 'blue', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('knowledge', 'blue', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('almost', 'blue', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('discover', 'better', 'h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.label FROM (SELECT T2.label, COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'h' GROUP BY T2.label ORDER BY COUNT(T2.molecule_id) DESC, T2.label NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.label FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'h' GROUP BY T1.label ORDER BY COUNT(T1.label) DESC, T1.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('offer',)
*/