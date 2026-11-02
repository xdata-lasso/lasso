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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 0, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', '%Y', 'default1', 1, 1, NULL, NULL, NULL, 'Supporter');
INSERT INTO badges (id, userid, name, date) VALUES (1, NULL, 'default2', '2011-10-27 00:00:00.000000'), (0, 0, 'default1', '2023-01-01 00:00:00.000000'), (2, NULL, '%Y', '2023-01-01 00:00:00.000000'), (3, 0, '%Y', NULL), (4, NULL, NULL, '2023-01-01 00:00:00.000000'), (5, NULL, 'default1', NULL), (6, NULL, NULL, NULL), (7, 0, '2011', NULL), (8, NULL, 'default1', '2023-01-01 01:00:00.000000'), (9, NULL, NULL, NULL), (10, 0, '%Y', '2023-01-01 01:00:00.000000'), (11, 0, 'default2', '2011-10-27 00:00:00.000000'), (12, NULL, 'Supporter', '2011-10-27 00:00:00.000000'), (13, NULL, '2011', NULL), (14, NULL, 'default2', '2023-01-01 00:00:00.000000'), (15, NULL, 'Supporter', NULL), (16, NULL, '2011', '2023-01-01 01:00:00.000000'), (17, NULL, '2011', '2011-10-27 00:00:00.000000'), (18, 0, 'default2', NULL), (19, NULL, NULL, '2011-10-27 00:00:00.000000'), (20, NULL, '2011', '2023-01-01 01:00:00.000000'), (21, 0, '%Y', '2023-01-01 00:00:00.000000'), (22, 0, '%Y', '2011-10-27 00:00:00.000000'), (23, 0, 'default2', '2023-01-01 00:00:00.000000'), (24, NULL, '2011', '2011-10-27 00:00:00.000000'), (25, NULL, 'Supporter', NULL), (26, 0, NULL, '2023-01-01 00:00:00.000000'), (27, 0, 'default1', '2011-10-27 00:00:00.000000'), (28, 0, 'default2', '2023-01-01 00:00:00.000000'), (29, 0, '%Y', '2023-01-01 00:00:00.000000'), (30, NULL, 'default2', '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(Id) FROM badges WHERE STRFTIME('%Y', Date) = '2011' AND Name = 'Supporter';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.UserId) FROM badges AS b INNER JOIN users AS u ON b.UserId = u.Id WHERE b.Name = 'Supporter' AND STRFTIME('%Y', b.Date) = '2011';

/*
Prediction Result:
(0,)
*/