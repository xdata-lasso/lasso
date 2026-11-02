-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ca', 'win');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('machine', 'win');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('not', 'win');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('capital', 'win');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('human', 'ca', 'show');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('bar', 'ca', 'show');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('old', 'ca', 'show');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('finally', 'ca', 'show');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(label) FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca');

/*
Prediction Result:
(None,)
*/