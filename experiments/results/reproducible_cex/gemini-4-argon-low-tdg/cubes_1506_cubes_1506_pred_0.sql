-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Ch_1', 'Owner_A', 5.5, 95.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Ch_2', 'Owner_B', 12.0, 80.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Ch_3', 'Owner_A', 8.2, 85.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'Ch_4', 'Owner_C', 25.4, 60.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (5, 'Ch_5', 'Owner_B', 15.1, 75.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (6, 'Ch_6', 'Owner_D', 3.3, 99.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (7, 'Ch_7', 'Owner_E', 19.8, 70.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (8, 'Ch_8', 'Owner_F', 30.0, 50.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (9, 'Ch_9', 'Owner_G', 10.5, 82.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (10, 'Ch_10', 'Owner_H', 1.1, 100.0);
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Prog_1', 'US', 2010.0, 'Owner_A');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (8, 1, 'Morning');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (8, 1, '2023-01-01', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM channel ORDER BY share_in_percent DESC, channel.channel_id NULLS LAST) LIMIT 8);

/*
Gold Result:
('Ch_8',)
('Ch_4',)
('Ch_7',)
('Ch_5',)
('Ch_2',)
('Ch_9',)
('Ch_3',)
('Ch_1',)
*/

-- Prediction Query
SELECT name FROM channel WHERE OWNER = 'CCTV' OR OWNER = 'HBS';

/*
Prediction Result:
*/