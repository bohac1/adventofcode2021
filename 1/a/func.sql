CREATE OR REPLACE FUNCTION public.aoc1a()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_no_of_increased INT := 0;
	v_previous INT := NULL;
	v_rec RECORD;
BEGIN
	FOR v_rec IN
		SELECT * FROM aoc1a_input ORDER BY id ASC
	LOOP
		-- RAISE NOTICE '% % %', v_rec.val, v_previous, v_no_of_increased;
		IF v_previous IS NULL THEN
			v_previous := v_rec.val;
			CONTINUE;
		END IF;
		IF v_previous < v_rec.val THEN
			v_no_of_increased := v_no_of_increased + 1;
		END IF;
		v_previous := v_rec.val;
	END LOOP;
	RETURN v_no_of_increased;
END $function$
