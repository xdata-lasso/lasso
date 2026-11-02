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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, NULL, NULL, '2014', '2014-10-27 00:00:00.000000', 'Commentator', 'default1', 'default2', 0, 1, NULL, 1, NULL, '%Y'), (1, NULL, NULL, '2014', NULL, '2014', 'default1', 'Commentator', 1, NULL, 0, 0, 0, '2014'), (2, 0, NULL, '%Y', '2014-10-27 00:00:00.000000', 'default2', '%Y', 'default1', 0, 0, 1, 1, NULL, 'Commentator'), (3, 0, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1', NULL, NULL, 0, 0, NULL, NULL), (4, 1, '2014-10-27 00:00:00.000000', NULL, '2014-10-27 00:00:00.000000', 'Commentator', 'Commentator', 'default2', 1, NULL, 0, NULL, 0, '%Y'), (5, 1, '2023-01-01 00:00:00.000000', 'Commentator', '2023-01-01 00:00:00.000000', NULL, 'Commentator', 'Commentator', 1, 1, 0, 0, 0, 'default2'), (6, 0, '2023-01-01 01:00:00.000000', 'Commentator', '2014-10-27 00:00:00.000000', 'default2', 'Commentator', NULL, 0, NULL, 1, NULL, 0, '2014'), (7, 1, '2023-01-01 01:00:00.000000', NULL, '2014-10-27 00:00:00.000000', NULL, 'Commentator', 'Commentator', NULL, 0, NULL, 1, 0, 'Commentator');
INSERT INTO badges (id, userid, name, date) VALUES (1, 4, '2014', '2023-01-01 00:00:00.000000'), (0, NULL, 'Commentator', '2014-10-27 00:00:00.000000'), (2, 7, 'Commentator', '2014-10-27 00:00:00.000000'), (3, 6, 'default1', '2023-01-01 01:00:00.000000'), (4, 4, '2014', '2014-10-27 00:00:00.000000'), (5, 6, '%Y', '2023-01-01 00:00:00.000000'), (6, 4, 'default2', '2023-01-01 00:00:00.000000'), (7, 4, '%Y', '2023-01-01 01:00:00.000000'), (8, 4, 'Commentator', NULL), (9, 2, NULL, '2014-10-27 00:00:00.000000'), (10, 3, 'Commentator', '2014-10-27 00:00:00.000000'), (11, 2, '%Y', NULL), (12, 3, 'default1', '2023-01-01 01:00:00.000000'), (13, 5, 'default2', NULL), (14, 0, 'Commentator', NULL), (15, 4, 'default2', '2023-01-01 00:00:00.000000'), (16, 4, 'Commentator', NULL), (17, 3, NULL, '2023-01-01 00:00:00.000000'), (18, 2, 'Commentator', '2014-10-27 00:00:00.000000'), (19, 7, '2014', NULL), (20, NULL, 'Commentator', NULL), (21, 5, '2014', '2014-10-27 00:00:00.000000'), (22, 6, '2014', NULL), (23, 6, 'Commentator', NULL), (24, 2, 'Commentator', '2023-01-01 01:00:00.000000'), (25, 3, '2014', '2023-01-01 00:00:00.000000'), (26, 6, NULL, '2014-10-27 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(Id) FROM badges WHERE Name = 'Commentator' AND STRFTIME('%Y', Date) = '2014';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.UserId) FROM badges AS b WHERE b.Name = 'Commentator' AND STRFTIME('%Y', b.Date) = '2014';

/*
Prediction Result:
(3,)
*/