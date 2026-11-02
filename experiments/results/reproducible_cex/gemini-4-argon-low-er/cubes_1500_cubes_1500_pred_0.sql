-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO program (Program_ID, Name, Launch) VALUES (1, 'B', 1.0);
INSERT INTO program (Program_ID, Name, Launch) VALUES (2, 'A', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch, program.program_id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/