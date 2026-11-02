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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2020-04-05 14:43:51+00:00', 'p', '2024-04-12 00:38:47+00:00', 'uhv', 'l', 'tilbn', 462974032, -1137908826, -918961358, -1602639011, -45536098, 'w6kl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1, '2020-09-15 12:11:12+00:00', 'a9000t5c4eci', '2025-03-10 20:24:26+00:00', 'ce', '76nium52', 'zbuo4nrqrof', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1, '2023-08-19 04:29:46+00:00', 'yytoo', '2023-11-18 08:10:54+00:00', '9hl7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 2142703426, -533293970, 176380444, '9rljsl0b4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2023-04-11 01:23:11+00:00', 'p5qi2rkf9v', '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 'vy9uxj4', -1612443122, -2050247126, -736979194, 2103044118, -1642259219, 'nd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2022-03-02 18:03:57+00:00', 'nqcx5h', '2021-10-14 14:41:11+00:00', 'p', 'jtu0d', '79fjgq8', -1255130038, -1762857309, 806170397, 513454646, -688216274, 'gcb98ozk3z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2020-02-20 05:24:11+00:00', 'lyr', '2021-06-12 16:42:05+00:00', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 564390026, -1259474148, 2011234363, -1483100200, -7597509, 'h5ogrgjd8yz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2022-08-16 10:09:33+00:00', '1afgogritsj', '2023-11-11 06:21:01+00:00', 'y', 'p1q430', 'jh3den8', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, '1of77p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2023-05-23 12:32:01+00:00', '72ct', '2020-06-07 10:59:23+00:00', 't', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, -241848752, 2004147439, 'tjpttg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-05-07 03:46:17+00:00', 'n', '2021-12-07 07:01:12+00:00', '5zi36c', 'bfkfoacd', '7z2zezj', 1448731351, -604098478, 1248858185, -57705450, -915385605, 'm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2022-04-20 03:52:20+00:00', '0oztdgj5i3lq', '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, -1478011227, -2096405521, 'okv8uttmu2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2021-10-09 18:25:05+00:00', '57', '2024-07-14 22:10:32+00:00', 'fvy', '7zzbe8y', 'kv42q7', -2060082151, -1122409769, 1849819405, -929383517, -2090240067, 'mkrpdj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2025-10-04 15:32:15+00:00', 'zw5chn', '2024-09-19 09:49:38+00:00', 'o705', 'a9n0jxfofws', 'do2zobb', -397848196, -366775518, 575038073, -1161141730, -613916489, '5am');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2024-10-31 01:49:19+00:00', 'orlwy', '2021-11-01 11:17:30+00:00', 'gc1dj9erhi', 'zgk1yoeyo6l0', 'dt', -795975227, 1294064538, 778835680, 1755752040, 1262491793, '5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2023-11-05 01:08:45+00:00', 'gwnlas6', '2025-03-08 07:37:26+00:00', 'lb', 'eowi', '1z5', 1557188093, 548968280, -1552469358, 7342822, -1034034171, 'lyotow');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, 1, '2024-08-29 05:28:03+00:00', 'aawg', '2024-09-22 16:04:20+00:00', 'aqb0tbind', '39tajz9', 'd8n5w', -1988582944, -794767771, 989306270, 1147652228, 1378873397, 'u6bd0w9603');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1, '2025-01-19 15:40:16+00:00', 'vzxw1rxe9yf', '2021-05-30 10:13:06+00:00', 'qk162nh55', '3dohvu0', 'dza35rmki', -1160642134, 769234989, 168442149, 1299171592, 2066302536, 'ewtqxxnja');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (18, 1, '2020-02-18 15:32:47+00:00', 'mzn2mfx', '2024-06-12 11:15:53+00:00', '33', '6sto', 'cj8sh5k', 1106724223, 1966809332, 1487347213, 1328948152, -1923069176, 'jmgjach8qt');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (19, 1, '2025-06-25 04:45:54+00:00', '8', '2023-03-14 16:48:22+00:00', 'a17v4ygm', 'y', '3qdpu', 1595033206, 1291298007, 1982265552, 2013152515, 1139012231, 'hm5wl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (20, 1, '2021-02-19 01:26:12+00:00', '7', '2025-06-14 15:18:28+00:00', 'dn2np490xdms', 'tgelc', 'qb9i9f', -788896327, -1541581575, -325680600, -796609690, -1459013972, 'yhb08hlst1pq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (21, 1, '2021-12-09 20:20:01+00:00', 'iztv', '2020-02-24 04:19:02+00:00', 'm4iz78aqq', 'ud8', 'tb', 192271618, -312228770, 1618264449, 1639204149, -2063751689, '6b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users);

/*
Gold Result:
(2,)
(3,)
(4,)
(5,)
(6,)
(7,)
(8,)
(9,)
(10,)
(11,)
(12,)
(13,)
(14,)
(15,)
(16,)
(17,)
(18,)
(19,)
(20,)
(21,)
*/

-- Prediction Query
SELECT Id FROM users ORDER BY Reputation DESC, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/