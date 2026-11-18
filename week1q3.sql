use master;

SELECT student_id,UPPER(LTRIM(RTRIM(student_name))) AS clean_name,LEFT(email, CHARINDEX('@', email) - 1) AS email_user,
RIGHT(email, CHARINDEX('@', email) - 1) AS email_domain,
CASE WHEN phone IS NULL THEN 'Not Provided'
ELSE 'XXXXXX' + RIGHT(phone, 4)
END AS masked_phone, DATENAME(MONTH, join_date) AS join_month, DATEDIFF(DAY, join_date, '2026-10-01') AS days_with_us FROM students ORDER BY student_id;
