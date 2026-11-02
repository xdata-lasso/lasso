-- Schema DDL
/* Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE udaxih (utlsgw INTEGER PRIMARY KEY, cbvhyj TEXT(100) NOT NULL UNIQUE, chdmio TEXT(100) NOT NULL);

CREATE TABLE hexdvx (ulfllg INTEGER PRIMARY KEY, viwvuc TEXT(100) NOT NULL, utlsgw INTEGER NOT NULL, tufrxh TEXT(50) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE rcsnba (rhvkyy INTEGER PRIMARY KEY, bhbzkm TEXT(100) NOT NULL UNIQUE, utlsgw INTEGER NOT NULL, icgswk REAL NOT NULL, gupmuo TEXT(20) NOT NULL, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE cghqta (eiehxr INTEGER PRIMARY KEY, ulfllg INTEGER NOT NULL, rhvkyy INTEGER NOT NULL, rixsns TEXT(20) NOT NULL, mlheqp REAL NOT NULL, UNIQUE (ulfllg, rhvkyy), FOREIGN KEY (ulfllg) REFERENCES hexdvx (ulfllg), FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy));

CREATE TABLE rgwuwr (cybdeu INTEGER PRIMARY KEY, rhvkyy INTEGER NOT NULL, fzvntc INTEGER, tufrxh TEXT(200) NOT NULL, mmtoqi TEXT(20) NOT NULL, gupmuo TEXT(20) NOT NULL, ravxdv TEXT(20) NOT NULL, FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy), FOREIGN KEY (fzvntc) REFERENCES hexdvx (ulfllg));

CREATE TABLE nhosiz (ryiyuk INTEGER PRIMARY KEY, djnfoa TEXT(100) NOT NULL, xxiqyf TEXT(20) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1);

CREATE TABLE ayzfwn (qdujuq INTEGER PRIMARY KEY, ryiyuk INTEGER NOT NULL, tgelyf TEXT(20) NOT NULL, ryqatk TEXT(20) NOT NULL, padlzj TEXT(20) NOT NULL DEFAULT 'STANDARD', hbhscc REAL NOT NULL DEFAULT 0, FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

CREATE TABLE kiegyk (xpcyry INTEGER PRIMARY KEY, eevprf TEXT(100) NOT NULL UNIQUE, iqtngr TEXT(50) NOT NULL);

CREATE TABLE dcmdll (yxwgwj INTEGER PRIMARY KEY, xpcyry INTEGER NOT NULL, mvuloq TEXT(100) NOT NULL, odhhck REAL NOT NULL, asrhsh INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (xpcyry) REFERENCES kiegyk (xpcyry));

CREATE TABLE tizbxo (acwubh INTEGER PRIMARY KEY, qdujuq INTEGER NOT NULL, yxwgwj INTEGER NOT NULL, cbkcqh INTEGER NOT NULL, ivpgre REAL NOT NULL, xssphz REAL, UNIQUE (qdujuq, yxwgwj), FOREIGN KEY (qdujuq) REFERENCES ayzfwn (qdujuq), FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj));

CREATE TABLE rdmcrj (pzngdd INTEGER PRIMARY KEY, yxwgwj INTEGER NOT NULL, ryiyuk INTEGER NOT NULL, vnlnno INTEGER NOT NULL, xbvuud INTEGER NOT NULL DEFAULT 0, bmxkzd TEXT(20) NOT NULL, FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj), FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (1, 'Alice', 'TIER1', 1);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (2, 'Bob', 'TIER2', 1);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (3, 'Charlie', 'TIER1', 1);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (4, 'Diana', 'TIER3', 0);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (5, 'Evan', 'TIER2', 2);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (101, 1, '2023-01-10', 'COMPLETED', 'STANDARD', 100.50);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (102, 1, '2023-01-15', 'COMPLETED', 'EXPRESS', 200.25);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (103, 1, '2023-01-20', 'PENDING', 'STANDARD', 50.00);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (104, 3, '2023-02-01', 'PENDING', 'STANDARD', 75.00);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (105, 3, '2023-02-05', 'CANCELLED', 'EXPRESS', 125.00);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (106, 4, '2023-03-01', 'COMPLETED', 'STANDARD', 300.00);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (107, 5, '2023-03-10', 'COMPLETED', 'STANDARD', 400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Gold Result:
(1, 'Alice', 2, 300.75)
(2, 'Bob', 0, 0.0)
(3, 'Charlie', 0, 0.0)
*/

-- Prediction Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk WHERE o.ryqatk = 'COMPLETED' AND c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Prediction Result:
(1, 'Alice', 2, 300.75)
*/