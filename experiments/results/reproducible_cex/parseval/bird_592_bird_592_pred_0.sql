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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'bad_ce8c7a', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 1, 'bad_e801d4', '2020-03-08 22:40:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 1, 'bad_e725ca', '2022-01-03 02:42:55+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 1, 'bad_ce8c7a', '2024-04-12 00:38:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 1, 'bad_e801d4', '2021-07-31 11:04:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 1, 'bad_e725ca', '2022-09-23 20:24:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 'bad_b5c428', '2022-11-06 10:19:41+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 'bad_6a4241', '2021-07-11 07:27:32+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 'bad_7e8045', '2022-08-02 13:58:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'bnp', '2022-04-12 01:47:28+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'dposiie5unw', '2024-05-04 23:07:19+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483637, 1, '506', '2021-05-18 10:50:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483636, 1, '506', '2021-06-25 00:51:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483635, 1, 'bad_25a5bb', '2020-01-18 08:28:25+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483634, 1, 'bad_f78e8c', '2025-05-02 19:47:39+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483633, 1, '0t5c4ec', '2021-02-04 01:21:18+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483632, 1, 'gce376nium52', '2025-09-21 09:36:38+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483631, 1, 'buo4nrq', '2025-01-30 02:54:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483630, 1, 'ofqyp', '2024-02-28 04:46:49+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483629, 1, '5bbp0', '2025-09-22 03:26:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483628, 1, 'eutliqa1', '2023-08-19 04:29:46+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483627, 1, 'bad_18627a', '2023-03-22 03:47:49+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UserId FROM (SELECT UserId, COUNT(Name) AS num FROM badges GROUP BY UserId) AS T WHERE T.num > 5;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT UserId, COUNT(Name) AS BadgeCount FROM badges GROUP BY UserId HAVING COUNT(Name) > 5;

/*
Prediction Result:
(1, 22)
*/