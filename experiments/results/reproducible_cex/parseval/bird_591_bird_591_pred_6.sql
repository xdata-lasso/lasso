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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 374105386, '2020-05-12 00:10:04+00:00', 'gce', '2023-12-22 03:17:01+00:00', '6nium52zb', 'uo4nrqrofqy', '5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 374105386, '2020-05-12 00:10:04+00:00', 'gce', '2023-12-22 03:17:01+00:00', '6nium52zb', 'uo4nrqrofqy', '5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', '2020-12-13 17:48:30+00:00', '72k', 'ex1', 'ji7zwau2', 364869063, -953437896, -1097120355, 244829661, -1362461264, 'l0b4y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1116181514, '2022-03-22 13:45:21+00:00', '2rk', '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', -261132974, -1264842910, -1052964641, -1245682094, -1660358170, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -988981234, '2022-08-03 01:56:16+00:00', '0dz79f', '2021-04-23 15:57:00+00:00', 'q8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 4, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 4, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 4, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 'bad_1dc5c6', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 'Supporter', '1920-05-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 1, 'Supporter', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 2, 'Supporter', NULL);

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 5, 'bad_4144f4', '2000-03-01 23:59:59+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 6, 'bad_4144f4', NULL);

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 7, NULL, '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 8, NULL, '2002-03-31 23:59:59+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 9, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(Id) FROM badges WHERE STRFTIME('%Y', Date) = '2011' AND Name = 'Supporter';

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "users"."id") FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "badges"."name" = 'Supporter' AND STRFTIME('%Y', "badges"."date") = '2011';

/*
Prediction Result:
(2,)
*/