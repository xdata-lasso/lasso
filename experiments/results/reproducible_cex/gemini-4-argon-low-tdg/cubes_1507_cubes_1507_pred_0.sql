-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'BBC', 'OwnerA', 20.5, 15.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'NBC', 'OwnerB', 10.0, 12.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'ABC', 'OwnerC', 30.0, 25.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'ABC', 'OwnerD', 15.0, 10.0);
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Prog1', 'UK', 2005.0, 'OwnerA');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'Prog2', 'US', 2010.0, 'OwnerB');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 1, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 2, 'Evening');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 1, '2023-01-01', 12.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM channel ORDER BY name, channel.channel_id NULLS LAST;

/*
Gold Result:
('ABC',)
('ABC',)
('BBC',)
('NBC',)
*/

-- Prediction Query
SELECT name FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST;

/*
Prediction Result:
('ABC',)
('BBC',)
('NBC',)
('ABC',)
*/