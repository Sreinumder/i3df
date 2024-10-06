-- mappings = {
--    -- Main textobject prefixes
--    around = 'a',
--    inside = 'i',
--
--    -- Next/last variants
--    around_next = 'an',
--    inside_next = 'in',
--    around_last = 'al',
--    inside_last = 'il',
--
--    -- Move cursor to corresponding edge of `a` textobject
--    goto_left = 'g[',
--    goto_right = 'g]',
--  },

-- |Key|     Name      |   Example line   |
-- |---|---------------|-1234567890123456-|
-- | ( |  Balanced ()  | (( *a (bb) ))    |
-- | [ |  Balanced []  | [[ *a [bb] ]]    |
-- | { |  Balanced {}  | {{ *a {bb} }}    |
-- | < |  Balanced <>  | << *a <bb> >>    |
-- |---|---------------|-1234567890123456-|
-- | ) |  Balanced ()  | (( *a (bb) ))    |
-- | ] |  Balanced []  | [[ *a [bb] ]]    |
-- | } |  Balanced {}  | {{ *a {bb} }}    |
-- | > |  Balanced <>  | << *a <bb> >>    |
-- | b |  Alias for    | [( *a {bb} )]    |
-- |   |  ), ], or }   |                  |
-- |---|---------------|-1234567890123456-|
-- | " |  Balanced "   | "*a" " bb "      |
-- | ' |  Balanced '   | '*a' ' bb '      |
-- | ` |  Balanced `   | `*a` ` bb `      |
-- | q |  Alias for    | '*a' " bb "      |
-- |   |  ", ', or `   |                  |
-- |---|---------------|-1234567890123456-|
-- | ? |  User prompt  | e*e o e o o      |
-- |   |(typed e and o)|                  |
-- |---|---------------|-1234567890123456-|
-- | t |      Tag      | <x><y>*a</y></x> |
-- |---|---------------|-1234567890123456-|
-- | f | Function call | f(a, g(*b, c) )  |
-- |---|---------------|-1234567890123456-|
-- | a |   Argument    | f(*a, g(b, c) )  |
-- |---|---------------|-1234567890123456-|
-- |   |    Default    |                  |
-- |   |   (digits,    | aa_*b__cc___     |
-- |   | punctuation,  | (example for _)  |
-- |   | or whitespace)|                  |
-- |---|---------------|-1234567890123456-|
return{
  'echasnovski/mini.ai',
  version = '*',
  keys = {
    {"i", mode={"n", "x"}}, {"a", mode={"n", "x"}},
  }
}
