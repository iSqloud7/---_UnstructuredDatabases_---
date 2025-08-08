let $all_rentals := doc("Rent.xml")//RENT

let $album_rentals_counts := for $album in doc("Albums.xml")//ALBUM
    let $album_id := $album/@ID
    let $rental_count:=count(
                         for $rent in $all_rentals
                         let $cd_id:=$rent/@CD_ID
                         where doc("CatalogCD.xml")//CD[@ID=$cd_id and @ALBUM_ID = $album_id]
                         return $rent
                        )
    order by $rental_count descending
    return
    <ALBUM_COUNT>
        <ALBUM_ID>{$album_id}</ALBUM_ID>
        <COUNT>{$rental_count}</COUNT>
    </ALBUM_COUNT>
    
let $most_rented_album_id := $album_rentals_counts[1]/ALBUM_ID/text()
let $most_rented_album := doc("Albums.xml")//ALBUM[@ID=$most_rented_album_id]

let $album_cd_id := for $cd in doc("CatalogCD.xml")//CD[@ALBUM_ID = $most_rented_album_id]
    return $cd/@ID
    
let $album_rentals := for $rent in $all_rentals
    where $rent/@CD_ID = $album_cd_id
    return $rent 
   
let $client_rental_counts := 
    for $client_id in distinct-values($album_rentals/@CLIENT_ID)
    let $count := count($album_rentals[@CLIENT_ID = $client_id])
    order by $count descending
    return 
        <CLIENT_COUNT>
            <CLIENT_ID>{$client_id}</CLIENT_ID>
            <COUNT>{$count}</COUNT>
        </CLIENT_COUNT>
        
let $top_client_id := $client_rental_counts[1]/CLIENT_ID/text()
let $top_client := doc("Clients.xml")//CLIENT[@ID=top_client_id]

return
    <RESULT>
        <TOP_CLIENT>
            {$top_client}
        </TOP_CLIENT>
        <MOST_RENTED_ALBUM>
            {$most_rented_album}
        </MOST_RENTED_ALBUM>
    </RESULT>