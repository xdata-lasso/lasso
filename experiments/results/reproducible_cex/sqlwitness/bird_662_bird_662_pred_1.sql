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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (49, 0, NULL, 'default1', NULL, '%Y', '2011', 'default1', 50, 49, 49, 49, NULL, '%Y'), (51, 1, NULL, NULL, '2011-10-27 00:00:00.000000', '2011', '2011', '2011', 49, 49, 51, 1, 0, NULL), (50, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, '%Y', 'default1', '2011', NULL, NULL, 0, 49, 49, '%Y'), (0, NULL, NULL, NULL, '2011-10-27 00:00:00.000000', 'default1', 'default2', 'default2', 1, 50, 51, 49, 1, 'default2'), (1, NULL, '2023-01-01 01:00:00.000000', '%Y', '2023-01-01 01:00:00.000000', '2011', NULL, 'default2', 49, 1, NULL, 49, 0, NULL), (2, 50, '2023-01-01 01:00:00.000000', '2011', '2023-01-01 00:00:00.000000', 'default2', '%Y', 'default1', 51, NULL, NULL, 49, 49, '2011'), (3, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, '%Y', '%Y', '2011', 49, 1, 0, 50, 51, 'default2'), (4, 1, '2011-10-27 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', '2011', '2011', 'default2', 51, NULL, 49, NULL, 0, '%Y'), (5, 51, '2023-01-01 00:00:00.000000', '%Y', '2011-10-27 00:00:00.000000', '2011', '2011', 'default2', 50, 0, 51, 50, 1, '2011');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (51, 49, 3, NULL, 0, '2011-10-27 00:00:00.000000', 49, 50, '2011', NULL, 'default1', '%Y', 50, 51, NULL, '2023-01-01 01:00:00.000000', NULL, 50, '2023-01-01 00:00:00.000000', '2011', NULL), (50, 5, 2, 0, NULL, NULL, NULL, 51, 'default2', NULL, NULL, NULL, 0, 49, 0, '2023-01-01 01:00:00.000000', '2011-10-27 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, NULL), (0, 49, 3, 51, 50, '2023-01-01 00:00:00.000000', 49, NULL, 'default1', '2011-10-27 00:00:00.000000', 'default2', '%Y', 0, 49, 1, NULL, '2011-10-27 00:00:00.000000', 50, '2023-01-01 00:00:00.000000', NULL, NULL), (49, 0, 0, 1, 51, NULL, 50, 1, '2011', '2023-01-01 00:00:00.000000', 'default1', '2011', 0, 51, 0, NULL, '2023-01-01 01:00:00.000000', 51, '2023-01-01 01:00:00.000000', '%Y', NULL), (1, 51, 51, 51, 50, NULL, 49, 51, 'default2', '2023-01-01 01:00:00.000000', '%Y', '2011', 51, NULL, 50, NULL, '2011-10-27 00:00:00.000000', 0, '2011-10-27 00:00:00.000000', 'default2', 'default1'), (2, 1, 0, 51, 51, '2023-01-01 01:00:00.000000', 0, 1, 'default2', '2011-10-27 00:00:00.000000', 'default2', 'default1', 50, NULL, 50, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 0, NULL, '%Y', 'default1'), (3, 50, 3, 1, 49, NULL, 51, NULL, 'default1', '2011-10-27 00:00:00.000000', 'default1', NULL, 1, 0, 50, '2011-10-27 00:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 00:00:00.000000', '2011', 'default1'), (4, 3, 2, NULL, 51, '2023-01-01 00:00:00.000000', NULL, 51, 'default1', NULL, 'default1', 'default1', 51, 1, 0, '2023-01-01 01:00:00.000000', '2011-10-27 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', '2011', 'default1'), (5, NULL, 50, NULL, 0, '2023-01-01 00:00:00.000000', 49, NULL, 'default1', '2023-01-01 00:00:00.000000', '2011', '2011', 51, 49, NULL, NULL, '2011-10-27 00:00:00.000000', 50, '2023-01-01 01:00:00.000000', '2011', '%Y'), (6, 3, 2, 49, 49, '2023-01-01 00:00:00.000000', 49, 0, NULL, NULL, 'default1', 'default2', NULL, 50, 0, '2023-01-01 01:00:00.000000', '2011-10-27 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'default1', '%Y'), (7, 49, 5, 1, 0, '2023-01-01 01:00:00.000000', 1, 50, '2011', NULL, 'default2', '%Y', 1, 1, 1, NULL, '2023-01-01 00:00:00.000000', 49, '2023-01-01 00:00:00.000000', NULL, 'default1'), (8, 51, 2, 51, NULL, NULL, 50, 51, '%Y', '2023-01-01 01:00:00.000000', '2011', '%Y', 1, 49, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 50, '2011-10-27 00:00:00.000000', 'default1', 'default2');
INSERT INTO votes (id, postid, userid, votetypeid, creationdate, bountyamount) VALUES (0, 2, 0, 1, '2011-10-27', 49), (51, 5, 3, 1, '2023-01-01', 1), (49, 8, 50, NULL, '2011-10-27', 50), (50, 2, 5, NULL, NULL, 51), (1, 8, 3, 51, '2023-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM posts AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.PostId WHERE T2.BountyAmount = 50 AND STRFTIME('%Y', T2.CreationDate) = '2011';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT p.Id) FROM posts AS p JOIN votes AS v ON p.Id = v.PostId WHERE STRFTIME('%Y', p.CreaionDate) = '2011' AND v.BountyAmount = 50;

/*
Prediction Result:
(0,)
*/