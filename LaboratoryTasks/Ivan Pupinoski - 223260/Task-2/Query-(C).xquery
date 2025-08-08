let $janToMarchRentals := doc("Rent.xml")//RENT[
    let $date_parts := tokenize(FROM_DATE, '/')
    let $month := number($date_parts[1])
    let $year := number($date_parts[3])
    return $year=2020 and $month>=1 and $month<=3
]

let $rentedAlbums := for $album in doc("Albums.xml")//ALBUM
let $album_id := $album/@ID
let $rental_count := count(
                          for $rent in $janToMarchRentals
                          let $cd_id := $rent/@CD_ID
                          where doc("CatalogCD.xml")//CD[@ID=$cd_id and @ALBUM_ID = $album_id]
                          return $rent
                    )
    where $rental_count>=3
    return
        <ALBUM>
        <ID>{$album_id}</ID>
        <NAME>{$album/NAME/text()}</NAME>
        <RENTAL_COUNT>{$rental_count}</RENTAL_COUNT>
        </ALBUM>
return $rentedAlbums