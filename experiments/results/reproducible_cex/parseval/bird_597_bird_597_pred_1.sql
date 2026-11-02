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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'India', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1349201381, '2020-12-19 01:52:21+00:00', 'dlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', 'India', '5u', 1861536320, 44952191, 1151980946, 1620389964, 546571701, '0t5c4ecigc');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 528680845, '2023-12-22 03:17:01+00:00', '6nium52zb', '2025-10-02 08:51:14+00:00', 'o4nrqr', 'fqyp', 's5bbp02e', -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 'yytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'India', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', '2021-08-20 16:50:24+00:00', 'dposiie5unw', 't2__726538', 'klfa9000t', 1408123494, -1964997180, 1149850321, -1833165707, 1155439218, 'um5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -443340271, '2025-10-02 08:51:14+00:00', 'o4nrqr', '2021-11-17 08:00:56+00:00', 'fqyp5s5bbp0', 't2__726538', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1438850342, '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 't2__726538', 'rljsl0b4y', -1116181514, 1255852738, -1555456236, -975213201, -705985602, 'x58pz0f8je');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1, 1, 'Teacher', '2024-04-12 00:38:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 1, 'Teacher', '2023-11-18 08:10:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 1, 'Teacher', '2021-12-11 04:26:48+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 1, 'Teacher', '2024-09-13 14:36:04+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 1, 'Teacher', '2020-12-13 17:48:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 1, 'Teacher', '2021-08-05 01:19:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 't1__dbfc59', '2025-11-19 11:50:18+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 'Teacher', '2024-06-06 15:16:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 2, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 5, 'Teacher', '2023-11-07 12:14:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 6, 't1__1cf5eb', '2023-10-09 18:36:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 7, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 8, 'Teacher', '2020-10-30 07:33:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 9, 't1__1cf5eb', '2020-06-01 02:38:05+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 10, NULL, '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.Location = 'India' AND T1.Name = 'Teacher';

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.UserId) FROM badges AS b JOIN users AS u ON b.UserId = u.Id WHERE LOWER(u.Location) = 'india' AND b.Name = 'Teacher';

/*
Prediction Result:
(1,)
*/