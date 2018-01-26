drop table if exists ranges;
create table ranges (
  cnt int unsigned not null auto_increment
  , min_val int unsigned not null
  , max_val int unsigned not null
  , primary key (cnt)
) engine = INNODB;

drop procedure if exists load_ranges_data;
delimiter #
create procedure load_ranges_data(
 IN start_val int,
 IN end_val int,
 IN interval_val int
)
begin 
declare min_val_var int unsigned;
declare max_val_var int unsigned;
declare increment_val int unsigned;

  start transaction;
  set min_val_var = start_val;
  set increment_val = cast(((end_val - start_val + 1) / interval_val) as unsigned);
  set max_val_var = (start_val + increment_val-1);
  
  while min_val_var < end_val do
    insert into ranges (min_val, max_val) values
      (min_val_var, max_val_var);
    set min_val_var = min_val_var + increment_val;
    set max_val_var = max_val_var + increment_val;
  end while;
  commit;
end #
delimiter ;

call load_ranges_data(@start,@end,@interval);
