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

CREATE OR REPLACE FUNCTION public.aoc1b()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
        v_window_size INT := 3;
        v_window INT[];
        v_no_of_increased INT := 0;
        v_rec RECORD;
        v_counter INT := 0;
                v_prev_sum INT := 0;
BEGIN
        FOR v_rec IN
                SELECT * FROM aoc1a_input ORDER BY id ASC
        LOOP
                IF v_counter < v_window_size THEN
                        v_window[v_counter] := v_rec.val;
                ELSE
                        -- check the sums
                        v_prev_sum := sum(v_window);
                        v_window[v_counter % v_window_size] := v_rec.val;
                        IF v_prev_sum < sum(v_window) THEN
                                v_no_of_increased := v_no_of_increased + 1;
                        END IF;
                END IF;

                v_counter := v_counter + 1;
        END LOOP;
        RETURN v_no_of_increased;
END
$function$;
