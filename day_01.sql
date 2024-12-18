 SELECT c.name,
    w.wishes ->> 'first_choice'::text AS primary_wish,
    w.wishes ->> 'second_choice'::text AS backup_wish,
    (w.wishes -> 'colors'::text) ->> 0 AS favorite_color,
    jsonb_array_length(w.wishes::jsonb -> 'colors'::text) AS color_count,
        CASE
            WHEN t.difficulty_to_make = 1 THEN 'Simple Gift'::text
            WHEN t.difficulty_to_make = 2 THEN 'Moderate Gift'::text
            WHEN t.difficulty_to_make >= 3 THEN 'Complex Gift'::text
            ELSE NULL::text
        END AS gift_complexity,
        CASE
            WHEN t.category::text = 'outdoor'::text THEN 'Outside Workshop'::text
            WHEN t.category::text = 'educational'::text THEN 'Learning Workshop'::text
            ELSE 'General Workshop'::text
        END AS workshop_assignment
   FROM children c
     JOIN wish_lists w ON c.child_id = w.child_id
     JOIN toy_catalogue t ON t.toy_name::text = (w.wishes ->> 'first_choice'::text)
  ORDER BY c.name;