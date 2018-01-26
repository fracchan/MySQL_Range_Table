Help on table_ranges_increment:

NAME
   table_ranges_increment.sql - A MySQL procedure to create a table of range values from a start, end and increment parameters.

FILE
   table_ranges_increment.sql

DESCRIPTION
   This procedure automatically creates a table called ranges in the database you have selected.
   Each range is inclusive of both limit values.
   Table has three columns: 
     1 - cnt (an automatically incremented counter)
     2 - min_val
     3 - max_val
   All generated values are unsigned ints.
   The last interval is the one where the min_val is less than the end_value parameter chosen as input.
   For this reason, the max_val of the last interval can be either more or less than the end parameter itself.
   
USAGE
   [`your_DB`]> set @start = `start_value`; set @end = `end_value`; set @increment = `increment_value`; \. table_ranges_increment.sql

EXAMPLES
  
   [test]> set @start = 1; set @end = 100; set @increment = 10; \. table_ranges_increment.sql
     +-----+---------+---------+
     | cnt | min_val | max_val |
     +-----+---------+---------+
     |   1 |       1 |      10 |
     |   2 |      11 |      20 |
     |   3 |      21 |      30 |
     |   4 |      31 |      40 |
     |   5 |      41 |      50 |
     |   6 |      51 |      60 |
     |   7 |      61 |      70 |
     |   8 |      71 |      80 |
     |   9 |      81 |      90 |
     |  10 |      91 |     100 |
     +-----+---------+---------+

   [test]> set @start = 11; set @end = 20; set @increment = 5; \. table_ranges_increment.sql
     +-----+---------+---------+
     | cnt | min_val | max_val |
     +-----+---------+---------+
     |   1 |      11 |      15 |
     |   2 |      16 |      20 |
     +-----+---------+---------+

   [test]> set @start = 10; set @end = 20; set @increment = 5; \. table_ranges_increment.sql
     +-----+---------+---------+
     | cnt | min_val | max_val |
     +-----+---------+---------+
     |   1 |      10 |      14 |
     |   2 |      15 |      19 |
     +-----+---------+---------+

   [test]> set @start = 1; set @end = 20; set @increment = 6; \. table_ranges_increment.sql
     +-----+---------+---------+
     | cnt | min_val | max_val |
     +-----+---------+---------+
     |   1 |       1 |       6 |
     |   2 |       7 |      12 |
     |   3 |      13 |      18 |
     |   4 |      19 |      24 |
     +-----+---------+---------+
