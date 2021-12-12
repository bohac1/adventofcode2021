CREATE OR REPLACE FUNCTION aoc3a ( )
 RETURNS INT
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_no_of_records INT := 0;
	v_gamma_counter INT[];
	v_epsilon_arr INT[];
	v_gamma_arr INT[];
	v_arr_it INT;
	v_rec RECORD;
BEGIN
	FOR v_rec IN
		SELECT * FROM aoc3a_input ORDER BY id DESC
	LOOP
		FOR v_arr_it IN 1 .. array_length(v_rec.val, 1)
		LOOP
			v_gamma_counter[v_arr_it] := coalesce(v_gamma_counter[v_arr_it], 0) + v_rec.val[v_arr_it];
		END LOOP;
		v_no_of_records := v_no_of_records + 1;
	END LOOP;

	-- gamma index
	FOR v_arr_it IN 1 .. array_length(v_rec.val, 1)
	LOOP
		v_gamma_counter[v_arr_it] := 
			CASE WHEN
				v_gamma_counter[v_arr_it] > v_no_of_records/2
			THEN 
				1
			ELSE 
				0
			END;
	END LOOP;

	-- calculating decimal representation of binnary number
	v_no_of_records := 0;
	FOR v_arr_it IN REVERSE array_length(v_gamma_counter, 1) .. 1
	LOOP
		IF v_gamma_counter[v_arr_it] = 1 THEN
			v_epsilon_arr[v_arr_it] := power(2, v_no_of_records);
			v_gamma_arr[v_arr_it] := 0;
		ELSE
			v_gamma_arr[v_arr_it] := power(2, v_no_of_records);
			v_epsilon_arr[v_arr_it] := 0;
		END IF;
		v_no_of_records := v_no_of_records + 1;
	END LOOP;
	RETURN sum(v_epsilon_arr) * sum(v_gamma_arr);
END;
$function$
