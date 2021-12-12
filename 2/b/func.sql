CREATE OR REPLACE FUNCTION aoc2b ( )
 RETURNS INT
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_depth INT := 0;
	v_distance INT := 0;
	v_aim INT := 0;
	v_rec RECORD;
BEGIN
	FOR v_rec IN
		SELECT direction, val FROM aoc2a_input ORDER BY id ASC
	LOOP
		IF v_rec.direction = 'forward' THEN
			v_distance := v_distance + v_rec.val;
			v_depth := v_depth + v_rec.val * v_aim;
		ELSIF v_rec.direction = 'up' THEN
			v_aim := v_aim - v_rec.val;
		ELSIF v_rec.direction = 'down' THEN
			v_aim := v_aim + v_rec.val;
		END IF;
	END LOOP;
	RETURN v_depth * v_distance;
END
$function$;
