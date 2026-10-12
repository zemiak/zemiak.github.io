local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId

local limit = conf.limit or 100
local characters = conf.characters or 6

local n_quar = "Takže zatiaľ sa hrám iba v súčasnosti, táto Challenge nevyzerá byť pre mňa splniteľná v krátkom čase."
local n_neog = "Spoločnosť v neogéne mi robia prví ľudoopi v jaskyniach. K splneniu výzvy musím násť ešte dobrých 200 kešiek. Ufff."
local n_pale = "Spoločnosť v paleogéne mi robia prvé opice v korunách stromov, alebo predkovia delfínov a veľrýb v moriach. K splneniu výzvy stále ďaleko."
local n_cret = "Tým sa dostávam do kriedy - sveta, kde vládne Tyrannosaurus rex, Pterosaurus a Triceratops. Ešte tak polovica a som tam!"
local n_jura = "Dostávam sa tak do jury - sveta, kde na súši dominujú Stegosaury, v moriach Ichtyosaury, spolu s krokodílmi a dravými korytnačkami."
local n_tria = "Som už v triase - vo svete, kde sa na uvoľnenú súš po Veľkom Permskom vymieraní opäť dostávajú obojživeľníky a plazy. Už mi chýba len krôčik do minulosti."
local n_perm = "Takže som tu - v perme, vo svete pred Veľkým Permským vymieraním, kde na súši panujú všetci tí masívni kríženci krokodílov a archaických dinosaurov."
local n_carb = "V mojom svete - v karbóne, práve z morí vyliezli takmer meter dlhí predchodcovia škorpiónov a šesťmetrové jašteričky."
local n_devo = "Týmto sa dostávam do devónu - na planétu, kde moria brázdi obrnený Dunkleosteus a z vôd sa vynárajú prvé obojživeľníky a hmyz."
local n_silu = "Tým sa dostávam až do dôb silúru, keď sa život ešte len začínal adaptovať na súši. Vrcholom civilizácie sú kostnaté ryby a prvé pavúkovce."
local n_ordo = "V mojom svete, v ordoviku, sú na vrchole rozvoja trilobity, lastúrniky, primitívne hlavonožce a mäkkýše. Biologickou novinkou sú rybovité prastavovce."
local n_camb = "Dostávam sa tak do dôb kambria, keď v moriach naplno vypukla explózia života. Skončilo globálne zaľadnenie a všetky tie hubky, ulitníky a trilobity dostali zelenú."
local n_prot = "Spoločnosť v starohorách mi robia ešte len baktérie, sinice, riasy a prvé primitívne mnohobunkovce. Žiadne kešky tu ešte nie sú."
local n_arch = "To znamená, že moja cesta v čase dosiahla prahory - éru, v ktorej sa formujú prvé kontinenty a objavujú prvé známky života na planéte."
local n_hade = "Dostal som sa do hadaika - doby útleho detstva planéty, keď je žeravý povrch bombardovali meteorické roje a nebolo tu vôbec nič len peklo."

local c_quar = "https://s3.amazonaws.com/gs-geo-images/db647da5-49d1-4dc2-ad92-fc4123f58878.png"
local c_neog = "https://s3.amazonaws.com/gs-geo-images/671e286e-bbd1-4e92-a6ce-ed39580a7f34.png"
local c_pale = "https://s3.amazonaws.com/gs-geo-images/48ee7bc0-d54e-4300-b77f-16373ef250bf.png"
local c_cret = "https://s3.amazonaws.com/gs-geo-images/844ee93a-22d3-4a21-a47e-c5c2b2cef157.png"
local c_jura = "https://s3.amazonaws.com/gs-geo-images/7e7b4f3f-d9f2-46b7-9108-3da4657173cb.png"
local c_tria = "https://s3.amazonaws.com/gs-geo-images/8751836b-6b6f-4a1c-b580-0fbd7838ffeb.png"
local c_perm = "https://s3.amazonaws.com/gs-geo-images/6d3f00e7-7622-4bd2-bccb-f43d75be1445.png"
local c_carb = "https://s3.amazonaws.com/gs-geo-images/f02b8ca5-3e6d-4a5b-8f6d-8bb8195d6e4c.png"
local c_devo = "https://s3.amazonaws.com/gs-geo-images/cfc713fe-123c-44a8-81e2-d83fed149edc.png"
local c_silu = "https://s3.amazonaws.com/gs-geo-images/a716f01d-cf18-4dfb-89f0-59715e35fa8c.png"
local c_ordo = "https://s3.amazonaws.com/gs-geo-images/72c9aa70-1457-4aed-bf92-6744c81d09a7.png"
local c_camb = "https://s3.amazonaws.com/gs-geo-images/45287b68-a38b-4190-a057-d7f9050cc8ea.png"
local c_prot = "https://s3.amazonaws.com/gs-geo-images/1784a478-2ac9-4bbf-8e26-d45f14cc614b.png"
local c_arch = "https://s3.amazonaws.com/gs-geo-images/46a48a44-c2c8-4885-bece-1a947ad6eae3.png"
local c_hade = "https://s3.amazonaws.com/gs-geo-images/3397de10-18ce-460c-bd21-d120d80317fe.png"

local maxPlacedDate = "9999-12-31"
if (conf.maxPlacedDate ~= nil) then
  maxPlacedDate = conf.maxPlacedDate
end
temp = string.gsub(maxPlacedDate,"[^0-9]","")
maxPlacedDate = tonumber(temp)

PGC.print('Got profile name, ', profileName, "\n")
PGC.print('Got profile id ', profileId, "\n")
PGC.print('Got Limit ', limit, "\n")
PGC.print('Got Characters ', characters, "\n")

profileFinds = PGC.GetFinds( profileId, { fields = { 'gccode', 'cache_name', 'visitdate', 'type', 'hidden' }, order = 'OLDESTFIRST' } )

local ocCount = 0
local qcCount = 0
local gccode = ""

--local log = "\n"
local ok = false
local log = false
local html = false

-- Check if challenge is fulfilled and if so, set ok = true

for _,cache in ipairs(profileFinds) do
	gccode = cache['gccode']
	gctype = cache['type']
  	h_date = cache['hidden']							--new
  
  	temp = string.gsub(cache['hidden'],"[^0-9]","") 		--new
    local placeddate = tonumber(temp)					--new
    	if (placeddate < maxPlacedDate) then			--new

--	if #gccode <= characters then	  
	  --log = log .. gccode .. " - " .. cache['cache_name'] .. " - " .. cache['visitdate'] .. "\n"
	  ocCount = ocCount + 1
	end
  
	if #gccode < characters then	  
	  qcCount = qcCount + 1
	end
end

if (ocCount >= limit) then
	ok = true
end

if ok == true then
  	log = "**Mám to SPLNENÉ!** Medzi mojimi nálezmi je **" .. ocCount .. "** kešiek z prvohôr Geocachingu." .. "\n"
  	html = "<p style='font-size:20pt;font-family: segoe UI, arial;'>" .. profileName .. " - má SPLNENÉ!<br> Má na svojom konte už <b>" .. ocCount .. "</b> kešiek z prvohôr Geocachingu.</p>"
	
  	if ocCount <= 298.9 then --Permian
    	log = log .. n_perm
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_perm .. "</p><br>"
    	html = html .. "<p><img src='" .. c_perm .. "'></p>"
  	elseif ocCount <= 358.9 then --Carboniferous
		log = log .. n_carb
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_carb .. "</p><br>"
    	html = html .. "<p><img src='" .. c_carb .. "'></p>"
  	elseif ocCount <= 419.2 then --Devonian
		log = log .. n_devo
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_devo .. "</p><br>"
    	html = html .. "<p><img src='" .. c_devo .. "'></p>"
  	elseif ocCount <= 443.8 then --Silurian
		log = log .. n_silu
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_silu .. "</p><br>"
    	html = html .. "<p><img src='" .. c_silu .. "'></p>"
  	elseif ocCount <= 485.4 then --Ordovician
		log = log .. n_ordo
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_ordo .. "</p><br>"
    	html = html .. "<p><img src='" .. c_ordo .. "'></p>"
  	elseif ocCount <= 541 then --Cambrian
		log = log .. n_camb
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_camb .. "</p><br>"
    	html = html .. "<p><img src='" .. c_camb .. "'></p>"
	elseif ocCount <= 2500 then --Proterozoic
		log = log .. n_prot
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_prot .. "</p><br>"
    	html = html .. "<p><img src='" .. c_prot .. "'></p>"
  	elseif ocCount <= 4000 then --Archean
		log = log .. n_arch
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_arch .. "</p><br>"
    	html = html .. "<p><img src='" .. c_arch .. "'></p>"
    else
        log = log .. n_hade --Hadean
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_hade .. "</p><br>"
    	html = html .. "<p><img src='" .. c_hade .. "'></p>"
    end
                
    if qcCount > 0 then
  		log = log .. "\n" .. "*Len pre zaujímavosť - **" .. qcCount .. "** z týchto kešiek bolo založených skôr ako 10.07.2001!*"
    	html = html .. "<br><p style='font-size:12pt;font-family: segoe UI, arial;'>Len pre zaujímavosť - <b>" .. qcCount .. "</b> z týchto kešiek bolo založených skôr ako 10.07.2001!</p>"
    else
    	html = html .. "<br><p style='font-size:12pt;font-family: segoe UI, arial;'>Len pre zaujímavosť - všetky boli založené po 10.07.2001, staršie teda ešte len čakajú na môj prvý log.</p>"
    	log = log .. "\n" .. "*Len pre zaujímavosť - všetky tieto kešky boli založené po 10.07.2001, staršia ma teda ešte len čaká.*"
    end

else
	
    log = "Ešte to nemám splnené. Medzi mojimi nálezmi je len **" .. ocCount .. "** kešiek z prvohôr Geocachingu." .. "\n"
  	html = "<p style='font-size:20pt;font-family: segoe UI, arial;'>" .. profileName .. " - má zatiaľ smolu!<br>Má na konte ešte len <b>" .. ocCount .. "</b> nájdených kešiek z prvohôr Geocachingu.</p>"

  	if ocCount <= 2.58 then --Quartenary
    	log = log .. n_quar
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_quar .. "<br>"
    	html = html .. "Túto Challenge kešku zatiaľ zalogujem formou Write Note a až po splnení budem môcť log kedykoľvek zmeniť na Found it!</p><br>"
    	html = html .. "<p><img src='" .. c_quar .. "'></p>"
  	elseif ocCount <= 23.03 then --Neogene
		log = log .. n_neog
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_neog .. "<br>"
    	html = html .. "Túto Challenge kešku zatiaľ zalogujem formou Write Note a až po splnení budem môcť log kedykoľvek zmeniť na Found it!</p><br>"
    	html = html .. "<p><img src='" .. c_neog .. "'></p>"
  	elseif ocCount <= 66 then --Paleogene
		log = log .. n_pale
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_pale .. "<br>"
    	html = html .. "Túto Challenge kešku zatiaľ zalogujem formou Write Note a až po splnení budem môcť log kedykoľvek zmeniť na Found it!</p><br>"
    	html = html .. "<p><img src='" .. c_pale .. "'></p>"
  	elseif ocCount <= 145 then --Cretaceous
		log = log .. n_cret
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_cret .. "<br>"
    	html = html .. "Túto Challenge kešku zatiaľ zalogujem formou Write Note a až po splnení budem môcť log kedykoľvek zmeniť na Found it!</p><br>"
    	html = html .. "<p><img src='" .. c_cret .. "'></p>"
  	elseif ocCount <= 201.3 then --Jurassic
		log = log .. n_jura
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_jura .. "<br>"
    	html = html .. "Túto Challenge kešku zatiaľ zalogujem formou Write Note a až po splnení budem môcť log kedykoľvek zmeniť na Found it!</p><br>"
    	html = html .. "<p><img src='" .. c_jura .. "'></p>"
  	else 
        log = log .. n_tria    --Triassic
    	html = html .. "<p style='font-size:12pt;font-family: segoe UI, arial;'>" .. n_tria .. "<br>"
    	html = html .. "Túto Challenge kešku zatiaľ zalogujem formou Write Note a až po splnení budem môcť log kedykoľvek zmeniť na Found it!</p><br>"
    	html = html .. "<p><img src='" .. c_tria .. "'></p>"
    end
                
    if qcCount > 0 then
  		log = log .. "\n" .. "*Len pre zaujímavosť - **" .. qcCount .. "** z týchto kešiek bolo založených skôr ako 10.07.2001!*"
    	html = html .. "<br><p style='font-size:12pt;font-family: segoe UI, arial;'>Len pre zaujímavosť - <b>" .. qcCount .. "</b> z týchto kešiek bolo založených skôr ako 10.07.2001!</p>"
    else
    	html = html .. "<br><p style='font-size:12pt;font-family: segoe UI, arial;'>Len pre zaujímavosť - všetky tieto kešky boli založené po 10.07.2001, staršie teda ešte len čakajú na prvý log.</p>"
    	log = log .. "\n" .. "*Len pre zaujímavosť - všetky tieto kešky boli založené po 10.07.2001, staršia ma ešte len čaká.*"
    end
    
end

--PGC.print(html);

--[[
if (ocCount >= limit) then
	log = log .. "\nYou qualify for this challenge."
else
	log = log .. "\nYou do not qualify for this challenge."
	PGC.print('Found ', ocCount, "\n")

	ok = false
end


if(ok == true) then
  -- Produce example log, Project-GC recommends using Markdown if it's useful.
  -- Do not use  log = log .. "foo"  in loops with many iterations, it consumes a lot of memory in LUA.
  log = {}
  table.insert(log, "foo")
  table.insert(log, "bar")
  table.insert(log, "baz")
  log = table.concat(log, "\n")
end
--]]



--More feedback can be given by producing html into the html variable
--Can be of good use to show the user his/her progress
--Doesn't actually have to be html

return { ok = ok, log = log, html = html }