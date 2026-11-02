-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('energy', 'enjoy');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('dark', 'two');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('not', 'wind');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('list', 'bag');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('challenge', 'level');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('knowledge', 'system');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cover', 'total');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('maintain', 'oil');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('time', 'community');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('economic', 'hundred');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('compare', 'able');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('medical', 'in');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('different', 'evidence');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('treatment', 'step');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('institution', 'look');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('weight', 'feeling');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('apply', 'energy', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('reach', 'dark', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('now', 'not', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('think', 'list', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('administration', 'challenge', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('better', 'knowledge', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('with', 'cover', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('some', 'maintain', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('same', NULL, '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('side', 'economic', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('only', 'compare', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('recently', 'medical', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('serious', 'different', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('message', 'treatment', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('clear', 'institution', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('fine', 'weight', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
(None,)
('challenge',)
('compare',)
('cover',)
('dark',)
*/

-- Prediction Query
SELECT "molecule"."molecule_id" FROM "bond" INNER JOIN "molecule" ON "bond"."molecule_id" = "molecule"."molecule_id" WHERE "bond"."bond_type" = '=' GROUP BY "molecule"."molecule_id" ORDER BY "molecule"."molecule_id" ASC LIMIT 5;

/*
Prediction Result:
('challenge',)
('compare',)
('cover',)
('dark',)
('different',)
*/