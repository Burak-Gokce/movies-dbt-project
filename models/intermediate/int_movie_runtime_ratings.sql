with movies as (

    select
        movie_id,
        title,
        release_date,
        runtime,
        vote_average,
        vote_count

    from {{ ref('stg_movies_metadata') }}

),

filtered as (

    select
        movie_id,
        title,
        release_date,
        runtime,
        vote_average,
        vote_count

    from movies

    where runtime > 0
      and vote_average is not null

),

runtime_groups as (

    select
        movie_id,
        title,
        release_date,
        runtime,
        vote_average,
        vote_count,

        case
            when runtime < 90 then 'Short (<90)'
            when runtime <= 120 then 'Medium (90-120)'
            else 'Long (>120)'
        end as runtime_group

    from filtered

)

select *
from runtime_groups