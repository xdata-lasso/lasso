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
-- DATASET 1
INSERT INTO users (Id, DisplayName) VALUES (1, 'User1');
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (10, 107829, 1, 'PostBody_10', 'PostTitle_10', 1);
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (11, 107828, 1, 'PostBody_11', 'PostTitle_11', 1);
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (12, 107830, 1, 'PostBody_12', 'PostTitle_12', 1);
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (13, 107829, 0, 'PostBody_13', 'PostTitle_13', 1);
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (14, 107829, 2, 'PostBody_14', 'PostTitle_14', 1);
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (15, NULL, 1, 'PostBody_15', 'PostTitle_15', 1);
INSERT INTO posts (Id, ParentId, CommentCount, Body, Title, OwnerUserId) VALUES (16, 107829, NULL, 'PostBody_16', 'PostTitle_16', 1);
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (100, 10, 'TargetComment_100', 5, 1, 'UserDisplay_100');
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (101, 11, 'WrongParent_Low', 5, 1, 'UserDisplay_101');
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (102, 12, 'WrongParent_High', 5, 1, 'UserDisplay_102');
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (103, 13, 'WrongCount_Zero', 5, 1, 'UserDisplay_103');
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (104, 14, 'WrongCount_Two', 5, 1, 'UserDisplay_104');
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (105, 15, 'NullParent', 5, 1, 'UserDisplay_105');
INSERT INTO comments (Id, PostId, Text, Score, UserId, UserDisplayName) VALUES (106, 16, 'NullCount', 5, 1, 'UserDisplay_106');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.ParentId = 107829 AND T1.CommentCount = 1;

/*
Gold Result:
('TargetComment_100',)
*/

-- Prediction Query
SELECT comments.Text FROM posts JOIN comments ON posts.Id = comments.PostId WHERE posts.ParentId = 107829 GROUP BY comments.PostId HAVING COUNT(comments.Id) = 1;

/*
Prediction Result:
('TargetComment_100',)
('WrongCount_Zero',)
('WrongCount_Two',)
('NullCount',)
*/