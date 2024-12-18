select 
	unnest(food_item_ids) ids, 
	count(*) as food_frequency
from (
		select 
			xpath ('//food_item_id/text()', menu_data)::varchar[] as food_item_ids,
			case 
				when xmlexists('//total_count/text()' PASSING BY REF menu_data) = true
					then (xpath('//total_count/text()', menu_data)::varchar[]::integer[])[1]
				when xmlexists('//total_guests/text()' PASSING BY REF menu_data) = true
					then (xpath('//total_guests/text()', menu_data)::varchar[]::integer[])[1]
				when xmlexists('//guestCount/text()' PASSING BY REF menu_data) = true 
					then (xpath('//guestCount/text()', menu_data)::varchar[]::integer[])[1]
				when xmlexists('//total_present/text()' PASSING BY REF menu_data) = true
					then (xpath('//total_present/text()', menu_data)::varchar[]::integer[])[1]
		
			end as guest_count
		from christmas_menus
	)
where guest_count > 78
group by ids 
order by food_frequency desc
limit 1;