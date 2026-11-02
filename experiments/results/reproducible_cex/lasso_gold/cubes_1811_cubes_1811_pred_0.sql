-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1016, 'Jeremy Thornton', 'option', 'act', '059 Russell Canyon
Michaelton, MH 47399', 'develop');
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1017, 'Justin Baxter', 'pressure', 'so', '26025 Pham Way
West Erik, UT 14669', 'idea');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Pitcairn Islands', 1016, 'Team Orton', 'American', 'Papua New Guinea', 'board');
INSERT INTO "elimination" ("elimination_id", "wrestler_id", "team", "eliminated_by", "elimination_move", "time") VALUES ('Tunisia', 1017, 'Team Orton', 'enjoy', 'Cyprus', 'many');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "elimination_move" FROM "elimination" WHERE ("team" = 'Team Orton') ORDER BY elimination_move, elimination.elimination_id NULLS LAST;

/*
Gold Result:
('Cyprus',)
('Papua New Guinea',)
*/

-- Prediction Query
SELECT Elimination_Move FROM Elimination WHERE Team = 'Team Orton';

/*
Prediction Result:
('Papua New Guinea',)
('Cyprus',)
*/