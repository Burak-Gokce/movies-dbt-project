with genres as (

    select
        movie_id,
        title,
        release_year,
        genre_name

    from {{ ref('int_movie_genres') }}

    where release_year is not null

),

genre_year_counts as (

    select
        release_year,
        genre_name,
        count(distinct movie_id) as genre_movie_count

    from genres

    group by
        release_year,
        genre_name

),

year_totals as (

    select
        release_year,
        count(distinct movie_id) as total_movies

    from genres

    group by release_year

),

final as (

    select
        g.release_year,
        g.genre_name,
        g.genre_movie_count,
        y.total_movies,

        safe_divide(
            g.genre_movie_count,
            y.total_movies
        ) as genre_share

    from genre_year_counts g

    left join year_totals y
        on g.release_year = y.release_year

)

select *
from final