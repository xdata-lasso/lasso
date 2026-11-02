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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (6, 4, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', NULL, 'default2', 4, NULL, 1, 6, NULL, 'default2'), (4, NULL, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'default2', 1, 5, NULL, NULL, NULL, NULL), (0, 4, NULL, 'default1', NULL, 'default2', 'default2', 'default2', 1, 1, 0, 6, 5, 'default1'), (1, 1, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 5, 5, 1, 4, 0, 'default1'), (5, 6, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', NULL, NULL, 6, 5, 5, 4, 4, 'default2'), (2, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 6, 4, 4, NULL, 4, 'default1'), (3, 6, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 6, NULL, 4, 6, 5, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (5, 2, NULL, NULL), (6, 4, 'default1', '2023-01-01 01:00:00.000000'), (0, 4, 'default2', '2023-01-01 00:00:00.000000'), (1, 4, 'default2', NULL), (4, 5, 'default1', NULL), (2, 1, 'default2', '2023-01-01 01:00:00.000000'), (3, 6, 'default1', '2023-01-01 00:00:00.000000'), (7, 4, 'default2', '2023-01-01 00:00:00.000000'), (8, 5, 'default2', '2023-01-01 00:00:00.000000'), (9, 4, NULL, '2023-01-01 01:00:00.000000'), (10, 0, 'default1', NULL), (11, 6, 'default1', '2023-01-01 01:00:00.000000'), (12, NULL, 'default2', NULL), (13, NULL, 'default1', '2023-01-01 01:00:00.000000'), (14, 1, 'default2', NULL), (15, 2, NULL, NULL), (16, 0, 'default1', '2023-01-01 01:00:00.000000'), (17, 4, 'default2', '2023-01-01 01:00:00.000000'), (18, 5, NULL, '2023-01-01 01:00:00.000000'), (19, 2, 'default2', NULL), (20, 6, NULL, NULL), (21, 2, 'default2', '2023-01-01 01:00:00.000000'), (22, 3, 'default1', '2023-01-01 00:00:00.000000'), (23, 4, 'default1', '2023-01-01 01:00:00.000000'), (24, 4, NULL, '2023-01-01 00:00:00.000000'), (25, 5, NULL, '2023-01-01 01:00:00.000000'), (26, 2, NULL, NULL), (27, NULL, NULL, '2023-01-01 00:00:00.000000'), (28, 4, 'default1', NULL), (29, NULL, NULL, '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UserId FROM (SELECT UserId, COUNT(Name) AS num FROM badges GROUP BY UserId) AS T WHERE T.num > 5;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "badges"."userid") FROM "badges" GROUP BY "badges"."userid" HAVING COUNT("badges"."name") > 5;

/*
Prediction Result:
(1,)
*/