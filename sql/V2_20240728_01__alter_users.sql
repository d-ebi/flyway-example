ALTER TABLE ${global-environment}.users RENAME COLUMN name TO full_name;
ALTER TABLE ${global-environment}.users ADD COLUMN first_name VARCHAR(50);
ALTER TABLE ${global-environment}.users ADD COLUMN last_name VARCHAR(50);

COMMENT ON TABLE ${global-environment}.users IS 'ユーザ情報を管理するテーブル';
COMMENT ON COLUMN ${global-environment}.users.full_name IS 'ユーザのフルネーム';
COMMENT ON COLUMN ${global-environment}.users.first_name IS 'ユーザの名';
COMMENT ON COLUMN ${global-environment}.users.last_name IS 'ユーザの姓';
