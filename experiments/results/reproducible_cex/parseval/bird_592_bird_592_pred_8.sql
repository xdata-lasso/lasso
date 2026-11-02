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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -59984348, '2022-12-08 21:38:59+00:00', 'qcgsk9', '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 'bnp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -1602639011, '2024-02-29 12:08:41+00:00', 'nw6klf', '2020-01-18 08:28:25+00:00', '9000t5c4ec', 'gce', '76nium52', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, -2147483648, 'mdpos', '2021-02-17 05:47:13+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'bad_2fdbba', '2020-03-11 14:09:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 1, 'bad_296fe4', '2022-01-05 17:19:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 1, 'bad_55340c', '2023-07-13 23:57:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 1, 'bad_d0b826', '2025-09-22 03:26:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 1, 'bad_470bb1', '2023-10-05 06:38:23+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 1, 'bad_145238', '2024-11-25 22:27:17+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, -2147483648, 'ut', '2021-08-01 11:21:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, -2147483648, 'qa1', '2023-08-19 04:29:46+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (12, -2147483648, 'bad_9b6104', '2022-05-03 02:13:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (11, -2147483648, 'bad_e52ae7', '2023-03-22 03:47:49+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (13, 1, 'bad_e52ae7', '2022-07-23 18:54:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (14, -2147483648, 'bad_e52ae7', '2025-06-28 05:56:56+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (15, 1, NULL, '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UserId FROM (SELECT UserId, COUNT(Name) AS num FROM badges GROUP BY UserId) AS T WHERE T.num > 5;

/*
Gold Result:
(-2147483648,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "badges"."userid") FROM "badges" GROUP BY "badges"."userid" HAVING COUNT("badges"."name") > 5;

/*
Prediction Result:
(1,)
(1,)
*/