-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'use_ebda26', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 907682809, '2021-12-08 15:32:00+00:00', 'use_ebda26', '2025-04-09 18:22:58+00:00', 'iie5u', 'w6kl', 'a9', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -761141909, '2024-10-24 14:16:53+00:00', 'use_ebda26', '2024-02-23 22:32:48+00:00', 'zbuo4nrq', 'rofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1644911394, '2021-12-11 04:26:48+00:00', 'use_cea400', '2024-09-13 14:36:04+00:00', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 2142703426, -533293970, 176380444, '9rljsl0b4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1649269347, '2025-02-03 05:21:58+00:00', '5qi2', '2022-04-27 23:55:02+00:00', 'f9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1, 1, 'hvdlttilbnpr', '2021-08-20 16:50:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 1, 'ecigce376n', '2021-02-10 21:10:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (0, 5, 'lph2gn', '2020-07-01 12:41:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-1, 5, 'wnqcx', '2025-09-07 08:46:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 5, 'hncprjtu', '2023-07-15 22:31:56+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 5, 'z', '2024-06-08 14:05:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'fjgq8n2f3', '2025-11-06 14:42:57+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 'q', '2022-11-21 14:30:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 'gcb98oz', '2021-05-16 14:38:12+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 1, 'zbilyrkn', '2025-11-22 09:05:23+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 1, 'vck6ah0f8', '2021-03-29 13:18:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 4, 'ecigce376n', '2021-02-10 21:10:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 4, 'm52zbu', '2021-11-30 23:39:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 7, 'b', '2022-01-03 02:42:55+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483634, 3, 'luhvdltti', '2021-07-20 10:41:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 8, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T2.DisplayName ORDER BY COUNT(T1.Id) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('use_ebda26',)
*/

-- Prediction Query
SELECT "users"."displayname" FROM "users" INNER JOIN "badges" ON "users"."id" = "badges"."userid" GROUP BY "badges"."userid" ORDER BY COUNT("badges"."id") DESC, "users"."displayname" NULLS LAST LIMIT 1;

/*
Prediction Result:
('use_ebda26',)
*/