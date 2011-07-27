-module(proper_stdgen_tests).
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

%% properties
prop_lowercase_latin_char() ->
    ?FORALL(Char, proper_stdgen:lowercase_latin_char(),
            string:to_lower([Char]) =:= [Char]).

prop_uppercase_latin_char() ->
    ?FORALL(Char, proper_stdgen:uppercase_latin_char(),
            string:to_upper([Char]) =:= [Char]).

prop_latin_char() ->
    ?FORALL(Char, proper_stdgen:latin_char(),
            string:to_lower(string:to_upper([Char])) =:= string:to_lower([Char])).

prop_number_char() ->
    ?FORALL(Char, proper_stdgen:number_char(),
            integer_to_list(list_to_integer([Char])) =:= [Char]).

prop_posix_filename() ->
    ?FORALL(Filename, proper_stdgen:posix_filename(),
            lists:member($/,Filename) =:= false).

prop_posix_abs_filepath() ->
    ?FORALL(Filepath, proper_stdgen:posix_abs_filepath(),
            begin
                [H|_] = Filepath,
                H =:= $/
            end).
    

%% eunit helpers
t_properties() ->
    ?assertEqual([], 
                 proper:module(?MODULE,
                               [{'on_output', 
                                 fun(Format, Data) ->
                                         io:format(standard_error,
                                                   Format, Data)
                                 end}, {numtests, 100}])).

sgrid_yang_module_test_() ->
   [
    {timeout, 30, {"PropEr tests", ?_test(t_properties())}}
   ].
