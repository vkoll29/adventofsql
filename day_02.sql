WITH letters AS (
	SELECT CHR(value) AS letter
	FROM letters_a
	WHERE CHR(value) SIMILAR TO '[a-zA-Z,.!?: ]'
	UNION ALL 
	SELECT CHR(value) AS letter
	FROM letters_B
	WHERE CHR(value) SIMILAR TO '[a-zA-Z,.!?: ]'
)
SELECT string_agg(letter, '') AS msg
FROM letters;