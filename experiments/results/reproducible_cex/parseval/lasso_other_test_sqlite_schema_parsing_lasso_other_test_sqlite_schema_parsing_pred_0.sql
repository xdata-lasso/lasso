-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: schools --
INSERT INTO "schools" ("cdscode", "county") VALUES ('cdscode_1', '5k5swwqcgs');

INSERT INTO "schools" ("cdscode", "county") VALUES ('cdscode_2', '9n8c4pgu7v');

INSERT INTO "schools" ("cdscode", "county") VALUES ('cdscode_3', '4h');

INSERT INTO "schools" ("cdscode", "county") VALUES ('cdscode_4', 'a2y');

INSERT INTO "schools" ("cdscode", "county") VALUES ('cdscode_5', 'uzhsrwbbp6lu');

-- Inserting into table: frpm --
INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('cdscode_1', 'frp_89bdaa', 1234);

INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('cdscode_2', 'frp_89bdaa', 1234);

INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('cdscode_3', 'frp_89bdaa', 1234);

INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('cdscode_4', 'frp_89bdaa', 1);

INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('cdscode_5', 'frp_89bdaa', 1234);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Academic Year" FROM frpm WHERE "District Code" = 1234;

/*
Gold Result:
('frp_89bdaa',)
('frp_89bdaa',)
('frp_89bdaa',)
('frp_89bdaa',)
*/

-- Prediction Query
SELECT "Academic Year" FROM frpm;

/*
Prediction Result:
('frp_89bdaa',)
('frp_89bdaa',)
('frp_89bdaa',)
('frp_89bdaa',)
('frp_89bdaa',)
*/