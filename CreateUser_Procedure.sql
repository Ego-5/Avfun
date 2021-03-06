USE [avfun]
GO
/****** Object:  StoredProcedure [dbo].[CreateNewUser]    Script Date: 05/15/2014 22:50:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LU YuXun>
-- Create date: 2014-5-13
-- Description:	添加一个新的普通用户
-- =============================================
ALTER PROCEDURE [dbo].[CreateNewUser] 
	-- Add the parameters for the stored procedure here
	@Account char(64) = NULL, 
	@Password char(32) = NULL,
	@Nickname char(32) = NULL,
	@Sex bit = 1, --默认是女生哦
	@Head char(256) = '/head/00.jpg',
	@isDeleted bit = 0, --默认未删除
	@isChecked bit = 0, --默认未激活
	@LastLoginTime Date, -- 最后登录时间
	@LastLoginIp char(64), -- 最后登录IP
	@Money float = 0.0, --默认0元
	@Introduction char(256) = NULL --没有自我介绍
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- 判断日期，如果为NULL那么就设置成当前系统时间
    IF @LastLoginTime IS NULL
    BEGIN
	 SET @LastLoginTime = GETDATE();
    END;
	INSERT INTO [USER]
	(
		[user_id],
		[user_account],
		[user_password],
		[user_nickname],
		[user_sex],
		[user_head],
		[user_isDeleted],
		[user_isChecked],
		[user_last_login_time],
		[user_last_login_ip],
		[user_money],
		[user_introduction],
		[user_verify_code]		
	)
	VALUES
	(
		NEWID(),
		@Account,
		@Password,
		@Nickname,
		@Sex,
		@Head,
		@isDeleted,
		@isChecked,
		@LastLoginTime,
		@LastLoginIp,
		@Money,
		@Introduction,
		NEWID()
	)
END
