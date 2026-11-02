-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('collection', 'fall');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('save', 'clearly');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('knowledge', 'dinner');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('grow', 'source');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('available', 'spring');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('answer', 'figure');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('recently', 'base');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('drive', 'top');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('they', 'hear');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('his', 'determine');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('commercial', 'religious');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('hospital', 'example');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('great', 'collection', 'bill');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blue', 'collection', 'bill');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('best', 'collection', 'bill');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('husband', 'collection', 'bill');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('early', 'available', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('trial', 'available', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blood', 'available', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('long', 'available', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('science', 'they', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('write', 'they', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('result', 'they', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('raise', 'they', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT bond_type, COUNT(bond_id) FROM bond GROUP BY bond_type ORDER BY COUNT(bond_id) DESC, bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT bond_type FROM bond GROUP BY bond_type ORDER BY COUNT(bond_type) DESC, bond_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('bill',)
*/