
let $clients := doc("Clients.xml")//CLIENT
let $artists := doc("Artists.xml")//ARTIST
let $albums := doc("Albums.xml")//ALBUM
let $groups := doc("Groups.xml")//GROUP
let $rents := doc("Rent.xml")//RENT
let $catalog := doc("CatalogCD.xml")//CD

return
<SYSTEM>
    <CLIENTS>
        {
            for $client in $clients
            return
                <CLIENT ID="{$client/@ID}">
                    <NAME>{$client/NAME/text()}</NAME>
                    <SURNAME>{$client/SURNAME/text()}</SURNAME>
                    <ADDRESS>
                        {
                            if ($client/ADDRESS/STREET and $client/ADDRESS/NUMBER) then (
                            <STREET>{$client/ADDRESS/STREET/text()}</STREET>,
                            <NUMBER>{$client/ADDRESS/NUMBER/text()}</NUMBER>
                          )
                          else
                            <FULL_ADDRESS>{$client/ADDRESS/FULL_ADDRESS/text()}</FULL_ADDRESS>
                        }
                    </ADDRESS>
                    <EMAIL>{$client/EMAIL/text()}</EMAIL>
                    <PHONE_NUMBER>{$client/PHONE_NUMBER/text()}</PHONE_NUMBER>
                </CLIENT>
        }
    </CLIENTS>
    
    <ARTISTS>
        {
            for $artist in $artists
            return
                <ARTIST ID="{$artist/@ID}" type="{$artist/@type}">
                    <NAME>{$artist/NAME/text()}</NAME>
                    <COUNTRY>{$artist/COUNTRY/text()}</COUNTRY>
                    <GENRE>{$artist/GENRE/text()}</GENRE>
                    {
                        if ($artist/@type = 'dj') then (
                            <YEAR_STARTED_PERFORMING>{$artist/YEAR_STARTED_PERFORMING/text()}</YEAR_STARTED_PERFORMING>,
                            <NET_WORTH>{$artist/NET_WORTH/text()}</NET_WORTH>,
                            <YEAR_OF_BIRTH>{$artist/YEAR_OF_BIRTH/text()}</YEAR_OF_BIRTH>
                         )
                         else ()
                    }
                </ARTIST>
        }
    </ARTISTS>

    <ALBUMS>
        {
            for $album in $albums
            return
                <ALBUM ID="{$album/@ID}" ARTIST_ID="{$album/@ARTIST_ID}">
                    <NAME>{$album/NAME/text()}</NAME>
                    <RELEASE_YEAR>{$album/RELEASE_YEAR/text()}</RELEASE_YEAR>
                    <PRICE>{$album/PRICE/text()}</PRICE>
                </ALBUM>
        }
    </ALBUMS>
    
    <GROUPS>
        {
            for $group in $groups
            return
                <GROUP ID="{$group/@ID}">
                    <YEAR_FORMED>{$group/YEAR_FORMED/text()}</YEAR_FORMED>
                    <NUMBER_OF_MEMBERS>{$group/NUMBER_OF_MEMBERS/text()}</NUMBER_OF_MEMBERS>
                </GROUP>
        }
    </GROUPS>
    
    <RENTS>
        {
            for $rent in $rents
            return
                <RENT ID="{$rent/@ID}" CLIENT_ID="{$rent/@CLIENT_ID}" CD_ID="{$rent/@CD_ID}">
                    <FROM_DATE>{$rent/FROM_DATE/text()}</FROM_DATE>
                    <RETURN_STATE>{$rent/RETURN_STATE/text()}</RETURN_STATE>
                    <RETURN_DATE>{$rent/RETURN_DATE/text()}</RETURN_DATE>
                </RENT>
        }
    </RENTS>
     <CATALOG>
    {
      for $cd in $catalog
      return
        <CD ID="{$cd/@ID}" ALBUM_ID="{$cd/@ALBUM_ID}">
          <STATE>{$cd/STATE/text()}</STATE>
          <OCCUPIED>{$cd/OCCUPIED/text()}</OCCUPIED>
        </CD>
    }
  </CATALOG>
</SYSTEM>