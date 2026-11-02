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
INSERT INTO users (Id, DisplayName, Reputation) VALUES (1, 'UserA', 100);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (10, 2, 107829, 1, 'Body_10', 'Title_10', 'Tag_10', 1);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (20, 2, 107828, 1, 'Body_20', 'Title_20', 'Tag_20', 1);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (30, 2, 107830, 1, 'Body_30', 'Title_30', 'Tag_30', 1);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (40, 2, 107829, 0, 'Body_40', 'Title_40', 'Tag_40', 1);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (50, 2, 107829, 2, 'Body_50', 'Title_50', 'Tag_50', 1);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (60, 2, NULL, 1, 'Body_60', 'Title_60', 'Tag_60', 1);
INSERT INTO posts (Id, PostTypeId, ParentId, CommentCount, Body, Title, Tags, OwnerUserId) VALUES (70, 2, 107829, NULL, 'Body_70', 'Title_70', 'Tag_70', 1);
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (100, 10, 5, 'Valid_Comment_1', 1, 'Disp_100');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (200, 20, 5, 'Wrong_Parent_Low', 1, 'Disp_200');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (300, 30, 5, 'Wrong_Parent_High', 1, 'Disp_300');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (400, 40, 5, 'Wrong_Count_Zero', 1, 'Disp_400');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (500, 50, 5, 'Wrong_Count_Two', 1, 'Disp_500');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (600, 60, 5, 'Null_Parent', 1, 'Disp_600');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (700, 70, 5, 'Null_Count', 1, 'Disp_700');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.ParentId = 107829 AND T1.CommentCount = 1;

/*
Gold Result:
('Valid_Comment_1',)
*/

-- Prediction Query
SELECT comments.Text FROM posts JOIN comments ON posts.Id = comments.PostId WHERE posts.ParentId = 107829 GROUP BY comments.PostId HAVING COUNT(comments.Id) = 1;

/*
Prediction Result:
('Valid_Comment_1',)
('Wrong_Count_Zero',)
('Wrong_Count_Two',)
('Null_Count',)
*/