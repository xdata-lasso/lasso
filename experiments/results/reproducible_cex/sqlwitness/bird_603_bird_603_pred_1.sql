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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 685, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 'default1', '%Y', 1, 1, 686, 0, 1, '2011'), (0, 685, NULL, 'default2', '2023-01-01 00:00:00.000000', '2011', '2011', NULL, 687, 687, 687, 1, 685, '%Y'), (686, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', '2011', '2011', '%Y', 685, 685, 685, NULL, 687, '2011'), (685, 687, NULL, '%Y', '2023-01-01 01:00:00.000000', '2011', NULL, '2011', 687, 685, 685, NULL, 687, '%Y');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 685, 0, 687, 0, NULL, 685, NULL, '%Y', NULL, NULL, '2011', 685, NULL, NULL, '2011-10-27 00:00:00.000000', '2011-10-27 00:00:00.000000', 685, '2011-10-27 00:00:00.000000', NULL, NULL), (686, NULL, 0, 686, 0, NULL, 685, 687, '2011', '2023-01-01 01:00:00.000000', '2011', '2011', 0, NULL, 685, NULL, '2023-01-01 00:00:00.000000', NULL, '2011-10-27 00:00:00.000000', 'default2', 'default2'), (687, 685, 685, NULL, 687, '2023-01-01 01:00:00.000000', 685, 686, 'default2', '2023-01-01 00:00:00.000000', '%Y', 'default1', 687, 0, 687, '2023-01-01 01:00:00.000000', '2011-10-27 00:00:00.000000', 686, NULL, '2011', 'default1'), (685, 1, 685, 1, 687, NULL, NULL, 686, 'default2', NULL, '%Y', 'default1', 1, 686, 1, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, NULL, NULL, 'default1');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 687, 1, 685, '%Y', '2023-01-01 01:00:00.000000', 'default2', 'default1', 'default2'), (685, NULL, 1, 686, 'default1', NULL, '%Y', '2011', NULL), (687, 687, 685, NULL, '%Y', '2023-01-01 00:00:00.000000', 'default2', 'default1', NULL), (686, 685, 686, 1, '%Y', '2011-10-27 00:00:00.000000', '2011', '%Y', '2011'), (1, 687, 685, 687, NULL, '2023-01-01 01:00:00.000000', NULL, '%Y', '%Y'), (2, 686, 685, 0, '2011', NULL, '2011', 'default2', 'default2'), (3, 1, 1, 1, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(DISTINCT FavoriteCount) FROM posts WHERE Id IN (SELECT PostId FROM postHistory WHERE UserId = 686 AND STRFTIME('%Y', CreationDate) = '2011');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT SUM(posts.favoritecount) FROM posts WHERE posts.owneruserid = 686 AND STRFTIME('%Y', (SELECT creationdate FROM users WHERE id = 686)) = '2011';

/*
Prediction Result:
(None,)
*/