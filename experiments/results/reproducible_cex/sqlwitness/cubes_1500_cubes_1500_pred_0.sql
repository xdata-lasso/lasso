-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO program (program_id, name, origin, launch, owner) VALUES (0, 'default2', 'default2', NULL, NULL), (1, 'default1', 'default1', 0.0, 'default1'), (2, NULL, NULL, 0.0, 'default2'), (3, NULL, 'default1', 1.0, 'default2'), (4, NULL, NULL, 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch, program.program_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default1',)
(None,)
(None,)
(None,)
*/