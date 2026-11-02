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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'Rochester, NY', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1364429300, '2025-02-07 06:53:31+00:00', 'prmd', '2021-12-31 07:20:26+00:00', 'siie', 'Rochester, NY', 'unw6klfa', 1419861592, 700088193, 374105386, 1274489983, -1683203397, 'e376nium52');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 743312762, '2024-11-25 22:27:17+00:00', 'ut', '2021-08-01 11:21:15+00:00', 'qa1', 'Rochester, NY', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 364869063, '2022-05-13 17:57:39+00:00', '13pyu', '2024-06-05 19:22:34+00:00', 'd99rljsl0', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'Rochester, NY', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1377057208, '2022-08-02 13:58:36+00:00', 'lbn', '2022-01-18 15:57:55+00:00', 'mdpos', 'Rochester, NY', 'ie5', -1209887326, -1399556171, 1038707349, 1419861592, 700088193, 'ecigce376n');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'luhvdltti', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'zbuo4nrqrof', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'qyp5s5bbp0', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, '1vy9uxj4', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 4, 'wb', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 4, 'v', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 'ph2', '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 2, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1, 2, 'value', NULL);

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 5, 'uhv', '2020-06-20 11:35:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 6, 'value', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Date FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.Location = 'Rochester, NY';

/*
Gold Result:
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2020-06-20 11:35:06+00:00',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "badges"."date" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "users"."location" = 'Rochester, NY';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00',)
('2020-06-20 11:35:06+00:00',)
(None,)
*/