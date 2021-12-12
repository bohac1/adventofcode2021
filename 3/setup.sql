CREATE FUNCTION sum (input INT[])
 RETURNS INT
 LANGUAGE plpgsql
AS $function$
DECLARE
        v_result INT := 0;
        v_it INT := 0;
BEGIN
        FOREACH v_it IN ARRAY input
        LOOP
                v_result := v_result + v_it;
        END LOOP;
        RETURN v_result;
END
$function$;

CREATE TABLE aoc3a_input (
	id SERIAL,
	val INT[]
);
