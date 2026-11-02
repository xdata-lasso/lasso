-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('knowledge', 'grow');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('fall', 'knowledge', 'clearly');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('dinner', 'knowledge', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('best', 'knowledge', 'clearly');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('husband', 'knowledge', 'bill');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('great', 'knowledge', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blue', 'knowledge', '#');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('fall', 'dinner', 'great');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('best', 'husband', 'blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('clearly',)
*/

-- Prediction Query
SELECT DISTINCT a1.element, a2.element FROM bond AS b INNER JOIN connected AS c ON b.bond_id = c.bond_id INNER JOIN atom AS a1 ON c.atom_id = a1.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_type = '#';

/*
Prediction Result:
('clearly', 'source')
('clearly', 'bill')
*/