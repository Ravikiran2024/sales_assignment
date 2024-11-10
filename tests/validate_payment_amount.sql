select *
from {{ source('PC_HEVODATA_DB','payments') }}
where amount <= 0
