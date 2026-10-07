with financials as (

    select *
    from {{ ref('int_movie_financials') }}

),

final as (

    select
        movie_id,
        title,
        release_date,
        extract(year from release_date) as release_year,

        budget,
        revenue,
        profit,
        roi,

        ln(budget) as log_budget,
        ln(revenue) as log_revenue

    from financials

)

select *
from final