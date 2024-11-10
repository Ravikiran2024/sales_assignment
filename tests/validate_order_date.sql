select *
from {{ source('PC_HEVODATA_DB','orders') }}
where order_date > current_date
