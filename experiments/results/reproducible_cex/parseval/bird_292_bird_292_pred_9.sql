-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_0701f5', 'g_050 ', 'c');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('g_050 ', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G?050U', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('gG01 o', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('''(051?', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('o?0501', 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
*/

-- Prediction Query
SELECT "atom_id" FROM "atom" WHERE "element" = 'c' AND SUBSTRING("molecule_id", 3, 3) >= '010' AND SUBSTRING("molecule_id", 3, 3) <= '050';

/*
Prediction Result:
('ato_0701f5',)
*/