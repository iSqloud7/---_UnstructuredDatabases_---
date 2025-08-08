for $client in doc("Clients.xml")//CLIENT
let $rentals := doc("Rent.xml")//RENT[CLIENT_ID=$client/@ID]
let $artistRentals :=
    for $artist in doc("Artists.xml")//ARTIST
    let $artistAlbums := doc("Albums.xml")//ALBUM[@ARTIST_ID=$artist/ID]
    let $rentCount := count($rentals[CD_ID=$artistAlbums/@ID])
    where $rentCount > 0
    order by $rentCount descending
    return
        <ARTIST_RENTAL>
            <ARTIST_ID>{$artist/@ID}</ARTIST_ID>
            <ARTIST_NAME>{$artist/NAME/text()}</ARTIST_NAME>
            <RENT_COUNT>{$rentCount}</RENT_COUNT>
            <COUNTRY>{$artist/COUNTRY/text()}</COUNTRY>
            <GENRES>
                {for $genre in $artist/GENRE
                  return <GENRE>{$genre/text()}</GENRE>}
            </GENRES>
        </ARTIST_RENTAL>
        
let $favoriteArtist := $artistRentals[1]
where count($artistRentals) > 0
return
    <CLIENT_FAVORITE>
        <CLIENT_ID>{$client/@ID}</CLIENT_ID>
        <CLIENT_NAME>
            {if ($client/NAME) then $client/NAME/text()
           else $client/BASIC_INFO/NAME/text()}
         </CLIENT_NAME>
         <CLIENT_SURNAME>
             {if ($client/SURNAME) then $client/SURNAME/text()
             else $client/BASIC_INFO/SURNAME/text()}
         </CLIENT_SURNAME>
         <FAVORITE_ARTIST>
            {$favoriteArtist}
         </FAVORITE_ARTIST>
       
    </CLIENT_FAVORITE>