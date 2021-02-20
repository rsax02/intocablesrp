function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	--Example: AddTextEntry('16charger', '2016 Dodge Charger')
	AddTextEntry("2015a3", "Audi A3") --audiA3
	AddTextEntry("audirs3", "Audi RS3") --audiRS3
	AddTextEntry("rs7", "Audi RS7") --audiRS3
	AddTextEntry("audsq517", "Audi SQ5") --audiSQ5
	AddTextEntry("sq72016", "Audi SQ7") --audiSQ7
	AddTextEntry("bentayga17", "Bentley Bentayga") --BentleyBentayga
	AddTextEntry("bmws", "BMW s1000") --BMWS
	AddTextEntry("hvrod", "Harley Davidson Vrod") --HarleyDavidson
	AddTextEntry("biz25", "Honda Biz") --Honda Biz
	AddTextEntry("nh2r", "Kawasaki Ninja H2R") --Kawasaki Ninja H2R
	AddTextEntry("cbrr", "Honda CBR") --Honda CBR
	AddTextEntry("x6m", "BMW X6")--BMWX6
	AddTextEntry("divo", "Bugatti Divo") --BugattiDivo
	AddTextEntry("gmt900escal", "Cadillac Escalade") --EscaladeVieja
	AddTextEntry("cesc21", "Cadillac Escalade 2021") --Escalade21
	AddTextEntry("c8", "Corvette C8") --Corvette
	AddTextEntry("impalal", "Chevrolet Impala") --Corvette
	AddTextEntry("tahoe", "Chevrolet Tahoe") --Tahoe
	AddTextEntry("ds3", "Citroen DS3") --Citroen DS3
	AddTextEntry("f812", "Ferrari superfast") --Ferrari superfast
	AddTextEntry("fiat600", "Fiat600") --Fiat600
	AddTextEntry("fe86", "Ford Escort") --Fiat600
	AddTextEntry("everest", "Ford Everest") --Ford Everest
	AddTextEntry("explorer20", "Ford Explorer 2020") --Ford Explorer20
	AddTextEntry("RAPTOR150", "Ford Raptor 150 2017") --Ford Raptor 150 2017
	AddTextEntry("f150", "Ford Raptor 150 2012")--Ford Raptor 150 2012
	AddTextEntry("h6", "Hummer H2") --Hummer H2
	AddTextEntry("srt8", "Jeep SRT8") --Jeep SRT8
	AddTextEntry("trhawk", "Jeep Trackhawk")--Jeep Trackhawk
	AddTextEntry("KoenigseggAgeraR", "Koenigsegg Agera R") --KoenigseggAgeraR
	AddTextEntry("regera", "Koenigsegg Regera") --KoenigseggAgeraR
	AddTextEntry("lp610", "Lamborghini Huracán Perf") --Lamborghini Huracán
	AddTextEntry("a45", "Mercedes A45") --Mercedes A45
	AddTextEntry("g65amg", "Mercedes G65 AMG")--Mercedes Benz G65
	AddTextEntry("xxxxx", "Mercedes Pickup") --Mercedes Benz Pickup 
	AddTextEntry("s63w222", "Mercedes S63") --Mercedes S63
	AddTextEntry("mb18", "Mercedes S63 Desc") --Mercedes S63 Descapotable
	AddTextEntry("mbenz18", "Mercedes S63 Desc") --Mercedes S63 Descapotable 
	AddTextEntry("RAPTORF150", "Ford Raptor 150 2017") --RAPTOR F-150 
	AddTextEntry("v250", "Mercedes v250") --Mercedes v250
	AddTextEntry("nismo20", "Nissan Nismo 2020") --Nissan Nismo 20
	AddTextEntry("nissantitan", "Nissan Titan 2017") --Nissan Titan 17
	AddTextEntry("titan17", "Nissan Titan 2017") --Nissan Titan 17
	AddTextEntry("peug108", "Peugeot 108") --Peugeot 108
	AddTextEntry("p308", "Peugeot 308") --Peugeot 308
	AddTextEntry("405c", "Peugeot 405") --Peugeot 405
	AddTextEntry("por4s", "Porsche 911 4s") --Porsche 911 4s
	AddTextEntry("cayenne", "Porsche Cayenne") --Porsche Cayenne 
	AddTextEntry("techart17", "Porsche Panamera") --Porsche Panamera 
	AddTextEntry("pacev", "Renault Space") --Renault Space
	AddTextEntry("twingo", "Renault Twingo") --Renault Twingo
	AddTextEntry("dawn", "Rolls Royce Dawn") --Rolls Royce Dawn
	AddTextEntry("suzukigv", "Suzuki GrandVitara") --Suzuki GrandVitara
	AddTextEntry("huntley", "Suzuki GrandVitara") --Suzuki GrandVitara
	AddTextEntry("teslax", "Tesla X") --Tesla X
	AddTextEntry("19tundra", "Toyota Tundra") --Toyota Tundra
	AddTextEntry("amarok", "Volkswagen Amarok") --VW Amarok
	AddTextEntry("fuluxt2", "Volkswagen Combi") --VW Combi
	AddTextEntry("vwstance", "Volkswagen Passat") --VW Passat
	AddTextEntry("vwpolo", "Volkswagen Polo") --VW Polo
	AddTextEntry("fulux63", "Volkswagen Vocho") --VW Vocho
	AddTextEntry("570s2", "Mclaren 570s") --Mclaren 570s
	AddTextEntry("urus", "Lamborghini Urus") --Mclaren 570s 
	AddTextEntry("rs62", "AudiRS6") --Audi RS6
	AddTextEntry("r6", "Yamaha R6") --Yamaha R6
	AddTextEntry("cbtwister", "Honda CB Twister")--Honda CB Twister
	AddTextEntry("69charger", "Dodge Charger") --Dodge Charger
	AddTextEntry("yz450f", "Yamaha z450f") --yz450f  
	AddTextEntry("clubgtr", "BG Club GTR") --clubgtr 
	AddTextEntry("mig", "Ferrari Enzo") --clubgtr 
	AddTextEntry("pistas", "Ferrari 488 Spider") --clubgtr 
	AddTextEntry("pista", "Ferrari 488 Pista") --clubgtr 
	AddTextEntry("huayrar", "Pagani Huayra") --clubgtr 
	AddTextEntry("p1gtr", "Mclaren P1 GTR") --clubgtr 
	AddTextEntry("hevo", "Lamborghini EVO") --clubgtr 
	AddTextEntry("lp700", "Lamborghini Aventador") --clubgtr 
	AddTextEntry("vantage", "Aston Martin Vantage") --clubgtr 
	AddTextEntry("pts21", "Porsche 911 Turbo S") --clubgtr 
	AddTextEntry("fct", "Ferrari California 2015") --clubgtr 
	AddTextEntry("18velar", "Range Rover Velar") --clubgtr 
	AddTextEntry("16cc", "VW Passat") --clubgtr 
	AddTextEntry("pts21", "Porsche 911 Turbo S") --clubgtr 
	AddTextEntry("b5s4", "Audi S4") --clubgtr
	AddTextEntry("m6gc", "BMW M6") --clubgtr  
	AddTextEntry("jeep2012", "Jeep Buggi") --clubgtr 
	AddTextEntry("audquattros", "Porsche 911 Turbo S") --clubgtr
	AddTextEntry("silver67", "Rolls Royce Silver") --clubgtr
	AddTextEntry("trx", "Dodge Ram TRX") --clubgtr
	AddTextEntry("r820", "Audi R8") --Audi R8
	AddTextEntry("fmgt", "Ford Mustang") --Ford Mustang 
	AddTextEntry("hiluxarctic", "Toyota Hilux") --Toyota Hilux
	AddTextEntry("C7", "Chevrolet Corvette 7") --Corvette
	AddTextEntry("g63AMG", "Mercedes Brabus 6x6") --MBrabus
	AddTextEntry("r35", "Nissan GTR R35") --gtr35 
	AddTextEntry("19S650", "Mercedes Benz Maybach") --MB Maybach
	AddTextEntry("16ss", "Chevrolet Camaro SS") --Chevrolet Camaro
	AddTextEntry("velociraptor","Ford Velociraptor") --Velociraptor
	AddTextEntry("2018zl1", "Chevrolet Camaro ZL1") --ZL1
	AddTextEntry("boss429", "Ford Boss 429") --ZL1
	AddTextEntry("ram2500", "Dodge Ram 2500") --ZL1
	AddTextEntry("206sdc", "Peugeot 206") --ZL1
	AddTextEntry("cherokee1", "Cheroke 1984") --ZL1
	AddTextEntry("aperta", "Ferrari LaFerrari") --ZL1
	AddTextEntry("m82020", "BMW M8") --ZL1
	AddTextEntry("vxr", "Toyota Cruiser") --ZL1
	AddTextEntry("cyrus", "Aston Martin Cyrus") --ZL1
	AddTextEntry("m5f90", "BMW M5") --ZL1
	AddTextEntry("rs318", "Audi RS3") --ZL1
	AddTextEntry("rs5r", "Audi RS5") --ZL1
	AddTextEntry("16challenger", "Dodge Challenger R/T") --ZL1
	AddTextEntry("4runner", "Toyota Runner") --ZL1
	AddTextEntry("fd", "Mazda RX7") --ZL1
	AddTextEntry("sorento19", "Kia Sorento") --ZL1
	AddTextEntry("ss69", "Camaro ss69") --ZL1
	AddTextEntry("r50", "VW touareg") --ZL1
	AddTextEntry("g20c", "Chevrolet G20") --ZL1
	AddTextEntry("yaris08", "Toyota Yaris") --ZL1
	AddTextEntry("sp21", "Chevrolet de Policía") --ZL1
	AddTextEntry("rmodbolide", "Bugatti Bolide") --ZL1
	AddTextEntry("fxxk16", "Ferrari FXXK16") --ZL1
	AddTextEntry("huracan", "Lamborghini Huracán") --ZL1
	AddTextEntry("lwalk458", "Ferrari 458 Liberty") --ZL1
	AddTextEntry("lykan", "Lykan Hyper Sport") --ZL1 
	AddTextEntry("duker", "Ktm 1290") --ZL1
	AddTextEntry("golfmk6", "Golf MK6") --ZL1
	AddTextEntry("mt03", "Yamaha MT") --ZL1
	AddTextEntry("traicat", "Jeep Trailcat") --ZL1
	AddTextEntry("audiq8", "Audi Q8") --ZL1
	AddTextEntry("718caymans", "Porsche 718 Caymans") --ZL1
	AddTextEntry("demonhawkk", "Jeep Demonhawk v2") --ZL1
	AddTextEntry("mlnovitec", "Maserati Novitec") --ZL1
	AddTextEntry("evoque", "Range Rover Evoque") --ZL1
	AddTextEntry("tuatara", "Tuatara SSC") --ZL1
	AddTextEntry("vulcanpro19", "Aston Martin Vulcan pro") --ZL1
	AddTextEntry("sls", "Mercedes Benz SLS") --ZL1
	AddTextEntry("italia458", "Ferrari italia 458")
	AddTextEntry("kangoo", "Renauld Kango")
	AddTextEntry("a80", "Toyota Supra")
	AddTextEntry("trailcat", "Jeep Trailcat")
	AddTextEntry("bros60", "Honda Bros")
	AddTextEntry("405glxfn", "Peugeot 405") 
	AddTextEntry("patroly60", "Nissan Patrol Y60")
	AddTextEntry("rmodmartin", "Aston Martin DBs")
	AddTextEntry("bnteam", "Bently Continental Breitling")
	AddTextEntry("g20", "BMW 3 series")
	AddTextEntry("ct5", "Cadillac ct5 350T")
	AddTextEntry("70coronet", "Dodge Coronet")
	AddTextEntry("ldsv", "Lamborghini Diablo")
	AddTextEntry("rmodmk7", "VW Golf MK7")
	AddTextEntry("rmodjeep", "Jeep Trackhawk SRT")
	AddTextEntry("kuda", "Plymouth Barracuda")
	AddTextEntry("rmodspeed", "McLaren SpeedTail")
	AddTextEntry("e63s", "Mercedes Benz e63s AMG")
	AddTextEntry("gls20", "Mercedes Benz GLS")
	AddTextEntry("olds442", "Oldsmobile 442")
	AddTextEntry("godz", "Rolls Royce Cowby")
	AddTextEntry("rs7c8wb", "Audi Rs7")
	AddTextEntry("rmodsianr", "Lamborghini Sian Roadster")
	AddTextEntry("brz13", "Subaru BRZ")
	AddTextEntry("rt70", "Dodge charger R/T")
	AddTextEntry("xt700", "Yahama xt700")
	AddTextEntry("voyager96", "Chrysler Voyager Minivan")
	AddTextEntry("turbo33", "Porsche Turbo 33")
	AddTextEntry("lm002", "Lamborghini LM002")
	AddTextEntry("mcjcw20", "Mini Cooper GT")
	AddTextEntry("mgt", "Ford Mustang GT")
	AddTextEntry("subwrx", "Subaru WRX")
	AddTextEntry("FD2", "Honda Civic TypeR")
	AddTextEntry("gtx", "Plymouth gtx")
	AddTextEntry("rrst", "Range Rover Startech") 
	AddTextEntry("hummer", "Hummer H1")
	AddTextEntry("comet2", "Fiat Claro")
	AddTextEntry("shafie", "Shafie")
	AddTextEntry("720s", "McLaren 720s")
	AddTextEntry("chiron", "Bugatti Chiron")
	AddTextEntry("delsoleg", "Honda delsoleg")
	AddTextEntry("dm1200", "Ducatti dm1200")
	AddTextEntry("fox", "VW fox")
	AddTextEntry("g63", "Mercedes Benz G63")
	AddTextEntry("hvrod", "Harley Dadvinson 240")
	AddTextEntry("moss", "Mercedes Benz Moss")
	AddTextEntry("mqgts", "Maserati Mqgts")
	AddTextEntry("punto", "Fiat Punto")
	AddTextEntry("rc", "KTM rc")
	AddTextEntry("rs6c8", "Audi Rs6 Sedan")
	AddTextEntry("vwsava", "VW saveiro")
	AddTextEntry("rmodf40", "Ferrari f40")
	AddTextEntry("fiestawrc", "Ford Fiesta Hoonigan")
	AddTextEntry("fordhv2", "Ford hv2 Hoonigan")
	AddTextEntry("hermes", "hermes")
	AddTextEntry("kx450f", "Yamaha kx450")
	AddTextEntry("raid", "Dodge Raid")
	AddTextEntry("RAPTOR", "Ford Raptor 2017")
	AddTextEntry("razerx3", "Cam Am Polaris")
	AddTextEntry("rmodspeed", "McLaren Speedtail")
	AddTextEntry("senna", "McLaren Senna")
	AddTextEntry("zx10r", "Kawasaki zx10r")
    AddTextEntry("rmodgtr50", "Nissan GTR 50")
	AddTextEntry("gallalb", "Lamborghini Gallardo LB")
	AddTextEntry("baja", "Volkswagen Beetle")
	AddTextEntry("bugaceto", "Bugatti Centodieci")
	AddTextEntry("rmodmi8lb", "BMW i8 lB")
	AddTextEntry("bvit", "Bugatti Veyron")
	AddTextEntry("terzo", "lamborghini terzo")




 

	
end)