select
    o_orderkey as orderkey,
    o_custkey as customer_key,
    o_orderstatus as status_code,
    o_totalprice as total_price
from
    {{ source('tpch', 'orders')}}