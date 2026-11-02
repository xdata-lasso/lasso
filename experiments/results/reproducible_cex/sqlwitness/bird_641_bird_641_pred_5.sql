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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, NULL, 'Commentator', NULL, NULL, 'Commentator', '%Y', 1, 0, 1, NULL, 0, 'default2'), (0, NULL, NULL, '%Y', '2023-01-01 01:00:00.000000', 'default2', '%Y', 'default1', 1, 0, 1, NULL, NULL, '%Y'), (2, 1, NULL, 'default1', NULL, 'default1', 'default1', 'Commentator', 1, NULL, 1, NULL, 1, 'default1'), (3, 1, '2023-01-01 00:00:00.000000', '2014', '2014-10-27 00:00:00.000000', 'default1', '2014', 'Commentator', 1, 0, 1, NULL, 0, NULL), (4, NULL, NULL, 'Commentator', NULL, 'default2', 'Commentator', '2014', NULL, NULL, NULL, 1, NULL, 'default2'), (5, 0, NULL, 'Commentator', NULL, NULL, '2014', '%Y', 1, 0, 0, 0, 1, '2014'), (6, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, '2014', 'default1', NULL, 0, 1, 1, NULL, 'default2'), (7, 0, '2023-01-01 01:00:00.000000', 'Commentator', '2023-01-01 01:00:00.000000', '2014', 'default2', 'default1', 0, NULL, 1, NULL, 0, 'default2'), (8, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, NULL, 'Commentator', '2014', 0, 0, NULL, 0, NULL, 'default2'), (9, 0, '2023-01-01 01:00:00.000000', 'default2', '2014-10-27 00:00:00.000000', 'Commentator', '%Y', 'default1', 0, 1, 0, 0, NULL, 'Commentator');
INSERT INTO badges (id, userid, name, date) VALUES (1, 1, 'default2', '2014-10-27 00:00:00.000000'), (0, 9, 'default2', '2023-01-01 00:00:00.000000'), (2, 2, '%Y', '2023-01-01 01:00:00.000000'), (3, 0, 'default1', NULL), (4, 4, '2014', '2014-10-27 00:00:00.000000'), (5, 8, 'default1', '2014-10-27 00:00:00.000000'), (6, 8, 'default2', '2023-01-01 01:00:00.000000'), (7, 0, '2014', NULL), (8, 2, 'Commentator', '2023-01-01 00:00:00.000000'), (9, 2, '%Y', '2014-10-27 00:00:00.000000'), (10, 8, 'default1', '2014-10-27 00:00:00.000000'), (11, 3, 'default1', NULL), (12, 9, '2014', '2023-01-01 00:00:00.000000'), (13, 6, '%Y', '2014-10-27 00:00:00.000000'), (14, 4, 'Commentator', NULL), (15, NULL, '%Y', '2023-01-01 01:00:00.000000'), (16, 5, 'default1', '2023-01-01 01:00:00.000000'), (17, 6, '2014', '2023-01-01 00:00:00.000000'), (18, 3, '2014', '2014-10-27 00:00:00.000000'), (19, 1, 'default2', '2014-10-27 00:00:00.000000'), (20, NULL, '%Y', '2014-10-27 00:00:00.000000'), (21, 4, NULL, '2023-01-01 00:00:00.000000'), (22, NULL, 'default1', '2023-01-01 00:00:00.000000'), (23, 2, NULL, NULL), (24, 3, 'default1', '2023-01-01 01:00:00.000000'), (25, NULL, 'Commentator', '2014-10-27 00:00:00.000000'), (26, 4, 'default2', '2023-01-01 01:00:00.000000'), (27, 4, 'Commentator', '2023-01-01 01:00:00.000000'), (28, 8, 'Commentator', NULL), (29, NULL, NULL, '2014-10-27 00:00:00.000000'), (30, 5, NULL, '2023-01-01 00:00:00.000000'), (31, 7, 'default2', '2023-01-01 00:00:00.000000'), (32, 0, 'default2', '2023-01-01 00:00:00.000000'), (33, 0, NULL, '2023-01-01 01:00:00.000000'), (34, 1, '%Y', '2023-01-01 00:00:00.000000'), (35, NULL, NULL, '2023-01-01 01:00:00.000000'), (36, 0, 'default1', '2014-10-27 00:00:00.000000'), (37, 7, '%Y', '2023-01-01 01:00:00.000000'), (38, 8, '%Y', NULL), (39, 9, '%Y', '2023-01-01 01:00:00.000000'), (40, 5, 'default1', '2014-10-27 00:00:00.000000'), (41, NULL, 'Commentator', '2023-01-01 01:00:00.000000'), (42, 9, NULL, '2014-10-27 00:00:00.000000'), (43, 9, 'default2', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(Id) FROM badges WHERE Name = 'Commentator' AND STRFTIME('%Y', Date) = '2014';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(badges.userid) AS numberofusers FROM badges WHERE badges.name = 'Commentator' AND STRFTIME('%Y', badges.date) = '2014';

/*
Prediction Result:
(0,)
*/