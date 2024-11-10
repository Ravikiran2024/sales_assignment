with invalid_orders as (
  select id
  from {{ source('PC_HEVODATA_DB','orders') }}
  where user_id not in (select ID from {{ source('PC_HEVODATA_DB','customers') }})
)

select * from invalid_orders