let $albums := doc("Albums.xml")//ALBUM
let $catalog := doc("CatalogCD.xml")//CD
let $rents := doc("Rent.xml")//RENT

return
    for $album in $albums
    let $album_id := $album/@ID
    let $album_price := xs:decimal(replace($album/PRICE, '[$]', ''))
    let $cds := $catalog[@ALBUM_ID = $album_id]
    let $cd_ids := $cds/@ID
    let $rent_count := count(
                            for $r in $rents
                            where some $id in $cd_ids satisfies $r/@CD_ID=$id
                            return $r
                            )
    let $total_profit := $rent_count * $album_price
    return
        <AlbumProfit>
            <AlbumID>{ $album_id }</AlbumID>
            <Name>{ $album/NAME/text() }</Name>
            <Price>{ $album_price }</Price>
            <TotalRentals>{ $rent_count }</TotalRentals>
            <TotalProfit>{ format-number($total_profit, '#.00') }</TotalProfit>
        </AlbumProfit>