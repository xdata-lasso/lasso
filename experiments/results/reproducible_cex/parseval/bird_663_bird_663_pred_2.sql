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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1, 'c4ecigce');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', 'tliqa1', 2074205376, 274769912, -188151580, 226938182, 1, '72k');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1390245819, '2023-03-10 01:47:11+00:00', '4ji7zwa', '2022-08-31 15:38:50+00:00', '2dwyrq13pyu7', 'd99rljsl0', '4', 1649269347, -1116181514, 1255852738, -1555456236, 1, 'kf9vq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 537874887, '2025-12-09 03:18:27+00:00', 'z0f8jegd21', '2022-11-21 09:24:31+00:00', '9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 1, '5hncprjtu0d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 401805964, '2021-04-23 15:57:00+00:00', 'q8', '2021-10-07 12:15:00+00:00', 'f3dqv0gc', '9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 1, 'h0f8jswwlq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -566887085, '2025-02-02 06:02:30+00:00', '2fxa7ryfd', '2022-05-09 09:35:03+00:00', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', -1696173285, 710458518, 678047687, -1478134144, 1, 'y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -598313376, '2023-08-04 05:42:30+00:00', '4301j', '2021-01-17 17:19:55+00:00', 'den8c68x', 'vacx7afu5', '1of77p', -435350511, 1992637800, -820614248, 481546706, 1, 'g6');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -242584410, '2023-07-14 21:32:37+00:00', '5q8qdj', '2021-12-29 21:32:16+00:00', '1i', '2278', '07cvtjpt', 453836040, 1467355421, -1171104889, -29242208, 1, '36c');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1722106924, '2020-02-23 23:54:56+00:00', 'kf', '2025-08-13 14:13:20+00:00', 'acd0', '7z2zezjo7wg', 'd5ysxc', -405743609, -1935752926, -20116244, -176606723, 1, '5lnpi');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, -1300180872, '2021-06-04 00:33:11+00:00', '8qs27p2r', '2024-09-21 04:14:02+00:00', '4gth2mnajjla', 'okv8uttm', '2ne578', 1908593332, 697257217, -451030047, -2052653308, 1, 'yvkv42q7s');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1735561423, '2025-10-01 11:12:58+00:00', '8b4pmaus', '2023-11-09 04:27:38+00:00', 'u', 'mkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 1731843275, -582376271, 1, 'fwsz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, -210159774, '2024-10-15 01:24:38+00:00', 'bb0q', '2025-04-29 20:31:18+00:00', '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', 1056589776, -499913447, -360096930, -1942581013, 1, 'fuqyxuzkb');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, -30041412, '2023-09-14 18:35:43+00:00', 'wn', '2021-07-02 13:56:51+00:00', 's', 'elboeowii', 'z5nxih6', -251205568, 287256667, 1614799674, 1083479253, 1, '9oaawg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1044710644, '2022-03-05 18:43:06+00:00', '0', '2022-07-26 21:24:54+00:00', 'i', 'ndz39tajz9', 'd8n5w', -1988582944, -794767771, 989306270, 1147652228, 1, 'u');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, -1943814113, '2023-01-15 14:52:54+00:00', '603vzxw1r', '2023-03-02 21:11:27+00:00', '9y', 'k7', 'k162n', -516345261, -1191116453, 1709667347, -1934709172, 1, '3');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1595632888, '2025-09-12 02:45:33+00:00', 'kio1', '2024-07-20 09:13:00+00:00', 'i2hy0', '8ftp6ewtqx', 'njabym', 1528227252, -1277305894, -1659775598, -891525031, 1, '1cj8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (18, 1728926031, '2024-02-16 17:13:12+00:00', 'nzy', '2022-06-21 06:39:29+00:00', 'dyyd1jmgj', 'c', '8q', 280292620, 620355627, -531872415, -2125172723, 1, 'v4ygmayq3');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (19, 1432875972, '2024-12-02 03:34:47+00:00', 'dpuap96rntdq', '2022-05-15 00:01:26+00:00', 'm5', 'wlic7dn2np', '90xdmsqt', -1685482179, -1391541536, -1025517017, 1374676344, 1, 'f2ccukjq1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (20, 1584429327, '2021-02-17 14:55:24+00:00', '1yh', '2020-03-09 19:37:06+00:00', '8hlst1p', 'qomiztvb6m', 'iz78aqql', -753065777, 190510318, -835782528, 192271618, 1, '9114qbre6bj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (21, -752650834, '2022-06-25 04:45:04+00:00', '8kj', '2020-12-20 11:52:57+00:00', '5wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', -622923312, 1789767331, 1633584225, 1671062261, 1, 'h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM users WHERE Age = (SELECT MIN(Age) FROM users);

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
SELECT Id FROM users WHERE Age = (SELECT MIN(Age) FROM users) LIMIT 1;

/*
Prediction Result:
(2,)
*/