with source as (

    select distinct *
    from {{ source('movies_raw', 'movies_metadata') }}

),

cleaned as (

    select
        id as movie_id,
        imdb_id,

        title,
        original_title,
        original_language,

        safe_cast(release_date as date) as release_date,

        safe_cast(budget as numeric) as budget,
        safe_cast(revenue as numeric) as revenue,
        safe_cast(runtime as float64) as runtime,

        safe_cast(popularity as float64) as popularity,
        safe_cast(vote_average as float64) as vote_average,
        safe_cast(vote_count as int64) as vote_count,

        adult,
        video,
        status,

        nullif(trim(belongs_to_collection), '') as belongs_to_collection,
        nullif(trim(genres), '[]') as genres,
        nullif(trim(production_companies), '[]') as production_companies,
        nullif(trim(production_countries), '[]') as production_countries,
        nullif(trim(spoken_languages), '[]') as spoken_languages,

        overview,
        tagline,
        homepage,
        poster_path

    from source

),

deduplicated as (

    select *
    from cleaned

    qualify row_number() over (
        partition by movie_id
        order by
            vote_count desc nulls last,
            popularity desc nulls last
    ) = 1

)

select *
from deduplicated