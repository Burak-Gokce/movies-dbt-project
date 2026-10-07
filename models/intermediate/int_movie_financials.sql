with movies as (

    select
        movie_id,
        title,
        release_date,
        budget,
        revenue

    from {{ ref('stg_movies_metadata') }}

),

financials as (

    select
        movie_id,
        title,
        release_date,
        budget,
        revenue,

        revenue - budget as profit,

        safe_divide(
            revenue - budget,
            budget
        ) as roi

    from movies

    where budget > 0
      and revenue > 0

)

select *
from financials